library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity andNor is
port(
	ca,cb,cc,cd: in std_logic;
	cz: out std_logic
	);
end entity;

architecture archAndNor of andNor is
begin
cz<= not((ca and cb)xor(cc and cd));
end architecture;


library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity andOr is
port(
	ca,cb,cc,cd: in std_logic;
	cz: out std_logic
	);
end entity;

architecture archAndOr of andOr is
begin
cz<= ((ca and cb)xor(cc and cd));
end architecture;

