library ieee;
use ieee.std_logic_1164.all;
entity Comparador is
  port (
    A,B: in std_logic_vector(3 downto 0);
    I,MA,ME: out std_logic
  );
end entity;
architecture arch1Comparador of Comparador is
begin
    I<='1' when (A=B)else'0';
    MA<='1' when (A>B)else'0';
    ME<='1' when (A<B)else'0';
end architecture;

architecture  arch2Comparador of Comparador is
begin
  Version5 : process(A,B)
  begin
    if (A=B) then
      I<='1';
    else
      I<='0';
    end if;
  end process;
end architecture;

architecture arch3Comparador of Comparador is
begin
  Version6 : process(A,B)
  begin
    MA<=ME<=I<='0';
    if(A=B) then
      I<='1';
    elsif (A>B) then
      MA<='1';
    else
      ME<='1';
    end if;
  end process;
end architecture;
