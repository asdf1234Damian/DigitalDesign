library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity dispMux is 
	port(
	clk, neg, ischar : in std_logic;
	bin : in std_logic_vector(9 downto 0);
	char : in std_logic_vector(19 downto 0);
	mux : inout std_logic_vector(3 downto 0) := "0001";
	disp : out std_logic_vector(7 downto 0)
	);
end entity;

architecture behavioral of dispMux is 
component deco7 is 
	port(
	a: in std_logic_vector(4 downto 0);
	disp: out std_logic_vector(7 downto 0)
	); 
end component;

component binbcd is 
	port(
	bin: in std_logic_vector (9 downto 0);
	bcd: out std_logic_vector (11 downto 0)
	); 
end component;
signal sigBcd : std_logic_vector(11 downto 0);
signal OutputSeg : std_logic_vector(4 downto 0); 
signal sign : std_logic_vector(4 downto 0);
signal inBin :std_logic_vector(9 downto 0);
begin 

process(mux)
begin
if ischar = '1' then  
	case mux is 
		when "0001" => OutputSeg <= char(4 downto 0);
		when "0010" => OutputSeg <= char(9 downto 5);
		when "0100" => OutputSeg <= char(14 downto 10);
		when others => OutputSeg <= char(19 downto 15);
	end case;
else
	if (neg = '1') then 
		inbin <= not(bin)+1;
		sign <= "11111";
	else 
		inbin <= bin;
		sign <= "00000";
	end if;
	case mux is 
		when "0001" => OutputSeg <= sign;
		when "0010" => OutputSeg <= '0'&sigBCD(3 downto 0);
		when "0100" => OutputSeg <= '0'&sigBCD(7 downto 4);
		when others => OutputSeg <= '0'&sigBCD(11 downto 8);
	end case;
end if;

if (clk'event and clk = '1')then 
	mux <= mux(2 downto 0)& mux(3);
end if;

end process;  
decoInS: binbcd port map(inBin,sigBcd);
deco7Ins: deco7 port map(OutputSeg,disp); 
end architecture;  
