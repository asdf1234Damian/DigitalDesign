library ieee;
use ieee.std_logic_1164.all;

entity FFT is
  port (
  toggle,clr,pre,clock: in std_logic;
  q,nq: out std_logic
  );
end entity;

architecture archFFT of  FFT is
  signal temp: std_logic;
begin
  process(clr,pre,temp,toggle,clock)
  begin
    if clr ='0' then
      temp <= '0';
    elsif (clock'event and clock='1') then
      if (pre='1') then
        temp <= '1';
      else
        temp <= temp xor toggle;
      end if;
    end if;
  end process;
  q<=temp;
  nq<= not temp;
end architecture;
