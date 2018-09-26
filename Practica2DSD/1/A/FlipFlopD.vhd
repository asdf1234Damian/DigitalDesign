library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity FFD is
port(
	d,clk: in std_logic;
	q,nq:out std_logic
	);
end entity;

architecture archFFD of FFD is
begin 
	process (clk)
	begin
		if(clk'event and clk='1') then 
			q <= d;
		end if;
	end process;
end architecture;