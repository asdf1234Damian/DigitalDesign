library ieee;
use ieee.std_logic_1164.all;
entity Converter  is
  port (
    I: in std_logic_vector(7 downto 0);
    C: in std_logic;
    O: out std_logic_vector(7 downto 0)
  );
  attribute pin_numbers of Converter: entity is
    "I(0):1 I(1):2 I(2):3 I(3):4 I(4):5 I(5):6 I(6):7 I(7):8   C:11 O(0):14 O(1):15 O(2):16 O(3):17 O(4):18 O(5):19 O(6):20 O(7):21  ";
end entity;

architecture archConverter of Converter is
  signal Middleleft, Middleright:std_logic;
  attribute synthesis_off of Middleleft: signal is true;
  attribute synthesis_off of Middleright: signal is true;
begin
O(7)<=I(7);
Middleleft <= I(4) xor I(7) xor I(6) xor I(5);
Middleright <= I(0) xor I(3) xor I(2)xor I(1);
process(I,C,middleleft,middleright)
variable  AuxVec: std_logic_vector(6 downto 0);
begin

  if (c='0') then
      AuxVec:=to_stdlogicvector(to_bitvector(I(6 downto 0)) srl 1);
      O(6 downto 0)<=AuxVec xor I(6 downto 0);
  else
    O(6) <= I(7) xor I(6);
    O(5) <= I(7) xor I(6) xor I(5);
    O(4) <= Middleleft ;
    O(3) <= Middleleft  xor I(3);
    O(2) <= Middleleft xor I(3) xor I(2);
    O(1) <= Middleleft xor I(3) xor I(2)xor I(1) ;
    O(0) <= Middleleft xor middleright;
  end if;
end process;
end architecture;
-- architecture archConverter of Converter is
--   begin
--   process(C,I)
--   variable Aux:std_logic;
--   begin
--     O(8)<=I(8);
--     if (C='0') then
--       BinToRBC : for j in 7 downto  0 loop
--         O(j)<= I(j+1) xor I(j);
--       end loop;
--     else
-- 	aux:=I(8);
--       RBCtoBin : for k in 7 downto 0 loop
-- 		aux:=aux xor I(k);
--         O(k)<= Aux;
--       end loop;
--     end if;
--   end process;
-- end architecture;
