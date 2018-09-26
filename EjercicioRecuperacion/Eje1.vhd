library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity ejercicio is 
	port(
		q: in std_logic_vector(3 downto 0);
		rst: in std_logic;
		d: out std_logic_vector(3 downto 0)
	);
end entity;

architecture archEjercicio of Ejercicio is 
	COMPONENT OSCH
		GENERIC (NOM_FREQ: string);
		PORT (STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;
begin 

end architecture;