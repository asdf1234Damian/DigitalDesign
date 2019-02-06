library ieee;
use ieee.std_logic_1164.all;

entity Encoder is
  port (
  I: in std_logic_vector(9 downto 0);
  O: out std_logic_vector(3 downto 0)
  );
  attribute pin_numbers of Encoder: entity is
    "I(0):1 I(1):2 I(2):3 I(3):4 I(4):5 I(5):6 I(6):7 I(7):8 I(8):9 I(9):10 O(0):14 O(1):15 O(2):16 O(3):17";
end entity;

architecture archEncoder of  Encoder is
  Constant Dig0: std_logic_vector(3 downto 0):="0000";--D
  Constant Dig1: std_logic_vector(3 downto 0):="0001";
  Constant Dig2: std_logic_vector(3 downto 0):="0010";
  Constant Dig3: std_logic_vector(3 downto 0):="0011";
  Constant Dig4: std_logic_vector(3 downto 0):="0100";
  Constant Dig5: std_logic_vector(3 downto 0):="0101";
  Constant Dig6: std_logic_vector(3 downto 0):="0110";
  Constant Dig7: std_logic_vector(3 downto 0):="0111";
  Constant Dig8: std_logic_vector(3 downto 0):="1000";--B
  Constant Dig9: std_logic_vector(3 downto 0):="1001";
  Constant Apag: std_logic_vector(3 downto 0):="1111";
begin
  identifier : process(I)
  begin
    if (I = "0000000000") then
      O<=Apag;
    elsif (I = "0000000001") then
      O<=Dig0;
    elsif (I > "0000000001" and I <= "0000000011") then
      O<=Dig1;
    elsif (I > "0000000011" and I <= "0000000111") then
      O<=Dig2;
    elsif (I > "0000000111" and I <= "0000001111") then
      O<=Dig3;
    elsif (I > "0000001111" and I <= "0000011111") then
      O<=Dig4;
    elsif (I > "0000011111" and I <= "0000111111") then
      O<=Dig5;
    elsif (I > "0000111111" and I <= "0001111111") then
      O<=Dig6;
    elsif (I > "0001111111" and I <= "0011111111") then
      O<=Dig7;
    elsif (I > "0011111111" and I <= "0111111111") then
      O<=Dig8;
    elsif (I > "0111111111" and I <= "1111111111") then
      O<=Dig9;
    else
    end if;
  end process;
end architecture;
