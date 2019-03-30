library ieee;
use ieee.std_logic_1164.all;

entity readROm is
  port(
    FPGA_clkSig : in std_logic,
    FPGA_address : in std_logic_vector(7 downto 0),
    FPGA_res : out std_logic_vector(7 downto 0),
    ROM_address : out std_logic_vector(7 downto 0),
    ROM_res : out std_logic_vector(7 downto 0),
    ROM_CE: std_logic,
    ROM_: std_logic;
  );
end entity;


architecture readRom_Arch of readRom is
  signal state :integer:=0;
  signal counter : integer:=0;
begin
  case(state) is
    when 0 =>
      ROM_address<='ZZZZZZZZ';
      ROM_CE <= 1;
      ROM_CE <= 1;
      counter+;
      
    when IDLE =>
    when others =>
  end case;
end architecture;
