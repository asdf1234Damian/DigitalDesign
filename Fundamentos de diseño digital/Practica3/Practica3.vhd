library ieee;
use ieee.std_logic_1164.all;

entity SumadorRestador is
  port (
    A,B:in std_logic_vector(3 downto 0);
    Ci:in std_logic;
    S:out std_logic_vector(3 downto 0);
    Cf:out std_logic
  );
  attribute pin_numbers of SumadorRestador: entity is
    "A(0):2 A(1):3 A(2):4 A(3):5 B(0):6 B(1):7 B(2):8 B(3):9 Ci:10 S(0):19 S(1):20 S(2):21 S(3):22 Cf:23";
end entity;

architecture archSumadorRestador  of  SumadorRestador is

  signal C: std_logic_vector(4 downto 0);
  attribute synthesis_off of c: signal is true;
  signal SB: std_logic_vector(3 downto 0);
  --attribute synthesis_off of SB: signal is true;
begin
BtoSB : for i in 0 to 3 generate
  SB(i)<= Ci xor B(i);
end generate;
C(0)<=Ci;
Suma : for i in 0 to 3 generate
  S(i)<=A(i) xor SB(i) xor C(i);
  C(i+1)<=(A(i) and SB(i)) or (A(i) and C(i)) or (SB(i) and C(i));
end generate;
Cf<=  C(4);
end architecture;
