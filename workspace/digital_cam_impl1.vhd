-- cristinel ababei; Jan.29.2015; CopyLeft (CL);
-- code name: "digital cam implementation #1";
-- project done using Quartus II 13.1 and tested on DE2-115;
--
-- this design basically connects a CMOS camera (OV7670 module) to
-- DE2-115 board; video frames are picked up from camera, buffered
-- on the FPGA (using embedded RAM), and displayed on the VGA monitor,
-- which is also connected to the board; clock signals generated
-- inside FPGA using ALTPLL's that take as input the board's 50MHz signal
-- from on-board oscillator; 
--
-- this whole project is an adaptation of Mike Field's original implementation 
-- that can be found here:
-- http://hamsterworks.co.nz/mediawiki/index.php/OV7670_camera

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity digital_cam_impl1 is
  Port ( clk_50 : in  STD_LOGIC;
    btn_resend          : in  STD_LOGIC;
    led_config_finished : out STD_LOGIC;

    vga_hsync : out  STD_LOGIC;
    vga_vsync : out  STD_LOGIC;
    vga_r     : out  STD_LOGIC_vector(7 downto 0);
    vga_g     : out  STD_LOGIC_vector(7 downto 0);
    vga_b     : out  STD_LOGIC_vector(7 downto 0);
    vga_blank_N : out  STD_LOGIC;
    vga_sync_N  : out  STD_LOGIC;
    vga_CLK     : out  STD_LOGIC;

    ov7670_pclk  : in  STD_LOGIC;
    ov7670_xclk  : out STD_LOGIC;
    ov7670_vsync : in  STD_LOGIC;
    ov7670_href  : in  STD_LOGIC;
    ov7670_data  : in  STD_LOGIC_vector(7 downto 0);
    ov7670_sioc  : out STD_LOGIC;
    ov7670_siod  : inout STD_LOGIC;
    ov7670_pwdn  : out STD_LOGIC;
    ov7670_reset : out STD_LOGIC;
	 
	 
	 	 TD_CLK27			     		          : 	IN std_logic;
		 AUD_ADCDAT 								 : 	IN std_logic;
		 AUD_ADCLRCK, AUD_BCLK					 :		OUT std_logic;
		 AUD_DACLRCK								 :		INOUT std_logic;
		 AUD_DACDAT, AUD_XCK 					 : 	OUT std_logic;
		 SW											 : 	IN std_logic_vector(17 DOWNTO 0);
		 KEY											 :		IN std_logic_vector(3 downto 0);
		 I2C_SCLK 									 : 	out std_logic;
		 I2C_SDAT 								    :	   inout std_logic;
	 
	 ledOut : out std_logic_vector(6 downto 0);
	 filterIn : in std_logic
  );
end digital_cam_impl1;


architecture my_structural of digital_cam_impl1 is

