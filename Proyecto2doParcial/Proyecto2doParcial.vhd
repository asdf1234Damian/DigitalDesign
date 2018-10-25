library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ALU is 
port(
clk_0:inout std_logic;
mux: inout std_logic_vector(3 downto 0 );
a,b: in std_logic_vector(9 downto 0);
sel: in std_logic_vector(3 downto 0);
disp: out std_logic_vector(6 downto 0);
slog: out std_logic_vector(9 downto 0)
);
end entity;
architecture comp of ALU is
signal sum_resta: std_logic_vector(8 downto 0):="000000000";
signal cociente:std_logic_vector(7 downto 0):="00000000";
signal division:std_logic_vector(7 downto 0):="00000000";
signal residuo:std_logic_vector(7 downto 0):="00000000";
signal num_bcd:std_logic_vector(11 downto 0);
signal disp1,disp2,disp3,disp4: std_logic_vector(6 downto 0);
signal m: std_logic_vector(7 downto 0):="00000001";
Constant Dig0: std_logic_vector(6 downto 0):="1111110";
Constant Dig1: std_logic_vector(6 downto 0):="0110000";
Constant Dig2: std_logic_vector(6 downto 0):="1101101";
Constant Dig3: std_logic_vector(6 downto 0):="1111001";
Constant Dig4: std_logic_vector(6 downto 0):="0110011";
Constant Dig5: std_logic_vector(6 downto 0):="1011011";
Constant Dig6: std_logic_vector(6 downto 0):="1011111";
Constant Dig7: std_logic_vector(6 downto 0):="1110000";
Constant Dig8: std_logic_vector(6 downto 0):="1111111";
Constant Dig9: std_logic_vector(6 downto 0):="1111011";
Constant Apag: std_logic_vector(6 downto 0):="0000000";
signal clk_low: std_logic:= '0';
COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
END COMPONENT;
attribute NOM_FREQ: string ;
attribute NOM_FREQ of OSCinst0 : label is "2.08";
begin
OSCInst0 : OSCH GENERIC  MAP("2.08") PORT MAP('0', clk_0);
------------------------------------------------------------------------------
	lowClk: process(clk_0)  
		VARIABLE count: INTEGER RANGE 0 to 500000;
	begin
		IF (clk_0'EVENT AND clk_0='1' )THEN
			m<=m(6 downto 0)&m(7); 	
			IF(count < 500000) THEN  				
				count := count+1; 
			ELSE
				count :=0; 
				clk_low <= NOT clk_low;
			END IF;
		END IF; 
	end process; 
------------------------------------------------------------------------------
muxDisp: process (m) 
	begin 
	mux <= m(6)&m(4)&m(2)&m(0);
		case m is
			when "00000001" => disp <= disp1;
			when "00000100" => disp <= disp2;
			when "00010000" => disp <= disp3;
			when "01000000" => disp <= disp4;
			when others => disp <= apag;
		end case;
end process;
	--Salidas Logicas sel=00
	slog<= (not a)  when sel="0000" else
				(not(a) + 1) when sel="0001" else
				(a and b) when sel="0010" else
				(a or b) when sel="0011" else
				("00"&a(0) & a(7 downto 1)) when sel="0100" else --shifters 01, 00 a la derecha 01 a la izq los 00 al inicio es por que es de 8 bits
				("00"&a(7) & a(6 downto 0)) when sel="0101" else "0000000000";
	
	sum_resta<=std_logic_vector(("0"&a(7 downto 0))+("0"&b(7 downto 0))) when sel="1000" else
							std_logic_vector(("0"&a(7 downto 0))-("0"&b(7 downto 0))) when sel="1001";
	division_p:process(residuo,b,sel)
		begin
		if sel="1010" then
			if (residuo-b(7 downto 0)>=0) then --divide por restas sucesivas
				cociente<=cociente+1;
				residuo<=residuo-b(7 downto 0);
			end if;
		elsif sel="1011" then --carga una nueva division
			cociente<= "00000000";
			residuo<= a(7 downto 0);
		elsif sel="1100" then --muestra el resultado de la division
			division<=cociente;
			elsif sel="1101" then --muestra el residuo de la division
			division<=residuo;
		end if;
	end process;
	proceso_bcd: process(division,sel)
        variable z: STD_LOGIC_VECTOR(19 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
		if ((sel="1000") or(sel="1001")) then
			z(11 downto 3):=sum_resta;
		elsif ((sel="1100") or(sel="1101")) then
			z(10 downto 3):=division;
		end if;
        for i in 0 to 5 loop
            -- Unidades (4 bits).
            if z(12 downto 9) > 4 then
                z(12 downto 9) := z(12 downto 9) + 3;
            end if;
            -- Decenas (4 bits).
            if z(16 downto 13) > 4 then
                z(16 downto 13) := z(16 downto 13) + 3;
            end if;
            -- Centenas (3 bits).
            if z(19 downto 17) > 4 then
                z(19 downto 17) := z(19 downto 17) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(19 downto 1) := z(18 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        num_bcd <= z(19 downto 8);
    end process;
	decoUno: process(num_bcd)
	begin 
		case num_bcd(3 downto 0) is 
		when "0000" => disp1 <= dig0;
		when "0001" => disp1 <= dig1;
		when "0010" => disp1 <= dig2;
		when "0011" => disp1 <= dig3;
		when "0100" => disp1 <= dig4;
		when "0101" => disp1 <= dig5;
		when "0110" => disp1 <= dig6;
		when "0111" => disp1 <= dig7;
		when "1000" => disp1 <= dig8;
		when others => disp1 <= dig9;
		end case;
	end process;

	decoDiez:process(num_bcd)
	begin 
		case num_bcd(7 downto 4)is 
		when "0000" => disp2 <= dig0;
		when "0001" => disp2 <= dig1;
		when "0010" => disp2 <= dig2;
		when "0011" => disp2 <= dig3;
		when "0100" => disp2 <= dig4;
		when "0101" => disp2 <= dig5;
		when "0110" => disp2 <= dig6;
		when "0111" => disp2 <= dig7;
		when "1000" => disp2 <= dig8;
		when others => disp2 <= dig9;
		end case;
	end process;

	decoCien:process(num_bcd)
	begin
		case num_bcd(11 downto 8) is 
		when "0000" => disp3 <= dig0;
		when "0001" => disp3 <= dig1;
		when "0010" => disp3 <= dig2;
		when "0011" => disp3 <= dig3;
		when "0100" => disp3 <= dig4;
		when "0101" => disp3 <= dig5;
		when "0110" => disp3 <= dig6;
		when "0111" => disp3 <= dig7;
		when "1000" => disp3 <= dig8;
		when others => disp3 <= dig9;
		end case;
end process; 
end comp;