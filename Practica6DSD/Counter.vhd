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
	signal clkA, clkB, clkC, clkD: std_logic;
begin 
	OSCInst0 : OSCH GENERIC  MAP("133.00") PORT MAP('0', clk);
	p_ClkA:process (clk) is 	
	variable count: integer range 0 to 33250000;
	begin 
		if(clk'event and clk='1') then 
			if(d<33250000) then 
				count:=count+1;
			else
				count:=0;
				clkA<= not clkA;
			end if;
		end if; 
	end process; 
	
	p_ClkB:process (clk) is 	
	variable count: integer range 0 to 66500000;
	begin 
		if(clk'event and clk='1') then 
			if(d<66500000) then 
				count:=count+1;
			else
				count:=0;
				clkB<= not clkB;
			end if;
		end if; 
	end process; 
	
	p_ClkC:process (clk) is 	
	variable count: integer range 0 to 133000000;
	begin 
		if(clk'event and clk='1') then 
			if(d<133000000) then 
				count:=count+1;
			else
				count:=0;
				clkC <= not clkC;
			end if;
		end if; 
	end process; 
	
	p_clkD:process (clk) is 	
	variable count: integer range 0 to 166250000;
	begin 
		if(clk'event and clk='1') then 
			if(d<166250000) then 
				count:=count+1;
			else
				count:=0;
				clkD <= not clkD;
			end if;
		end if; 
	end process; 
	
	
	mux:process (clk)is 
	begin 
		case (sel) is  
			when "00" => o <= clkA; 
			when "01" => o <= clkB;
			when "10" => o <= clkC;
			when "11" => o <= clkD; 
			when others => o <= '0' ;
		end case;
	end process;
end architecture;    