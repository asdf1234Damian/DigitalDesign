library ieee;
use ieee.std_logic_1164.all;

entity HolaPalabra is--HOLAALOH
  port (
  InVec: in std_logic_vector(3 downto 0);
  Control: in std_logic;
  OutVec: out std_logic_vector(6 downto 0)
  );
  attribute pin_numbers of HolaPalabra: entity is
    "InVec(0):2 InVec(1):3 InVec(2):4 InVec(3):5 Control:6 OutVec(0):17 OutVec(1):18 OutVec(2):19 OutVec(3):20 OutVec(4):21 OutVec(5):22 OutVec(6):23";
end entity;
architecture archHolaPalabra of  HolaPalabra is

  Constant AlfH: std_logic_vector(6 downto 0):= "1001000";
  Constant AlfO: std_logic_vector(6 downto 0):= "0000001";
  Constant AlfL: std_logic_vector(6 downto 0):= "1110001";
  Constant AlfA: std_logic_vector(6 downto 0):= "0001000";
  Constant AlfB: std_logic_vector(6 downto 0):= "0011000";
  Constant Apag: std_logic_vector(6 downto 0):= "1111111";
begin
process(Control ,InVec)
begin
  if (Control='0') then
    case( InVec ) is
      when "0000" => OutVec <= AlfH;
      when "0001" => OutVec <= AlfO;
      when "0011" => OutVec <= AlfL;
      when "0111" => OutVec <= AlfA;
      when others => OutVec <= Apag;
    end case;
  else
    case( InVec ) is
      when "0000" => OutVec <= AlfA;
      when "0001" => OutVec <= AlfL;
      when "0011" => OutVec <= AlfO;
      when "0111" => OutVec <= AlfH;
      when others => OutVec <= Apag;
    end case;
  end if;
end process;
end architecture;
