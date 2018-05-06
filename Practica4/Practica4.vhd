library ieee;
use ieee.std_logic_1164.all;
--Incluir un control para que cambie de grey a bianrio y al revez
--Intentar 9
entity Converter  is
  port (
    E: in std_logic_vector(3 downto 0);
    G: out std_logic_vector(3 downto 0)
  );
  attribute pin_numbers of Converter: entity is
    "E(0):2 E(1):3 E(2):4 E(3):5 G(0):20 G(1):21 G(2):22 G(3):23";
end entity;
--Version 2
architecture archConverter2 of Converter   is
begin
  Convertir : for i in 0 to 2 generate
    G(i)<= E(i) xor E(i+1);
  end generate;
end architecture;

--Version3
architecture archConverter3 of Converter is
begin
  G<= E xor ('0'&E3&E2&E1);
end architecture;
--Version4
architecture archConverter4 of Converter is
  signal Aux: std_logic_vector(3 downto 0);
begin
  Aux<=to_stdlogicvector(to_bitvector(E)SRL 1);
  G<=E xor Aux;
  --G<=E xor to_stdlogicvector(to_bitvector(E)SRL 1);
end architecture;
