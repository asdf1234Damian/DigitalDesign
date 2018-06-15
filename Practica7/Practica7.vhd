library ieee;
use ieee.std_logic_1164.all;

entity MUX is
  port (
  A,B: in std_logic;
  S: in std_logic_vector(2 downto 0);
  Z: out  std_logic
  );
end entity;
architecture archMUX of MUX is
begin
  process(A,B,S)
  begin
    case( S ) is
      when "000" => z <= a or b;
      when "001" => z <= a and b;
      when "010" => z <= a nor b;
      when "011" => z <= a nand b;
      when "100" => z <= a xor b;
      when "101" => z <=a xnor b;
      when "110" => z <= not a;
      when others => z<= not b;
    end case;
  end process;

end architecture;
