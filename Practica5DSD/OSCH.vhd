library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contadorBCD is
	port(
	selector : in std_logic_vector(1 downto 0);
	D,C,B,A,TL,enablew: in std_logic;
	clk_0: inout std_logic;
	displayud: out std_logic_vector(3 downto 0);
	load, load2, load3, reset: in std_logic;
	data: in std_logic_vector(3 downto 0);
	conta: out std_logic_vector(3 downto 0);
	off_LED: out std_logic_vector(2 downto 0);
	da,db,dc,dd,de,df,dg,sec1: out std_logic;
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
	signal clk2_low: std_logic:= '0';
	signal s_count: std_logic_vector(3 downto 0);
	signal s_countd: std_logic_vector(3 downto 0);
	signal s_countc: std_logic_vector(3 downto 0);
	signal s_countm : std_logic_vector(3 downto 0);
	signal DATO: std_logic_vector(3 downto 0);
	signal OCHO: std_logic_vector(3 downto 0);
	signal DATO_DECO: std_logic_vector(3 downto 0);
	signal b1 : std_logic;
	signal b2 : std_logic;
	signal b3 : std_logic;
	signal display : std_logic_vector(6 downto 0);
	signal display2 : std_logic_vector(6 downto 0);
	signal display3 : std_logic_vector(6 downto 0);
	signal display4 : std_logic_vector(6 downto 0);
	signal displays : std_logic_vector(1 downto 0);
	signal complemento : std_logic_vector(3 downto 0);
begin
OSCInst0 : OSCH GENERIC  MAP("26.60") PORT MAP('0', clk_0);
off_LED<= "000";

DATO(3) <= D;
DATO(2) <= C;
DATO(1) <= B;
DATO(0) <= A;
OCHO <= "1000";

 multiplexor: process(DATO,OCHO,TL,DATO_DECO)
	begin
		if (enablew = '1') then
			if (TL = '0') then
				DATO_DECO <= OCHO;
			else
				DATO_DECO <= DATO;
		end if;
	end if;
end process multiplexor;

decoder: process (s_countd,display)
	begin
	case s_countd is
	when "0000" => display <= "1111110";
	when "0001" => display <= "0110000";
	when "0010" => display <= "1101101";
	when "0011" => display <= "1111001";
	when "0100" => display <= "0110011";
	when "0101" => display <= "1011011";
	when "0110" => display <= "1011111";
	when "0111" => display <= "1110000";
	when "1000"	=> display <= "1111111";
	when "1001"	=> display <= "1111011";
	when "1010"	=> display <= "1110111";
	when "1011"	=> display <= "0011111";
	when "1100"	=> display <= "1001110";
	when "1101"	=> display <= "0111101";
	when "1110"	=> display <= "1001111";
	when others	=> display <= "1000111";
	end case;
end process decoder;

decoder2: process (s_count,display2)
	begin
	case s_count is
	when "0000" => display2 <= "1111110";
	when "0001" => display2 <= "0110000";
	when "0010" => display2 <= "1101101";
	when "0011" => display2 <= "1111001";
	when "0100" => display2 <= "0110011";
	when "0101" => display2 <= "1011011";
	when "0110" => display2 <= "1011111";
	when "0111" => display2 <= "1110000";
	when "1000"	=> display2 <= "1111111";
	when "1001"	=> display2 <= "1111011";
	when "1010"	=> display2 <= "1110111";
	when "1011"	=> display2 <= "0011111";
	when "1100"	=> display2 <= "1001110";
	when "1101"	=> display2 <= "0111101";
	when "1110"	=> display2 <= "1001111";
	when others	=> display2 <= "1000111";
	end case;
end process decoder2;

decoder3: process (s_countc,display3)
	begin
	case s_countc is
	when "0000" => display3 <= "1111110";
	when "0001" => display3 <= "0110000";
	when "0010" => display3 <= "1101101";
	when "0011" => display3 <= "1111001";
	when "0100" => display3 <= "0110011";
	when "0101" => display3 <= "1011011";
	when "0110" => display3 <= "1011111";
	when "0111" => display3 <= "1110000";
	when "1000"	=> display3 <= "1111111";
	when "1001"	=> display3 <= "1111011";
	when "1010"	=> display3 <= "1110111";
	when "1011"	=> display3 <= "0011111";
	when "1100"	=> display3 <= "100	1110";
	when "1101"	=> display3 <= "0111101";
	when "1110"	=> display3 <= "1001111";
	when others	=> display3 <= "1000111";
	end case;
end process decoder3;

decoder4: process (s_countm,display4)
	begin
	case s_countm is
	when "0000" => display4 <= "1111110";
	when "0001" => display4 <= "0110000";
	when "0010" => display4 <= "1101101";
	when "0011" => display4 <= "1111001";
	when "0100" => display4 <= "0110011";
	when "0101" => display4 <= "1011011";
	when "0110" => display4 <= "1011111";
	when "0111" => display4 <= "1110000";
	when "1000"	=> display4 <= "1111111";
	when "1001"	=> display4 <= "1111011";
	when "1010"	=> display4 <= "1110111";
	when "1011"	=> display4 <= "0011111";
	when "1100"	=> display4 <= "1001110";
	when "1101"	=> display4 <= "0111101";
	when "1110"	=> display4 <= "1001111";
	when others	=> display4 <= "1000111";
	end case;
end process decoder4;

contaBCD: process(clk_low,reset)
	begin
	if (selector= "00" and enablew = '1') then
		s_count <= data;
	elsif reset='1' then
		s_count <="0000";
	elsif (clk_low'event and clk_low='1') then
		--if load='1' then--
			--s_count<=da