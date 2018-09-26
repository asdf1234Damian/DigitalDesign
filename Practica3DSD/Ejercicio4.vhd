library IEEE;
use IEEE.std_logic_1164.all;
entity reg_uni is port(
s: in std_logic_vector(1 downto 0);
P_in: in std_logic_vector(3 downto 0);
clk: in std_logic;
dsr: in std_logic;
dsl: in std_logic;
MR: in std_logic;
Q: inout std_logic_vector(3 downto 0) );
end reg_uni;
architecture comportamiento of reg_uni is
signal Z: std_logic_vector(3 downto 0);
begin
Z<= Q;
process(clk, MR, s)
begin
if MR ='0' then
Z<="0000";
elsif ( clk'EVENT AND clk = '1' )then
case s is

when "11" => Z <= P_in;

when "10" => Z <= Z(2 downto 0)& dsl;
when "01" => Z <= dsr & Z(3 downto 1);

when others => null;
end case;
end if;
end process;
Q<=Z;
end comportamiento;