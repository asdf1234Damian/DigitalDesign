library ieee;
use ieee.std_logic_1164.all;

entity SIPO is 
port(
	D,clk : in std_logic;
	Qn: inout  std_logic_vector(7 downto 0)
);
end entity;

architecture archSIPO of SIPO is 
begin 
--Dn <="00000000";
	process (clk) 
	begin 
		if(clk'event and clk='1') then 
			Qn <= D & Qn(7 downto 1);
		else
			Qn <=Qn;
		end if;  
	end process;
end architecture;
