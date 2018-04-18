library ieee;
use ieee.std_logic_1164.all;

entity SumadorRestador is
  port (
    A,B:in std_logic_vector(3 downto 0);
    Ci:in std_logic;
    S:out std_logic_vector(3 downto 0);
    Cf,OVERFLOW:out std_logic
  );
  attribute pin_numbers of SumadorRestador: entity is
  "A(0):2 A(1):3 A(2):4 A(3):5 B(0):6 B(1):7 B(2):8 B(3):9 Ci:10 S(0):19 S(1):20 S(2):21 S(3):22 OVERFLOW:23";
end entity;

architecture archSumadorRestador  of  SumadorRestador is

  signal C: std_logic_vector(4 downto 1);
  attribute synthesis_off of c: signal is true;
  signal SB: std_logic_vector(3 downto 0);
  attribute synthesis_off of SB: signal is true;
begin
BtoSB : for i in 0 to 3 generate
  SB(i)<= Ci xor B(i);
end generate;
S(0)<=A(0) xor B(0) xor Ci;
C(1)<=(A(0) and (B(0) or Ci)) or (Ci and B(0));
Suma : for i in 1 to 3 generate
  S(i)<=A(i) xor B(i) xor C(i);
  C(i+1)<=(A(i) and (B(i) or C(i))) or (C(i) and B(i));
end generate;
OVERFLOW <= C(3) xor C(4);
Cf<=C(4);
end architecture;
