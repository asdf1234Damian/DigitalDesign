library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity read_EEPROM is 
    port(
        IN_Address : in std_logic_vector(7 downto 0);
        EEPROM_Address : out std_logic_vector(7 downto 0);
        EEPROM_Data : out std_logic_vector(7 downto 0);
        counter : inout;
    );
end entity;