COMPONENT  adio_codec IS
		PORT(oAUD_DATA, oAUD_LRCK 	: out std_logic;
			  oAUD_BCK					:out std_logic;
			  key1_on, key2_on,
			  key3_on, key4_on						: in std_logic;
			  iSrc_Select						: in std_logic_vector(1 DOWNTO 0);				
			  iCLK_18_4, iRST_N				: in std_logic;
			  sound1, sound2,
			  sound3, sound4					:in std_logic_vector(15 DOWNTO 0);
		     instru								:in std_logic);
	END COMPONENT;
	
	COMPONENT VGA_Audio_PLL IS
		PORT(areset, inclk0 : in std_logic;
			  c0, c1, c2     : out std_logic);
	END COMPONENT;

	
	COMPONENT FREQ_LOOKUP_TABLE IS
		PORT( sel : IN STD_LOGIC_VECTOR(6 downto 0);
				F : out STD_LOGIC_VECTOR(15 downto 0);
				CLK : in std_logic
					);
	END COMPONENT;
	
		COMPONENT I2C_AV_Config IS
		PORT(iCLK : in std_logic;
			  iRST_N : in std_logic;
			  o_I2C_END, I2C_SCLK : out std_logic;
			  I2C_SDAT : inout std_logic);
	END COMPONENT;

	SIGNAL sound1 : std_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL AUD_CTRL_CLK : std_logic;
	SIGNAL I2C_END : std_logic;

  COMPONENT VGA
  PORT(
    CLK25 : IN std_logic;    
    Hsync : OUT std_logic;
    Vsync : OUT std_logic;
    Nblank : OUT std_logic;      
    clkout : OUT std_logic;
    activeArea : OUT std_logic;
    Nsync : OUT std_logic
    );
  END COMPONENT;

  COMPONENT ov7670_controller
  PORT(
    clk : IN std_logic;
    resend : IN std_logic;    
    siod : INOUT std_logic;      
    config_finished : OUT std_logic;
    sioc : OUT std_logic;
    reset : OUT std_logic;
    pwdn : OUT std_logic;
    xclk : OUT std_logic
    );
  END COMPONENT;

  COMPONENT frame_buffer
  PORT(
    data : IN std_logic_vector(11 downto 0);
    rdaddress : IN std_logic_vector(16 downto 0);
    rdclock : IN std_logic;
    wraddress : IN std_logic_vector(16 downto 0);
    wrclock : IN std_logic;
    wren : IN std_logic;          
    q : OUT std_logic_vector(11 downto 0)
    );
  END COMPONENT;

  COMPONENT ov7670_capture
  PORT(
    pclk : IN std_logic;
    vsync : IN std_logic;
    href : IN std_logic;
    d : IN std_logic_vector(7 downto 0);          
    addr : OUT std_logic_vector(16 downto 0);
    dout : OUT std_logic_vector(11 downto 0);
    we : OUT std_logic
    );
  END COMPONENT;

  COMPONENT RGB
  PORT(
    Din : IN std_logic_vector(11 downto 0);
    Nblank : IN std_logic;          
	 CLK25       : IN  std_logic;
	 vsync       : in  STD_LOGIC;
    R : OUT std_logic_vector(7 downto 0);
    G : OUT std_logic_vector(7 downto 0);
    B : OUT std_logic_vector(7 downto 0);
	 ledOut : out std_logic_vector(6 downto 0);
	 filterIn : in std_logic
    );
  END COMPONENT;

  -- DE2-115 board has an Altera Cyclone V E, which has ALTPLL's'
  COMPONENT my_altpll
  PORT (
    inclk0 : IN STD_LOGIC := '0';
    c0     : OUT STD_LOGIC ;
    c1     : OUT STD_LOGIC 
    );
  END COMPONENT;

  COMPONENT Address_Generator
  PORT(
    CLK25       : IN  std_logic;
    enable      : IN  std_logic;       
    vsync       : in  STD_LOGIC;
    address     : OUT std_logic_vector(16 downto 0)
    );
  END COMPONENT;
  
  component clockDivider is 

port
	(
		clock50M 	:	in std_logic;
		clock1Hz		:	out std_logic
	);
	
end component;



  signal clk_50_camera : std_logic;
  signal clk_25_vga    : std_logic;
  signal wren       : std_logic;
  signal resend     : std_logic;
  signal nBlank     : std_logic;
  signal vSync      : std_logic;

  signal wraddress  : std_logic_vector(16 downto 0);
  signal wrdata     : std_logic_vector(11 downto 0);   
  signal rdaddress  : std_logic_vector(16 downto 0);
  signal rddata     : std_logic_vector(11 downto 0);
  signal red,green,blue : std_logic_vector(7 downto 0);
  signal activeArea : std_logic;
  signal Sound 	  : std_logic_vector(6 downto 0);
  signal clk1       : std_logic;

