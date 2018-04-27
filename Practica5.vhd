library ieee;
use ieee.std_logic_1164.all;

entity Decoder  is
  port (
    I: in std_logic_vector(3 downto 0);
    C: in std_logic;
    O: out std_logic_vector(6 downto 0)
  );
  attribute pin_numbers of Decoder: entity is
    "I(0):2 I(1):3 I(2):4 I(3):5 C:6 O(0):20 O(1):21 O(2):22 O(3):23";--Corregir las entradas
end entity;


architecture Arch_Decode of Decoder is
  Constant Dig0: std_logic_vector(6 downto 0):="0000001";--D
  Constant Dig1: std_logic_vector(6 downto 0):="1001111";
  Constant Dig2: std_logic_vector(6 downto 0):="0010010";
  Constant Dig3: std_logic_vector(6 downto 0):="1001111";
  Constant Dig4: std_logic_vector(6 downto 0):="0000110";
  Constant Dig5: std_logic_vector(6 downto 0):="0100100";
  Constant Dig6: std_logic_vector(6 downto 0):="0100000";
  Constant Dig7: std_logic_vector(6 downto 0):="0001110";
  Constant Dig8: std_logic_vector(6 downto 0):="0000000";--B
  Constant Dig9: std_logic_vector(6 downto 0):="0001100";
  Constant Apag: std_logic_vector(6 downto 0):="1111111";
  Constant HexA: std_logic_vector(6 downto 0):="0001000";
  Constant HexC: std_logic_vector(6 downto 0):="0110001";
  Constant HexE: std_logic_vector(6 downto 0):="0110000";
  Constant HexF: std_logic_vector(6 downto 0):="0111000";

begin
  process(E)
  begin
   if (C='0')then
      case( E ) is
        when "0000" => O <= Dig0;
        when "0001" => O <= Dig1;
        when "0010" => O <= Dig2;
        when "0011" => O <= Dig3;
        when "0100" => O <= Dig4;
        when "0101" => O <= Dig5;
        when "0110" => O <= Dig6;
        when "0111" => O <= Dig7;
        when "1000" => O <= Dig8;
        when "1001" => O <= Dig9;
        when "1010" => O <= HexA;
        when "1011" => O <= Dig8;
        when "1100" => O <= HexC;
        when "1101" => O <= Dig0;
        when "1110" => O <= HexE;
        when "1111" => O <= HexF;
        when others => O <= Apag;
      end case;
  else
    case ( E ) is
      when "0000" => O <= Dig0;
      when "0001" => O <= Dig1;
      when "0010" => O <= Dig2;
      when "0011" => O <= Dig3;
      when "0100" => O <= Dig4;
      when "0101" => O <= Dig5;
      when "0110" => O <= Dig6;
      when "0111" => O <= Dig7;
      when "1000" => O <= Dig8;
      when "1001" => O <= Dig9;
      when others => O <= Apag;
    end case;
  end if;
end process;
end architecture;
