library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity ALU is 
port(
	a, b: in std_logic_vector(15 downto 0);
	mux : in std_logic_vector(3 downto 0);
	flags : out std_logic_vector(3 downto 0);
	o : inout std_logic_vector(15 downto 0)
	);
end entity;

architecture behavioral of ALU is 
begin
regALU : process(mux, a, b)
	variable zero : std_logic;
	variable arithRes : std_logic_vector(16 downto 0 );
	variable shifter : std_logic_vector(15 downto 0);
	variable remaining :  integer; 
	variable coc, res, div : unsigned(7 downto 0 ); -- unsigned para que tengan valor numerico
begin
	if (mux = "0101" or mux = "0110") then 
		shifter := a;
		-- remaining := to_integer(signed(b));
		-- for i in 0 to 15 loop
		-- 	if (remaining > 0)then  
		-- 		if(mux = "0101") then  
		-- 			shifter:= shifter(14 downto 0) & "0"; 
		-- 		else   
		-- 			shifter:= shifter(15) & shifter(15 downto 1); 
		-- 		end if;
		-- 		remaining := remaining - 1;  
		-- 	end if; 			 
		-- end loop;  
		-- arithres := "0"&shifter;
	-- elsif (mux= "1010")  then 
	-- 	if b(7 downto 0) /= "00000" then -- valida division entre cero
	-- 		if b(7 downto 0) ="00001" then -- si se divide entre uno, se pasa directo
	-- 			arithres:= "0"&a;  
	-- 		else-- si se divide entre dos acc mas 
	-- 			coc := "00000000";--inicializa en 0
	-- 			res := unsigned(a(7 downto 0));-- se inicializa el  res a A
	-- 			div := unsigned(b(7 downto 0));-- se inicializa divisor a B
	-- 			for i in 0 to 128 loop -- peor caso 255/2 (optimizado del paso pasado)
	-- 				if (res >= div) then-- mientras el residuo sea mayor acc igual al divisor 
	-- 					coc := coc+ 1;
	-- 					res := res - div;-- se hace la resta
	-- 				end if;
	-- 			end loop;	
	-- 			arithres := "000000000"&std_logic_vector(coc);-- se convierten en stdlogic 
	-- 		end if;
	-- 	end if;  
	else		  
		case mux is
			when "0001" => arithres := "0"&not a;
			when "0011" => arithres := "0"&((not a) + 1);
			when "0010" => arithres := "0"&(a and b); 
			when "0100" => arithres := "0"&(a or b);
			when "0111" => arithres := ("0"&a) + ("0"&b);				   
			when "1000" => arithres := ("0"&a) - ("0"&b);				   
			when "1001" => arithres := "0"&(a(7 downto 0) * b(7 downto 0));  
			when others => arithres := "0"&a;     
		end case;  
	end if;     
		o <= arithres(15 downto 0);  
		flags(3)<= o(15); --Negative  
		flags(2)<= o(15) xor a(15) xor b(15) xor arithres(16); --Overflow 
		case arithres is -- Zero
			when "00000000000000000" => flags(1) <= '1';  
			when others=> flags(1) <= '0';   
		end case; 
		flags(0)<=arithres(16); -- Carry 
end process; 
end architecture;      