library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clockDivider is 

port
	(
		clock50M 	:	in std_logic;
		clock1Hz		:	out std_logic
	);
	
end entity;


architecture behaviour of clockDivider is 

signal counter 	: integer:=1;
signal temp			: std_logic := '0';


begin

process(clock50M)
begin
		
	if(rising_edge(clock50M)) then
--		if counter = 50000000 then
		if counter = 5000000 then
--		if counter = 4 then
			counter <= 1;
			temp <= not temp;
		else
			counter <= counter + 1;
		end if;
	end if;
clock1Hz <= temp;
end process;


end behaviour;	