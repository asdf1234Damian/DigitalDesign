library ieee;
use ieee.std_logic_1164.all;
entity Mux8a1 is 
port(
	s8: in std_logic_vector(2 downto 0);
	a8: in std_logic_vector(7 downto 0);
	o8: out std_logic
	);
end entity; 

architecture arch_Mux8a1 of Mux8a1 is
component  Mux4a1 is
port(
	s0,s1,a0,a1,a2,a3: in std_logic;
  o: out std_logic
);


end component; 
signal os : std_logic_vector(1 downto 0);
begin   
m1: Mux4a1 port map(s8(0),s8(1), a8(0),a8(1),a8(2),a8(3), os(0));
m2: Mux4a1 port map(s8(0),s8(1), a8(4),a8(5),a8(6),a8(7), os(1));
m3: Mux4a1 port map(s8(2),s8(2), os(0),os(0),os(0),os(1), o8); 
end architecture;   