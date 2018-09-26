library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity contadorBCD is 
	port(
		clk_0: inout std_logic;
		load, reset, arriba: in std_logic;
		data: in std_logic_vector(3 downto 0);
		conta: out std_logic_vector(3 downto 0);
		off_LED: out std_logic_vector(2 downto 0);
		blink_LED: out std_logic
	);
end contadorBCD;

architecture test_osc of contadorBCD is 
	
	COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;
	 
	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "26.60";
	
	signal clk_low: std_logic:= '0'; 
	
	signal s_count: std_logic_vector(3 downto 0 ); 
begin 
	OSCInst0 : OSCH GENERIC  MAP("26.60") PORT MAP('0', clk_0);

off_LED<= "000";

contaBCD: process(clk_low,reset)
	begin 
	if reset='1' then 
		s_count <="0000";
	elsif (clk_low'event and clk_low='1') then 
		if load='1' then 
			s_count<=data;
		elsif arriba='1' then 
			if s_count= "1001" then 
				s_count<="0000";
			else
				s_count <=s_count+1;
			end if;  
		else
			if s_count ="0000" then
				s_count<="1001";
			else
				s_count <=s_count-1;
			end if; 
		end if; 
	end if ;
end process;
conta <=s_count;
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
	END PROCESS; 	blink_LED<= clk_low;end test_osc;