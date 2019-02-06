library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter is 
port(
	clk: inout std_logic; 
	data: inout std_logic_vector (25 downto 0)
	--sel: in std_logic_vector(1 downto 0);
	--o: out std_logic
);
end entity;

architecture arch_counter of Counter is
	COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;

	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "53.20";
	signal d: std_logic_vector(25 downto 0);
	--signal clkA, clkB, clkC, clkD: std_logic;
begin 
	OSCInst0 : OSCH GENERIC  MAP("53.20") PORT MAP('0', clk);
	
	p_ClkA:process (clk) is 	
	begin 
		if(clk'event and clk='1') then 
			if(d="11111111111111111111111111") then 
				d<="00000000000000000000000000";
			else
				d<=d+1;
			end if;
		end if; 
		data<=d;
	end process; 
	
end architecture;    