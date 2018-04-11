library ieee;
use ieee.std_logic_1164.all;
--Sumador completo
entity SumadorCompleto is
  port (
    A,B,Ci:in std_logic;
    S,Cf:out std_logic
  );
end entity;
--Comportamiento de Sumador completo
architecture Bhv_SumadorCompleto of SumadorCompleto is
begin
  S<=A xor B xor Ci;
  Cf<= (A and (B or Ci)) or (Ci and B);
end architecture;
--Sumador restador
entity SumRest is
  port (
  A,B: in std_logic_vector(3 downto 0);
  Ci: in std_logic
  S: out std_logic_vector(3 downto 0);
  Cf:out std_logic
  );
end entity;

architecture Arch_SumRes of SumRes is
  signal C1,C2,C3: std_logic ;
begin
  if (Ci='1') then
    B=Not B;
  end if;
  Ciclo : for i in 0 to 3 generate
    S(i)<=A(i) xor B(i) xor C(i);

  end generate;
  if (Control='1') then

  end if;
end architecture;
