library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter is 
port(
	clk: inout std_logic; 
	sel: in std_logic_vector(1 downto 0);
	o: out std_logic
);
end entity;

architecture arch_counter of Counter is
	COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;

	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "133.00";
	signal d: std_logic_vector(27 downto 0);
begin 
	OSCInst0 : OSCH GENERIC  MAP("133.00") PORT MAP('0', clk);
	counter:process (clk) is 	
	begin 
		if(clk'event and clk='1') then 
			if(d="11111111111111111111111111111") then 
				d<="0000000000000000000000000000";
			else
				d<=d+1;
			end if;
		end if; 
	end process; 
	
	
	mux:process (clk)is 
	begin 
		case (sel) is 
			when "00" => o <= d(25); --f=53.2=2hz
			when "01" => o <= d(24);
			when "10" => o <= d(23);
			when "11" => o <= d(22); 
			when others => o <= '0';
		end case;
	end process;
end architecture;    