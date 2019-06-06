library ieee;
use ieee.std_logic_1164.all;

entity divFreq is generic(
	div : integer := 1
	);
	port(
	osc : in std_logic;
	clk: inout std_logic
	); 
end entity; 

architecture behavioral of divFreq is 
begin
	process(osc)
	variable count: integer range 0 to div;
	begin
		if (osc'event and osc = '1' ) then
			if (count < div) then				
				count := count + 1;
			else
				count :=0; 
				clk <= not clk;
			end if;
		end if;
	end process;
end architecture;  