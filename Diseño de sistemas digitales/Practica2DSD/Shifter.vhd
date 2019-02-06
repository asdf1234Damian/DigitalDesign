library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity Shifter is
port(
	shift, clk: in std_logic;
	pn: in std_logic_vector(3 downto 0);
	q: inout std_logic_vector(3 downto 0)
	);
end entity;

architecture archShifter of Shifter is
begin 
process (shift, clk) 
begin
if(clk='1') then 
	if(shift='0') then 
		q<=q(0) & q(3 downto 1);
	else
		q<=pn;
	end if;
	else
	q<=q;
end if;
end process;
end architecture;