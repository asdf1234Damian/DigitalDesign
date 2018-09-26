library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity andNor is
port(
	na,nb,nc,nd: in std_logic;
	nz: out std_logic
	);
end entity;

architecture archAndNor of andNor is
begin
nz<=((na and nb)or(nc and nd));
end architecture;


