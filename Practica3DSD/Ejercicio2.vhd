library ieee;
use ieee.std_logic_1164.all;

entity SISO is 
port(
	D,clk : in std_logic;
	Q: out  std_logic
);
end entity;

architecture archSISO of SISO is 
signal Dn : std_logic_vector(7 downto 0);
begin 
--Dn <="00000000";
	process (clk)
	begin 
		if(clk'event and clk='1') then 
			Dn <= D & Dn(7 downto 1);
		else
			Dn <=Dn;
		end if;  
	end process;
	Q<=Dn(0);
end architecture;
