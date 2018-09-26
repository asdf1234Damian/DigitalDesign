library ieee;
use ieee.std_logic_1164.all;

entity Mux4a1 is
port(
	s : in std_logic_vector(1 downto 0);
	a : in std_logic_vector (3 downto 0);
	o : out std_logic
);
end entity; 

architecture arch_Mux4a1 of Mux4a1 is
begin 
process (s)
begin
case s is 
	when "00" => o <=a(0);
	when "01" => o <=a(1);
	when "10" => o <=a(2);
	when others => o <=a(3);
end case;
end process;
end architecture;