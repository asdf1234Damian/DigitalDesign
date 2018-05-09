library ieee;
use ieee.std_logic_1164.all;
entity Converter  is
  port (
    I: in std_logic_vector(3 downto 0);
    C:in std_logic;
    O: out std_logic_vector(3 downto 0)
  );
  --attribute pin_numbers of Converter: entity is
    --"I(0):2 I(1):3 I(2):4 I(3):5 C:6 O(0):16 O(1):17 O(2):18 O(3):19 ";
end entity;

architecture archConverter of Converter is
  signal Aux: std_logic_vector(3 downto 0);
begin
  process(C,I,aux)
  begin
    if (C='0') then-- Bin to Grey
      Aux<=to_stdlogicvector(to_bitvector(I)SRL 1);
      O<=I xor Aux;
    else
      O(3)<=I(3);
      O(2)<=I(3) xor I(2);
      O(1)<=I(3) xor I(2) xor I(1);
      O(0)<=I(3) xor I(2) xor I(1) xor I(0);
    end if;
  end process;
end architecture;
