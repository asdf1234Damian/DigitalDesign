library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
port(
	a, b: in std_logic_vector(9 downto 0);
	mux : in std_logic_vector(3 downto 0);
	c : out std_logic;
	o : inout std_logic_vector(9 downto 0)
	);
end entity;

architecture behavioral of ALU is 
begin
process(mux)
variable shifter : std_logic_vector(9 downto 0);
variable remaining :  integer;
variable coc, res, div : unsigned(4 downto 0 ); -- unsigned para que tengan valor numerico
begin
	if (mux = "0101" or mux = "0110") then 
		shifter := a;
		remaining := to_integer(signed(b));
		for i in 0 to (10) loop
			if (remaining > 0)then 
				if(mux = "0101") then 
					shifter:= shifter(8 downto 0) & "0";
				else 
					shifter:= shifter(9) & shifter(9 downto 1);
				end if;
				remaining := remaining - 1; 
			end if; 			
		end loop; 
		o <= shifter;
	elsif (mux= "1010")  then 
		if b(4 downto 0) /= "00000" then -- valida division entre cero
		if b(4 downto 0) ="00001" then -- si se divide entre uno, se pasa directo
			o <= "00000"&a(6 downto 2);
		else-- si se divide entre dos o mas
			coc := "00000";--inicializa en 0
			res := unsigned(a(6 downto 2));-- se inicializa el  res a A
			div := unsigned(b(4 downto 0));-- se inicializa divisor a B
			for i in 0 to 128 loop -- peor caso 255/2 (optimizado del paso pasado)
				if (res >= div) then-- mientras el residuo sea mayor o igual al divisor 
					coc := coc+ 1;
					res := res - div;-- se hace la resta
				end if;
			end loop;	
			o <= "00000"&std_logic_vector(coc);-- se convierten en stdlogic
		end if;
	end if;  
	else		
		case mux is
			when "0001" => o <= not a;
			when "0011" => o <= (not a) + 1;
			when "0010" => o <= a and b; 
			when "0100" => o <= a or b;
			when "0111" => o <= "0"&(a(9 downto 2) + b(7 downto 0)); -- Con carry out ???????????
						   c <= o(8);
			when "1000" => o <= "0"&(a(9 downto 2) - b(8 downto 0));
			when "1001" => o <= a(9 downto 5) * b(4 downto 0); 
			when others => o <= a; 
		end case; 
	end if;  
end process;  			
end architecture;      