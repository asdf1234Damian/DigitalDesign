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
library ieee;
use ieee.std_logic_1164.all;
entity SumRest is
  port (
    A,B: in std_logic_vector(3 downto 0);
    Control: in std_logic;
    S: out std_logic_vector(3 downto 0);
    Cf,OVERFLOW:out std_logic);
end entity;

--Arquitectura Sumaador-restador
architecture Arch_SumRes of SumRest is
  component SumadorCompleto is
    port(
      A,B,Control: in std_logic;
      S,Cf: out std_logic
    );
  end component;
    signal C: std_logic_vector(4 downto 1);
    signal Tmp: std_logic_vector(3 downto 0);
begin
  SB : for i in  0 to 3 generate
    Tmp(i)<=Control xor B(i);
  end generate;
  Sumador0:SumadorCompleto port map(A(0),Tmp(0),Control,S(0),C(1));
  Sumador1:SumadorCompleto port map(A(1),Tmp(1),C(1),S(1),C(2));
  Sumador2:SumadorCompleto port map(A(2),Tmp(2),C(2),S(2),C(3));
  Sumador3:SumadorCompleto port map(A(3),Tmp(3),C(3),S(3),C(4));
  OVERFLOW <= C(3) xor C(4);
  Cf<=C(4);
end architecture;
--
--historia
--estado
--razones funancieras
--puntualizado ??? los 2
