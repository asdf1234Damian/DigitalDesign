library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
	port
	(
		clk_0: inout std_logic;
		load, lsl, asr: in std_logic;
		test: out std_logic;
		a, b: in std_logic_vector(9 downto 0);
		sel: in std_logic_vector(3 downto 0);
		sLog: inout std_logic_vector(9 downto 0);
		sAri: out std_logic_vector(9 downto 0)
	);
end entity;

architecture Behavioral of ALU is
signal sum_resta: std_logic_vector(8 downto 0) := "000000000";
signal producto: std_logic_vector(9 downto 0) := "0000000000";
signal m: std_logic_vector(7 downto 0) := "00000001";
signal clk_low, minus: std_logic:= '0';

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
	--test <= (load or lsl) or asr ;
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

	logicOP : process(sel, load, asr, lsl,slog)
	variable MVP: std_logic;
	begin
		if (sel = "0100") then
			if(lsl'event and lsl='1')then 
				slog <= "1010101010";
				--slog <= slog(8 downto 0)&'0';
			elsif(load'event and load='1') then  				
				slog <= a(9 downto 0);
			--elsif(asr'event and asr='1')then 
				--slog <= slog(8)&slog(8 downto 1);
			end if;
		else
			case (sel) is 
				when "0000"=> slog <= (not a);
				when "0001"=> slog <= (not a) + 1;
				when "0010"=> slog <= (a and b); 
				when "0011"=> slog <= (a or b);
				when others=> slog <= "0000000000";
			end case;
		end if; 
	end process;
			
	sumres: process(sel)
	begin 
		if (sel = "1000") then --Suma
			sum_resta <= (("0" & a(9 downto 2)) + ("0" & b(7 downto 0)));
		elsif (sel = "1001") then --Resta
			if (a(9 downto 2) < b(7 downto 0)) then
				sum_resta <= not(("0" & a(9 downto 2)) - ("0" & b(7 downto 0))) + 1;
				minus <= '0';
			else
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

	showResult: process(sel, minus)
    variable z: std_logic_vector(9 downto 0) := (others => '0');
    begin
		if ((sel = "1000") or (sel = "1001")) then
			z := "0" & sum_resta;
		elsif (sel = "1100") then
			z := producto;
		end if;
		sAri <= z;
    end process;
end Behavioral;