library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
port
(
	clk_0:inout std_logic;
	mux: inout std_logic_vector(3 downto 0 );
	a, b: in std_logic_vector(9 downto 0);
	sel: in std_logic_vector(3 downto 0);
	disp: out std_logic_vector(6 downto 0);
	slog: out std_logic_vector(9 downto 0)
);
end entity;

architecture Behavioral of ALU is
signal sum_resta: std_logic_vector(8 downto 0) := "000000000";
signal residuo: std_logic_vector(7 downto 0) := "00000000";
signal cociente: std_logic_vector(7 downto 0) := "00000000";
signal num_bcd: std_logic_vector(11 downto 0);
signal disp1, disp2, disp3, disp4: std_logic_vector(6 downto 0);
signal m: std_logic_vector(7 downto 0) := "00000001";
Constant Dig0: std_logic_vector(6 downto 0) := "1111110";
Constant Dig1: std_logic_vector(6 downto 0) := "0110000";
Constant Dig2: std_logic_vector(6 downto 0) := "1101101";
Constant Dig3: std_logic_vector(6 downto 0) := "1111001";
Constant Dig4: std_logic_vector(6 downto 0) := "0110011";
Constant Dig5: std_logic_vector(6 downto 0) := "1011011";
Constant Dig6: std_logic_vector(6 downto 0) := "1011111";
Constant Dig7: std_logic_vector(6 downto 0) := "1110000";
Constant Dig8: std_logic_vector(6 downto 0) := "1111111";
Constant Dig9: std_logic_vector(6 downto 0) := "1111011";
Constant Apag: std_logic_vector(6 downto 0) := "0000000";
Constant dash: std_logic_vector(6 downto 0) := "0000001";
signal clk_low: std_logic:= '0';

COMPONENT  OSCH
		GENERIC(NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic); 
END COMPONENT;

attribute NOM_FREQ: string; 
attribute NOM_FREQ of OSCinst0 : label is "2.08";

begin
	OSCInst0 : OSCH GENERIC  MAP("2.08") PORT MAP('0', clk_0);
