LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.std_logic_arith.all;

ENTITY FREQ_LOOKUP_TABLE IS
		PORT( sel : IN STD_LOGIC_VECTOR(6	downto 0);
				F : out STD_LOGIC_VECTOR(15 downto 0);
				CLK: IN STD_LOGIC);
END FREQ_LOOKUP_TABLE;

ARCHITECTURE Structure OF FREQ_LOOKUP_TABLE IS
		SIGNAL note : integer := 0;
		signal selTemp : std_logic_vector(6 downto 0);

BEGIN
	PROCESS(CLK)
	BEGIN
	
	if (rising_edge(CLK)) then 
		if sel(6) = '1' then
			note <= 988;
		elsif sel(5) = '1' then
			note <= 880;
		elsif sel(4) = '1' then
			note <= 784;
		elsif sel(3) = '1' then
			note <= 698;
		elsif sel(2) = '1' then
			note <= 659;
		elsif sel(1) = '1' then
			note <= 587;
		elsif sel(0) = '1' then
			note <= 1046;
		else 
			note <= 0;
		end if;
	end if;

		F <= conv_std_logic_vector(note, 16);
	END PROCESS;
END STRUCTURE;	