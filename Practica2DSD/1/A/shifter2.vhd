library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;


entity shifter is
port(
s,c : in std_logic;
pn:in std_logic_vector(3 downto 0);
qn:out std_logic_vector(3 downto 0)
);
end entity;

architecture archShift of shifter is
begin
process (s,c) 
 variable aux: std_logic_vector(3 downto 0);
begin 
if(c='1') then 
	if(s='0') then 
	aux:= aux(0)&aux(3 downto 1);
	---qn<=pn;
	else
	aux:=pn;
	--qn<= pn(0) & pn(3 downto 1);
	end if;
else
aux:=aux;
end if;
qn<=aux;
end process;

end architecture; 