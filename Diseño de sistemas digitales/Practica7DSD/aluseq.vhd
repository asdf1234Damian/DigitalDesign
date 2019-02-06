library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity aluS is
	port(
	s:in std_logic_vector(1 downto 0);
	ena :in std_logic;
	clk_0 : inout std_logic;
	D: in std_logic_vector(3 downto 0);
	Z:out std_logic_vector(4 downto 0)
	);
end entity;
 
architecture comp of aluS is 
	signal AA:std_logic_vector(3 downto 0):="0000";
	COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;

	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "26.60";

begin
OSCInst0 : OSCH GENERIC  MAP("26.60") PORT MAP('0', clk_0);
	regDeLU: process(clk_0)
	begin 
		if(clk_0'event and clk_0='1' and ena ='1') then
			AA<=D;
		end if;
	end process;
	Z<="0"&(AA and D) when s="00" else
			"0"&(AA or D) when s="01" else
			"0"&( not AA) when s="10" else
			(not("0"&AA)+1) when s="11";
end comp;