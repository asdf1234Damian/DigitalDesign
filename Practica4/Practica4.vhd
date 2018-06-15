library ieee;
use ieee.std_logic_1164.all;
entity Converter  is
  port (
    I: in std_logic_vector(9 downto 0);
    C: in std_logic;
    O: out std_logic_vector(9 downto 0)
  );
  attribute pin_numbers of Converter: entity is
    "I(0):1 I(1):2 I(2):3 I(3):4 I(4):5 I(5):6 I(6):7 I(7):8 C:11 O(0):14 O(1):15 O(2):16 O(3):17 O(4):18 O(5):19 O(6):20 O(7):21";
	attribute synthesis_off of O(4): signal is true;
	attribute synthesis_off of signal is true;
end entity;

architecture archConverter of Converter is
--  signal Middleleft, Middleright:std_logic;
  --attribute synthesis_off of Middleleft: signal is true;
  --attribute synthesis_off of Middleright: signal is true;
begin
--Middleleft <= I(4) xor I(7) xor I(6) xor I(5);
--Middleright <= I(0) xor I(3) xor I(2)xor I(1);
process(I,C,middleleft,middleright)
variable  AuxVec: std_logic_vector(7 downto 0);
begin

  if (c='0') then
      AuxVec:=to_stdlogicvector(to_bitvector(I) srl 1);
      O<=AuxVec xor I;
  else
    O(9) <= I(9);
	  O(8) <= I(9) xor I(8);
    O(7) <= I(9) xor I(8) xor I(7);
    O(6) <= I(7) xor I(6) xor I(9) xor I(8);
    O(5) <= I(7) xor I(6) xor I(5);
    O(4) <= Middleleft ;
    O(3) <= Middleleft xor I(3);
    O(2) <= Middleleft xor I(3) xor I(2);
    O(1) <= Middleleft xor I(3) xor I(2)xor I(1) ;
    O(0) <= Middleleft xor middleright;
  end if;
end process;
end architecture;
