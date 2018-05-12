library ieee;
use ieee.std_logic_1164.all;
entity Converter  is
  port (
    I: in std_logic_vector(8 downto 0);
    C: in std_logic;
    O: out std_logic_vector(8 downto 0)
  );
  attribute pin_numbers of Converter: entity is
    "I(0):1 I(1):2 I(2):3 I(3):4 I(4):5 I(5):6 I(6):7 I(7):8 I(8):9  C:11 O(0):14 O(1):15 O(2):16 O(3):17 O(4):18 O(5):19 O(6):20 O(7):21 O(8):22 ";
end entity;

architecture archConverter of Converter is
  begin
  process(C,I)
  variable Aux:std_logic;
  begin
    O(8)<=I(8);
    if (C='0') then
      BinToRBC : for j in 7 downto  0 loop
        O(j)<= I(j+1) xor I(j);
      end loop;
    else
      RBCtoBin : for k in 7 downto 0 loop
		aux:=I(k+1) xor I(k);
        O(k)<= Aux;
      end loop;
    end if;
  end process;
end architecture;
