library ieee;
use ieee.std_logic_1164.all;

entity divFreq is 
	port(
	osc : in std_logic;
	clk: inout std_logic
	);
end entity; 

architecture behavioral of divFreq is 
CONSTANT MAXCOUNT: integer := 20;
begin
	process(osc)
	variable count: integer range 0 to MAXCOUNT;
	begin  
		if (osc'event and osc = '1' ) then
			if (count < MAXCOUNT) then				
				count := count + 1;
			else
				count :=0;
				clk <= not clk;
			end if;
		end if;
	end process;
end architecture;      