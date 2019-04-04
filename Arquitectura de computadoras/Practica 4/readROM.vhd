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
    ROM_OE: std_logic;
  );
end entity;


architecture readRom_Arch of readRom is
  signal state :integer:=0;
  signal counter : integer:=0;
begin
  case(state) is
    ROM_address<='ZZZZZZZZ';
    FPGA_res<='ZZZZZZZZ';
    when 0 =>
      ROM_CE <= 1;
      ROM_CE <= 1;
      counter+;
      if counter < 2 then
        counter:= 0;
        state:= 1;
	:end if;
    when 1 =>
      ROM_address<=FPGA_address;
      ROM_CE <= 0;
      ROM_OE <= 0;
      counter+;
      if counter < 5 then
        counter:= 0;
        state:= 2;
        FPGA_res <= ROM_res;
      end if
    when others =>
      FPGA_res <= ROM_res;
      ROM_CE <= 0;
      ROM_OE <= 0;
      counter+;
      if counter < 1 then
        counter:= 0;
        state:= 0;
      end if
  end case;
end architecture;
