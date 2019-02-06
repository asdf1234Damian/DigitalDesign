library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity aluC is
	port(
	s:in std_logic_vector(1 downto 0);
	A,B: in std_logic_vector(2 downto 0);
	Z:out std_logic_vector(3 downto 0)
	);
end entity;

architecture comp of aluC is 
begin
	Z<="0"&(A and B) when s="00" else
		"0"&(A or B) when s="01" else
		"0"&( not A) when s="10" else
		(not("0"&A) + 1) when s="11";
end comp;