library ieee;
use ieee.std_logic_1164.all;

entity Encoder is
  port (
  Input: in std_logic_vector(9 downto 0);
  Output: out std_logic_vector(3 downto 0)
  );
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
  identifier : process(Input)
  begin
    if (Input = "0000000000") then
      Output<=Apag;
    elsif (Input = "0000000001") then
      Output<=Dig0;
    elsif (Input > "0000000001" and Input <= "0000000011") then
      Output<=Dig1;
    elsif (Input > "0000000011" and Input <= "0000000111") then
      Output<=Dig2;
    elsif (Input > "0000000111" and Input <= "0000001111") then
      Output<=Dig3;
    elsif (Input > "0000001111" and Input <= "0000011111") then
      Output<=Dig4;
    elsif (Input > "0000011111" and Input <= "0000111111") then
      Output<=Dig5;
    elsif (Input > "0000111111" and Input <= "0001111111") then
      Output<=Dig6;
    elsif (Input > "0001111111" and Input <= "0011111111") then
      Output<=Dig7;
    elsif (Input > "0011111111" and Input <= "0111111111") then
      Output<=Dig8;
    elsif (Input > "0111111111" and Input <= "1111111111") then
      Output<=Dig9;
    end if;
  end process;
end architecture;
