LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY PRAC1 IS PORT(
	A,B,C,D,SEL,REF: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	dmux : inout  std_logic_vector(3 downto 0);
	DISP: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	clk : inout std_logic;
	AUX2 : OUT STD_LOGIC
	
	);
END ENTITY;

ARCHITECTURE A_PRAC1 OF PRAC1 IS
	component OSCH
	generic(NOM_FREQ: string);
	port(
	STDBY: in std_logic;
	OSC: out std_logic
	); 
	end component; 
	SIGNAL DATO:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL AUX:STD_LOGIC_VECTOR(2 DOWNTO 0); 
	SIGNAL SIGOSC,MUXCLK : STD_LOGIC;
	signal simbolo: std_logic_vector(6 downto 0);
	CONSTANT VEL: string := "2.08";
	attribute NOM_FREQ: string; 
	attribute NOM_FREQ of oschins : label is VEL; 
	CONSTANT MAYOR:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1111000";
	CONSTANT MENOR:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1001110"; 
	CONSTANT IGUAL:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1001000"; 
	CONSTANT digt0:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1111110"; 
	CONSTANT digt1:STD_LOGIC_VECTOR(6 DOWNTO 0):= "0110000"; 
	CONSTANT digt2:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1101101"; 
	CONSTANT digt3:STD_LOGIC_VECTOR(6 DOWNTO 0):= "1111000"; 
	BEGIN
		AUX2 <= '1'; 
		WITH SEL SELECT 
		DATO <= A WHEN "00", 
				B WHEN "01",
				C WHEN "10",
				D WHEN OTHERS;
		AUX<="100" WHEN (DATO>REF) ELSE 
			 "010" WHEN (DATO<REF) ELSE
			 "001";
		WITH AUX SELECT
			simbolo <= MAYOR WHEN "100",
					   MENOR WHEN "010",
					   IGUAL WHEN "001",
					   "0000000" WHEN OTHERS; 
	
	divfreq: process(sigosc) 
		variable count: integer range 0 to 20;
	begin
		if (sigosc'event and sigosc = '1' ) then
			if (count < 20) then				
				count := count + 1;
			else
				count :=0;
				clk <= not clk;
			end if;
		end if; 
	end process; 	  

	mux : process (clk)
	begin
	if clk'event then 
		dmux <= dmux(2 downto 0) & dmux(3); 
	end if;
		case dmux is 
		when "0100" =>  
			case dato is  
				when "00" => disp <=digt0;
				when "01" => disp <=digt1;
				when "10" => disp <=digt2;
				when others => disp <=digt3; 
			end case; 
		when "0010" => disp <= simbolo; 
		when "0001" => 
			case ref is  
				when "00" => disp <=digt0;
				when "01" => disp <=digt1; 
				when "10" => disp <=digt2; 
				when others => disp <=digt3; 
			end case;
		when others => disp <= "0000000";
		end case;
	end process;
	oschIns: OSCH generic map(VEL) port map('0', sigOSC); 
END A_PRAC1; 