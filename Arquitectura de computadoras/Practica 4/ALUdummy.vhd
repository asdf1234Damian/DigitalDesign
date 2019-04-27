library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
port(
	a, b: in std_logic_vector(15 downto 0);
	mux : in std_logic_vector(3 downto 0);
	flags : out std_logic_vector(3 downto 0);
	o : inout std_logic_vector(15 downto 0)
	);
end entity;

architecture behavioral of ALU is 

begin
 o<= "0000000000000000";
end architecture;        