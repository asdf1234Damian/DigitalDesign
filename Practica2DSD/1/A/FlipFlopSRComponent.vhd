library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity FFSR is
PORT( 
	s,r,ck1: in std_logic;
	Q: out std_logic
	);
end entity;


Architecture archFFSR of FFSR is
begin
process(ck1,s,r)
variable x: std_logic;
begin
if(ck1='1') then
	if(S='0' and R='0')then
	 x:=x;
	 elsif(S='1' and R='1')then
	 x:='Z';
	elsif(S='0' and R='1')then
	 x:='0';
	else  
	 x:='1';
	end if;
end if;
   Q<=x;
end process;
end architecture; 