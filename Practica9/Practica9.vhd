library ieee;
use ieee.std_logic_1164.all;

entity CuadroDeAlarma is
  port (
  a,b,c,d,selct,ref:in std_logic_vector(1 downto 0);
  display :out std_logic_vector(6 downto 0)
  );
  --attribute pin_numbers of CuadroDeAlarma: entity is
   -- "a(0):1 a(1):2 b(2):3 b(3):4 c(4):5 c(5):6 d(6):7 d(7):8 ref(0):11 ref(1):12";
end entity;

architecture arch_cuadrodealarma of CuadroDeAlarma is
signal z:std_logic_vector(1 downto 0);
signal Ma,Me,I:std_logic;
begin
  mux : process(selct,a,b,c,d)
  begin
    case( selct ) is
      when "00" => z <=a;
      when "01" => z <=b;
      when "10" => z <=c;
      when others => z <=d;
    end case;
  end process;
  MagCompo : process(z,ref)
  begin
    if z=ref then
      I<='1';
    elsif z>ref then
      Ma<='1';
    elsif z<ref then
      Me<='1';
    end if;
  end process;
  Deco : process(I,Ma,Me)
  begin
    if (I='1') then
      display<= "0110111";
    elsif (Ma='1') then
      display<= "0000111";
    elsif(Me='1') then
      display<= "1111111";
    end if;
  end process;
end architecture;
