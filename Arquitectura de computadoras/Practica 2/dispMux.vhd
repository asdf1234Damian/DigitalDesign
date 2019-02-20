library ieee;
use ieee.std_logic_1164.all;

entity dispMux is 
	port(
	clk, neg : in std_logic;
	bin : in std_logic_vector(9 downto 0);
	mux : inout std_logic_vector(3 downto 0) := "0001";
	disp : out std_logic_vector(6 downto 0)
	);
end entity;

architecture behavioral of dispMux is 
component deco7 is 
	port(
	a: in std_logic_vector(3 downto 0);
	disp: out std_logic_vector(6 downto 0)
	);
end component;

component binbcd is 
	port(
	bin: in std_logic_vector (9 downto 0);
	bcd: out std_logic_vector (11 downto 0)
	);
end component;
signal sigBcd : std_logic_vector(11 downto 0);
signal currentSeg : std_logic_vector(3 downto 0); 
signal sign : std_logic_vector(3 downto 0);
begin 
decoInS: binbcd port map(bin,sigBcd);
process(mux)
begin
if (neg = '1') then 
	sign <= "1111";
else
	sign <= "1011";
end if;
if (clk'event and clk = '1')then 
	mux <= mux(2 downto 0)& mux(3);
end if;
case mux is 
	when "0001" => currentSeg <= sigBCD(3 downto 0);
	when "0010" => currentSeg <= sigBCD(7 downto 4);
	when "0100" => currentSeg <= sigBCD(11 downto 8);
	when others => currentSeg <= sign;
end case;
end process;  
deco7Ins: deco7 port map(currentSeg,disp);
end architecture;  


