library IEEE;
use IEEE.std_logic_1164.all;

entity PIPO is 
port(
	Dn: in std_logic_vector(7 downto 0);
	ck: in std_logic;
	Qn: inout std_logic_vector(7 downto 0)
);
end entity;

architecture arch_PIPO of PIPO is 
begin 
process (ck)
begin
	if(ck'event and ck='1') then 
		Qn<=Dn;
	else
		Qn<=Qn;
	end if;
end process;
end architecture;
