library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity ejercicio is 
	port(
		clk_0: inout std_logic;
		q: in std_logic_vector(3 downto 0);
		rst: in std_logic;
		blink_LED: out std_logic;
		d: out std_logic_vector(3 downto 0)
	);
end entity;

architecture archEjercicio of ejercicio is 
	COMPONENT OSCH
		GENERIC (NOM_FREQ: string);
		PORT (STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;
	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "26.60";
	signal clk_low: std_logic:= '0'; 
	signal v: std_logic_vector(11 downto 0);
begin 
	OSCInst0 : OSCH GENERIC  MAP("26.60") PORT MAP('0', clk_0);
PIPO: process(clk_low, rst)
begin 
	if rst='0' then 
		v<="000000000000";
		d<="0000";
	elsif (clk_low'event and clk_low='1') then 
		v<=q&v(11 downto 4);
		d<=v(3 downto 0);
	end if;
end process;
P_blink_LED: PROCESS(clk_0)
	VARIABLE count: INTEGER RANGE 0 to 25000000;
	BEGIN 
		IF (clk_0'EVENT AND clk_0='1' )THEN 
			IF(count < 24000000) THEN  
				count := count+1; 
			ELSE
				count :=0; 
				clk_low <= NOT clk_low;
			END IF;
		END IF; 
	END PROCESS; 
	blink_LED<= clk_low;
end architecture;    