------------------------------------------------------------------------------
	lowClk: process(clk_0)  
		VARIABLE count: INTEGER RANGE 0 to 2000000;
	begin 
		if (clk_0'event and clk_0='1' ) then
			m <= m(6 downto 0) & m(7); 	
			if(count < 2000000) then  				
				count := count + 1; 
			else 
				count :=0; 
				clk_low <= not clk_low;
			end if;
		end if; 
	end process; 
------------------------------------------------------------------------------
	muxDisp: process (m) 
	begin 
		mux <= m(6) & m(4) & m(2) & m(0);
		case m is
			when "00000001" => disp <= disp1;
			when "00000100" => disp <= disp2;
			when "00010000" => disp <= disp3;
			when "01000000" => disp <= disp4;
			when others => disp <= apag;
		end case;
	end process;

	--Salidas Logicas sel=00
	logicOP : process(sel)
		variable shift: std_logic_vector(7 downto 0);
	begin
	if (sel="0110" or sel="0111" ) then 
		shift:= a(9 downto 2);
		slog(7 downto 0)<=shift;
	elsif (sel="0100")then 
		if(clk_low'event and clk_low='1') then 
			shift:= shift(6 downto 0)&'0';
			slog(7 downto 0)<=shift;
		end if;
	elsif (sel="0101") then 
		if(clk_low'event and clk_low='1') then 
			shift:= '0'&shift(7 downto 1);
			slog(7 downto 0)<=shift;
		end if;
	else
		case (sel) is 
			when "0000"=> slog <=(not a);
			when "0001"=> slog <=(not a)+1;
			when "0010"=> slog <=(a and b);
			when "0011"=> slog <=(a or b);
			when others=> slog <="0000000000";
	end case;			
	end if;	
	end process;
	
			
	sumres: process(sel)
	begin 
	if sel = "1000" then -- suma
		sum_resta <= (("0"&a(9 downto 2))+("0"&b(7 downto 0)));
		disp4<=apag; 
	elsif sel = "1001" then 
		if (a(9 downto 2)<b(7 downto 0))then 
			sum_resta <= not(("0"&a(9 downto 2))-("0"&b(7 downto 0)))+1;
			disp4<=dash;
		else 
			disp4<=apag;
			sum_resta <= (("0"&a(9 downto 2))-("0"&b(7 downto 0)));
		end if;
	end if; 
	end process;

	division_p: process(b,sel)
		variable coc, res, div : unsigned(7 downto 0 ); -- unsigned para que tengan valor numerico
	begin
	if b(7 downto 0) /= "000000000" then -- valida division entre cero
		if b(7 downto 0) ="000000001" then -- si se divide entre uno, se pasa directo
			cociente <= a(9 downto 2);
			residuo <= "00000000";
		else-- si se divide entre dos o mas
			coc := "00000000";--inicializa en 0
			res := unsigned(a(9 downto 2));-- se inicializa el  res a A
			div := unsigned(b(7 downto 0));-- se inicializa divisor a B
			for i in 0 to 128 loop -- peor caso 255/2 (optimizado del paso pasado)
				if (res >= div) then-- mientras el residuo sea mayor o igual al divisor 
					coc := coc+ 1;
					res := res - div;-- se hace la resta
				end if;
			end loop;	
			cociente <= std_logic_vector(coc);-- se convierten en stdlogic
			residuo <= std_logic_vector(res);-- sin importar que division era. 
		end if;
			
	end if;  
	end process;
		
		  
	proceso_bcd: process(sel) 
		-- Inicialización de datos en cero.           
        variable z: std_logic_vector(8 downto 0) :=(others => '0');
		variable bcd: unsigned(11 downto 0):=(others => '0');
    begin
        -- Se realizan los primeros tres corrimientos.
		bcd:=(others =>'0');
		if ((sel = "1000") or (sel = "1001")) then
			z := sum_resta;
		elsif (sel = "1100" )then  
			z := "0"&cociente;	
		elsif(sel = "1101") then 
			z := "0"&residuo;	 
		end if;
			for i in 0 to 8 loop
				 --Unidades (4 bits).
				if bcd(3 downto 0) > 4 then 
					bcd(3 downto 0) := bcd(3 downto 0) + 3;
				end if; 
			  
				if bcd(7 downto 4) > 4 then  
					bcd(7 downto 4) := bcd(7 downto 4) + 3;
				end if;

				if bcd(11 downto 8) > 4 then  
					bcd(11 downto 8) := bcd(11 downto 8) + 3;
				end if;
				-- corrimiento a la izquierda, y copiar el bit
				--mas significativo del temp en el menos significativo del bcd
				bcd := bcd(10 downto 0) & z(8); 
				-- corrimiento a la izquiera 
				z := z(7 downto 0) & '0';
			end loop;
			num_bcd<=std_logic_vector(bcd);
    end process;

	decoUno: process(num_bcd)
	begin 
	if(sel(3 downto 2) = "00") or (sel(3 downto 2) = "01")then
		disp3<=apag;
	elsif (((sel="1100") or (sel="1101")) and (b(7 downto 0)=0)) then
		disp3<=dash;
	else
		case num_bcd(3 downto 0) is 
			when "0000" => disp3 <= dig0;
			when "0001" => disp3 <= dig1;
			when "0010" => disp3 <= dig2;
			when "0011" => disp3 <= dig3;
			when "0100" => disp3 <= dig4;
			when "0101" => disp3 <= dig5;
			when "0110" => disp3 <= dig6;
			when "0111" => disp3 <= dig7;
			when "1000" => disp3 <= dig8;
			when "1001" => disp3 <= dig9;
			when others => disp3 <= dash;
		end case;
	end if;
	end process; 

	decoDiez:process(num_bcd)
	begin 
	if(sel(3 downto 2) = "00") or (sel(3 downto 2) = "01")then
		disp2<=apag;
	elsif (((sel="1100") or (sel="1101")) and (b(7 downto 0)=0)) then
		disp2<=dash;
	else
		case num_bcd(7 downto 4) is 
			when "0000" => disp2 <= dig0;
			when "0001" => disp2 <= dig1;
			when "0010" => disp2 <= dig2;
			when "0011" => disp2 <= dig3;
			when "0100" => disp2 <= dig4;
			when "0101" => disp2 <= dig5;
			when "0110" => disp2 <= dig6;
			when "0111" => disp2 <= dig7;
			when "1000" => disp2 <= dig8;
			when "1001" => disp2 <= dig9;
			when others => disp2 <= dash;
		end case;
	 end if;
	end process;

	decoCien:process(num_bcd)
	begin
	if(sel(3 downto 2) = "00") or (sel(3 downto 2) = "01")then
		disp1<=apag;
	elsif (((sel="1100") or (sel="1101")) and (b(7 downto 0)=0)) then
		disp1<=dash;
	else
		case num_bcd(11 downto 8) is 
			when "0000" => disp1 <= dig0;
			when "0001" => disp1 <= dig1;
			when "0010" => disp1 <= dig2;
			when "0011" => disp1 <= dig3;
			when "0100" => disp1 <= dig4;
			when "0101" => disp1 <= dig5;
			when "0110" => disp1 <= dig6;
			when "0111" => disp1 <= dig7;
			when "1000" => disp1 <= dig8;
			when "1001" => disp1 <= dig9;
			when others => disp1 <= dash;
		end case;
		end if;
	end process; 
end Behavioral;