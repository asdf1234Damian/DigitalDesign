library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity displayLCD is 
	port(
	datainput: in std_logic_vector(63 downto 0) := "0110000101100010011000110110010001100101011001100110011101101000";
	missingpos: in std_logic_vector(7 downto 0) := "10101010";
	clk : in std_logic;
	databus : out std_logic_vector(7 downto 0);
	rs,rw : out  std_logic
	);
end entity;

architecture arch_displ_lcd of displayLCD  is
signal indx : integer  range 0 to 8 := 0; 
signal state :  std_logic := '0';
signal count : integer range 0 to 1000 :=0;
constant undrscr : std_logic_vector(7 downto 0) := "10101111";
begin
process(clk)is
begin
if( clk'event and clk = '1') then 
	if state = '1' then 
		if indx = 8 then 
			indx <=0;
		else 
			if (missingpos(indx) = '1' )then
				databus <= datainput(indx+7 downto indx);
			else
				databus <= undrscr;
			end if;  		
			indx <=indx+1; 
		end if;   
	else
		if count <1000 then 
			count <= count +1;
			rs <='0';
			rw <='0';
			databus <= "00110000";
		end if; 			
	end if;
end if;  
end process;
end architecture;
  