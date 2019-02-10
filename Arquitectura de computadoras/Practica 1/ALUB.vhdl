library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
	port
	(
		clk_0: inout std_logic;
		load,lsl,asr: in std_logic;
		mux: inout std_logic_vector(3 downto 0 );
		a, b: in std_logic_vector(9 downto 0);
		sel: in std_logic_vector(3 downto 0);
		disp: out std_logic_vector(6 downto 0);
		sLog: inout std_logic_vector(9 downto 0)
	);
end entity;

architecture Behavioral of ALU is
signal sum_resta: std_logic_vector(8 downto 0) := "000000000";
signal producto: std_logic_vector(9 downto 0) := "0000000000";
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
 
component OSCH
	generic(NOM_FREQ: string);
	port
	(
		STDBY: in std_logic;
		OSC: out std_logic
	); 
end component;

attribute NOM_FREQ: string; 
attribute NOM_FREQ of OSCinst0 : label is "2.08";

begin
	OSCInst0 : OSCH generic  map("2.08") port map('0', clk_0);
------------------------------------------------------------------------------
	lowClk: process(clk_0)  
	variable count: integer range 0 to 2000000;
	begin 
		if (clk_0'event and clk_0 = '1' ) then
			m <= m(6 downto 0) & m(7);
			if (count < 2000000) then				
				count := count + 1;
			else
				count :=0;
				clk_low <= not clk_low;
			end if;
		end if;
	end process;
------------------------------------------------------------------------------
	muxDisp: process(m)
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

	bitsOP : process(sel,load, asr, lsl,slog)
	variable z: std_logic_vector(9 downto 0) := (others => '0');
	begin
		if (sel = "0100") then
			if(load = '1' and lsl = '0' and asr = '0') then 
				slog <= a; 
			elsif(lsl'event and lsl = '1' and load = '0' and asr='0')then 
				slog <= slog(8 downto 0)&'0';
			end if;
		elsif (sel = "0101") then
			if(load = '1' and lsl = '0' and asr = '0') then 
				slog <= a;
			elsif(lsl'event and lsl = '1' and load = '0' and asr='0')then 
				slog <= slog(9)&slog(9 downto 1);
			end if;
		else
			case (sel) is 
				when "0000"=> slog <= (not a);
				when "0001"=> slog <= (not a) + 1;
				when "0010"=> slog <= (a and b); 
				when "0011"=> slog <= (a or b);
				when others=> slog<= "0000000000";
			end case;
		end if; 
	end process; 
			
	sumres: process(sel)
	begin 
		if (sel = "1000") then --Suma
			sum_resta <= (("0" & a(9 downto 2)) + ("0" & b(7 downto 0)));
			disp4 <= apag;
		elsif (sel = "1001") then --Resta
			if (a(9 downto 2) < b(7 downto 0)) then
				sum_resta <= not(("0" & a(9 downto 2)) - ("0" & b(7 downto 0))) + 1;
				disp4 <= dash;
			else 
				disp4 <= apag;
				sum_resta <= (("0" & a(9 downto 2)) - ("0" & b(7 downto 0)));
			end if;
		end if;
	end process;

	multi: process(b, sel)
	variable mulo, mulr: unsigned(4 downto 0); -- unsigned para que tengan valor numerico
	variable prod: unsigned(9 downto 0);
	begin
		if (a(9 downto 5) = "00000" or b(4 downto 0) = "00000") then
			producto <= "0000000000";
		elsif (b(4 downto 0) = "00001") then
			producto <= "00000" & a(9 downto 5);
		elsif (a(9 downto 5) = "00001") then
			producto <= "00000" & b(4 downto 0);
		else
			prod := "0000000000"; -- contador
			mulo := unsigned(a(9 downto 5)); -- se inicializa el multiplicando a A
			mulr := unsigned(b(4 downto 0)); -- se inicializa el multiplicador a B
			for i in 0 to 31 loop -- peor caso cuando B = 31
				if (mulr > 0) then
					mulr := mulr - 1;
					prod := prod + mulo;-- se hace la resta
				end if;
			end loop;
			producto <= std_logic_vector(prod);-- se convierten en stdlogic
		end if;
	end process;
		
		  
	BCD: process(sel)
	-- Inicializaci?n de datos en cero.           
    variable z: std_logic_vector(9 downto 0) := (others => '0');
	variable bcd: unsigned(11 downto 0) := (others => '0');
    begin
		bcd := (others => '0');
		if ((sel = "1000") or (sel = "1001")) then
			z := "0" & sum_resta;
		elsif (sel = "1100") then
			z := producto;
		end if;
		for i in 0 to 9 loop
			if (bcd(3 downto 0) > 4) then
				bcd(3 downto 0) := bcd(3 downto 0) + 3;
			end if;
			if (bcd(7 downto 4) > 4) then
				bcd(7 downto 4) := bcd(7 downto 4) + 3;
			end if;
			if (bcd(11 downto 8) > 4) then
				bcd(11 downto 8) := bcd(11 downto 8) + 3;
			end if;
			bcd := bcd(10 downto 0) & z(9);
			z := z(8 downto 0) & '0';
		end loop;
		num_bcd <= std_logic_vector(bcd);
    end process;

	decoUno: process(num_bcd)
	begin 
		if (sel(3 downto 2) = "00") or (sel(3 downto 2) = "01") then
			disp3 <= apag;
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

	decoDiez: process(num_bcd)
	begin 
		if (sel(3 downto 2) = "00") or (sel(3 downto 2) = "01") then
			disp2 <= apag;
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

	decoCien: process(num_bcd)
	begin
		if (sel(3 downto 2) = "00") or (sel(3 downto 2) = "01") then
			disp1 <= apag;
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