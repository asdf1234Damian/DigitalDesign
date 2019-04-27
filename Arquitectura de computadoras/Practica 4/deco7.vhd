library ieee;
use ieee.std_logic_1164.all;

entity deco7 is 
	port(
	a: in std_logic_vector(4 downto 0);
	disp: out std_logic_vector(7 downto 0)
	);
end entity;

architecture behavioral of deco7 is 
	Constant Dig0: std_logic_vector(7 downto 0) := "11111100";
	Constant Dig1: std_logic_vector(7 downto 0) := "01100000";
	Constant Dig2: std_logic_vector(7 downto 0) := "11011010";
	Constant Dig3: std_logic_vector(7 downto 0) := "11110010";
	Constant Dig4: std_logic_vector(7 downto 0) := "01100110";
	Constant Dig5: std_logic_vector(7 downto 0) := "10110110";
	Constant Dig6: std_logic_vector(7 downto 0) := "10111110";
	Constant Dig7: std_logic_vector(7 downto 0) := "11100000";
	Constant Dig8: std_logic_vector(7 downto 0) := "11111110";
	Constant Dig9: std_logic_vector(7 downto 0) := "11110110";
	Constant ChrA: std_logic_vector(7 downto 0) := "11101110";
	Constant ChrH: std_logic_vector(7 downto 0) := "01101110";
	Constant ChrL: std_logic_vector(7 downto 0) := "00011100";
	Constant ChrE: std_logic_vector(7 downto 0) := "10011110";
	Constant ChrC: std_logic_vector(7 downto 0) := "10011100";
	Constant Chrr: std_logic_vector(7 downto 0) := "00001010";
	Constant Chrn: std_logic_vector(7 downto 0) := "00101010";
	Constant Chrb: std_logic_vector(7 downto 0) := "00111110";
	Constant Chry: std_logic_vector(7 downto 0) := "01110110";
	constant dash: std_logic_vector(7 downto 0) := "00000010";
	constant dot : std_logic_vector(7 downto 0) := "00000001";
	Constant Apag: std_logic_vector(7 downto 0) := "00000000";
begin 
disp <= dig0 when a = "00000" else 
		dig1 when a = "00001" else 
		dig2 when a = "00010" else 
		dig3 when a = "00011" else 
		dig4 when a = "00100" else 
		dig5 when a = "00101" else 
		dig6 when a = "00110" else  
		dig7 when a = "00111" else 
		dig8 when a = "01000" else   
		dig9 when a = "01001" else 
		ChrA when a = "10001" else 
		ChrH when a = "10010"else
		ChrL when a = "10011" else
		ChrE when a = "10100" else
		Chrr when a = "10101" else
		Chrn when a = "10110" else
		Chrb when a = "10111" else
		Chry when a = "11000" else
		ChrC when a = "11001" else
		dot  when a = "11110" else
		dash when a = "11111" else
		apag ;
end architecture;