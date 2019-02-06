
library ieee;
use ieee.std_logic_1164.all;

entity dosEntradas is 
	port(
    a,b: in std_logic;
    z: out std_logic
    );
 end entity;
 
 architecture archXOR2 of dosEntradas is
 begin 
	 process(a,b) 
	 begin 
		 if(a =b) then 
			z<='0';
		 else
			z<='1';
		end if;
	end process;
 end architecture;