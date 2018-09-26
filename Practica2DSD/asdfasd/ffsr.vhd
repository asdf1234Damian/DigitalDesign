library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity FFSR is
PORT( 
	s,r,clk1: in std_logic;
	Q, Qn: out std_logic
	);
end entity;


Architecture archFFSR of FFSR is
begin
PROCESS(clk1)
variable tmp: std_logic;
begin
if(clk1='0' and clk1'EVENT) then
	if(S='0' and R='0')then 
	tmp:=tmp;
	elsif(S='1' and R='1')then
	tmp:='Z';
	elsif(S='0' and R='1')then
	tmp:='0';
	else
	tmp:='1';
	end if;
end if; 
Q <= tmp;
Qn <= not tmp;
end PROCESS;
end architecture;