-- Import logic primitives
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY synth IS
port (
		 CLOCK_50,TD_CLK27			     		 : 	IN std_logic;
		 AUD_ADCDAT 								 : 	IN std_logic;
		 AUD_ADCLRCK, AUD_BCLK					 :		OUT std_logic;
		 AUD_DACLRCK								 :		INOUT std_logic;
		 AUD_DACDAT, AUD_XCK 					 : 	OUT std_logic;
		 SW											 : 	IN std_logic_vector(17 DOWNTO 0);
		 KEY											 :		IN std_logic_vector(3 downto 0);
		 I2C_SCLK 									 : 	out std_logic;
		 I2C_SDAT 								    :	   inout std_logic
			); 
end synth;

ARCHITECTURE Structure of synth is
	--declare all components to be used
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
		PORT( sel : IN STD_LOGIC_VECTOR(2 downto 0);
				F : out STD_LOGIC_VECTOR(15 downto 0)
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

	
BEGIN
			--I2C

	CONF1 : I2C_AV_Config PORT MAP(
			iCLK	=> CLOCK_50,
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


	FLT1 : FREQ_LOOKUP_TABLE PORT MAP(SW(2 downto 0), sound1);

END STRUCTURE;
