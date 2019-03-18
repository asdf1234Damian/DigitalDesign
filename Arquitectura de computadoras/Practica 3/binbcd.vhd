library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binbcd is 
	port(
	bin: in std_logic_vector (9 downto 0);
	bcd: out std_logic_vector (11 downto 0)
	);
end entity; 

architecture behavioral of binbcd is 
begin
process(bin)          
    variable aux: std_logic_vector(9 downto 0) := (others => '0');
	variable result: unsigned(11 downto 0) := (others => '0');
    begin
		result:= (others => '0');
		aux := bin;
		for i in 0 to 9 loop
			if (result(3 downto 0) > 4) then
				result(3 downto 0) := result(3 downto 0) + 3;
			end if;
			if (result(7 downto 4) > 4) then
				result(7 downto 4) := result(7 downto 4) + 3;
			end if;
			if (result(11 downto 8) > 4) then
				result(11 downto 8) := result(11 downto 8) + 3;
			end if;
			result := result(10 downto 0) & aux(9);
			aux := aux(8 downto 0) & '0';
		end loop;
		bcd <= std_logic_vector(result);
    end process;
end architecture;     