begin


  vga_r <= red(7 downto 0);
  vga_g <= green(7 downto 0);
  vga_b <= blue(7 downto 0);
  
  
   

  Inst_vga_pll: my_altpll PORT MAP(
    inclk0 => clk_50,
    c0 => clk_50_camera,
    c1 => clk_25_vga
  );    
    
    
  -- take the inverted push button because KEY0 on DE2-115 board generates
  -- a signal 111000111; with 1 with not pressed and 0 when pressed/pushed;
  resend <= not btn_resend;
  vga_vsync <= vsync;
  vga_blank_N <= nBlank;
  
  Inst_VGA: VGA PORT MAP(
    CLK25      => clk_25_vga,
    clkout     => vga_CLK,
    Hsync      => vga_hsync,
    Vsync      => vsync,
    Nblank     => nBlank,
    Nsync      => vga_sync_N,
    activeArea => activeArea
  );

  Inst_ov7670_controller: ov7670_controller PORT MAP(
    clk             => clk_50_camera,
    resend          => resend,
    config_finished => led_config_finished,
    sioc            => ov7670_sioc,
    siod            => ov7670_siod,
    reset           => ov7670_reset,
    pwdn            => ov7670_pwdn,
    xclk            => ov7670_xclk
  );
   
  Inst_ov7670_capture: ov7670_capture PORT MAP(
    pclk  => ov7670_pclk,
    vsync => ov7670_vsync,
    href  => ov7670_href,
    d     => ov7670_data,
    addr  => wraddress,
    dout  => wrdata,
    we    => wren
  );

  Inst_frame_buffer: frame_buffer PORT MAP(
    rdaddress => rdaddress,
    rdclock   => clk_25_vga,
    q         => rddata,      
    wrclock   => ov7670_pclk,
    wraddress => wraddress(16 downto 0),
    data      => wrdata,
    wren      => wren
  );
  
  Inst_RGB: RGB PORT MAP(
    Din => rddata,
	 CLK25 => clk_25_vga,
    Nblank => activeArea,
	 vsync => vsync,
    R => red,
    G => green,
    B => blue,
	 ledOut => Sound,
	 filterIn => filterIn
	 );

  Inst_Address_Generator: Address_Generator PORT MAP(
    CLK25 => clk_25_vga,
    enable => activeArea,
    vsync => vsync,
    address => rdaddress
  );

  		--I2C

	CONF1 : I2C_AV_Config PORT MAP(
			iCLK	=> clk_50,
			iRST_N	=>  KEY(0) ,
			o_I2C_END => I2C_END ,
			I2C_SCLK => I2C_SCLK ,
			I2C_SDAT	=> I2C_SDAT );
			

   --AUDIO SOUND
	AUD_ADCLRCK	<=	AUD_DACLRCK;
	AUD_XCK	   <=	AUD_CTRL_CLK;			
		
	  --AUDIO PLL
	PLL1 : VGA_Audio_PLL PORT MAP(
			areset =>( NOT I2C_END) ,
			inclk0 => TD_CLK27 ,
			c1	=> AUD_CTRL_CLK);			

	
	SY1 : adio_codec PORT MAP(	
	
		oAUD_DATA => AUD_DACDAT,
	   oAUD_LRCK => AUD_DACLRCK,			
		oAUD_BCK => AUD_BCLK,
		iCLK_18_4 => AUD_CTRL_CLK,
		iRST_N	 => KEY(0),							
		iSrc_Select => "00",		
		key1_on => '1',	
		key2_on => '0',
		key3_on => '0',
		key4_on => '0',
		sound1 => sound1,					
		sound2 => (others => '0'),					
		sound3 => (others => '0'),					
		sound4 => (others => '0'),												
		instru => SW(17));
		
		
		
	divid : clockDivider port map (clk_50, clk1);
	

  FLT1 : FREQ_LOOKUP_TABLE PORT MAP(Sound, sound1,clk1);		--	SW(3 downto 1)
  ledOut<=Sound;
  
end my_structural;
