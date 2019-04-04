library ieee;
use ieee.std_logic_1164.all;

entity deco7 is 
	port(
	a: in std_logic_vector(3 downto 0);
	disp: out std_logic_vector(6 downto 0)
	);
end entity;

architecture behavioral of deco7 is 
	Constant Dig0: std_logic_vector(6 downto 0) := "1111110";
	Constant Dig1: std_logic_vector(6 downto 0) := "0110000";
	Constant Dig2: std_logic_vector(6 downto 0) := "1101101";
	Constant Dig3: std_logic_vector(6 downto 0) := "1111001";
	Constant Dig4: std_logic_vector(6 downto 0) := "0110011";
	Constant Dig5: std_logic_vector(6 downto 0) := "1011011";
	Constant Dig6: std_logic_vector(6 downto 0) := "1011111";
	Constant Dig7: std_logic_vector(6 downto 0) := "1110000";
	Constant Dig8: std_logic_vector(6 downto 0) := "1111111";
	Constant Dig9: std_logic_vector(6 downto 0) := "1111011";
	Constant Apag: std_logic_vector(6 downto 0) := "0000000";
	Constant dash: std_logic_vector(6 downto 0) := "0000001"; 
begin 
disp <= dig0 when a = "0000" else 
		dig1 when a = "0001" else 
		dig2 when a = "0010" else 
		dig3 when a = "0011" else 
		dig4 when a = "0100" else 
		dig5 when a = "0101" else 
		dig6 when a = "0110" else 
		dig7 when a = "0111" else 
		dig8 when a = "1000" else 
		dig9 when a = "1001" else 
		dash when a = "1111" else
		apag;
end architecture;