library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RGB is
  Port ( 
    Din   : in  STD_LOGIC_VECTOR (11 downto 0);  -- niveau de gris du pixels sur 8 bits
    Nblank : in  STD_LOGIC;                      -- signal indique les zone d'affichage, hors la zone d'affichage
    CLK25  : in  STD_LOGIC;  -- horloge de 25 MHz et signal d'activation respectivement
    vsync        : in  STD_LOGIC;                                                -- les trois couleurs prendre 0
    R,G,B   : out  STD_LOGIC_VECTOR (7 downto 0); -- les trois couleurs sur 10 bits
	 address      : out STD_LOGIC_VECTOR (16 downto 0); -- adresse genere
	 ledOut : out std_logic_vector(6 downto 0);
	 filterIn : in std_logic
  );      
end RGB;
	
architecture Behavioral of RGB is
signal val: STD_LOGIC_VECTOR(address'range):= (others => '0'); -- signal intermidiaire
signal red,green,blue,redA,greenA,blueA,redOut,greenOut,blueOut : std_logic_vector(7 downto 0);
signal ledTemp : std_logic_vector(6 downto 0);
signal hCount,vCount : integer:=0;
signal countControl : std_logic;
signal mainCounter : integer:=1;


begin
	address <= val; -- adresse genere
 process(CLK25)
    begin

      if rising_edge(CLK25) then
      
        if (Nblank='1') then           -- si enable = 0 on arrete la generation d'adresses

--          if rez_160x120 = '1' then
--            if (val < 160*120) then    -- si l'espace memoire est balay completement        
--              val <= val + 1 ;
--            end if;
--          elsif rez_320x240 = '1' then
--            if (val < 320*240) then    -- si l'espace memoire est balay completement        
--              val <= val + 1 ;
--            end if;
--          else
--            if (val < 640*480) then    -- si l'espace memoire est balay completement        
--              val <= val + 1 ;
--            end if;
--          end if;


			if (val < (320*240)) then			         
				val <= val + 1 ;
				hCount <= hCount +1;
				if hCount = 320-1 then
					vCount <= vCount + 1;
					hCount <= 0;
				end if;
				
				if vCount = 240-1 then
					countControl <= '1';
					vCount <= -1;
				end if;
				

				if countControl = '1' then 
					
					if redA = "11111111" then
						ledTemp(6) <= '1';
						ledTemp(5 downto 0 ) <= "000000";
					
						countControl <= '0';
					else
						ledTemp(6) <= '0';
					end if;
				else 
--					ledTemp <= "0000000";
					redOut <= redA;
					greenOut <= greenA;
					blueOut <= blueA;
					
				end if;
			end if;
        end if;
        
        if vsync = '0' then 
           val <= (others => '0');
        end if;
        	  
      end if;  
    end process;

  red <= Din(11 downto 8) & Din(11 downto 8) when Nblank='1' else "00000000";
  green <= Din(7 downto 4)  & Din(7 downto 4)  when Nblank='1' else "00000000";
  blue <= Din(3 downto 0)  & Din(3 downto 0)  when Nblank='1' else "00000000";
  
  
  ledOut <= ledTemp;
  
--  redA <= red;
--  greenA <= green;
--  blueA <= blue;
  
  process(red)
	begin

	if (red > "10000000") and (green > "10000000") and (blue > "10000000") then
		redA <= "11111111";
		greenA <= "11111111";
		blueA <= "11111111";
	else
		redA <= "00000000";
		greenA <= "00000000";
		blueA <= "00000000";
	end if;
	
	
	if filterIn = '1' then
			R <= redOut;
			G <= greenOut;
			B <= blueOut;
	else
			R <= red;
			G <= green;
			B <= blue;	
	end if;

	end process;
	

	

  
  
end Behavioral;
