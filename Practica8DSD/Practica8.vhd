library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memROM is
	port
	(
		Clock: inout std_logic;
		Reset, Enable, reed: in std_logic;
		Address: in std_logic_vector(4 downto 0);
		Data: out std_logic_vector(7 downto 0);
		mux: inout std_logic_vector(3 downto 0 )
	);
end memROM;

architecture Behavioral of memROM is
COMPONENT  OSCH
	GENERIC (NOM_FREQ: string);
	PORT(STDBY: in std_logic; OSC: out std_logic);
END COMPONENT;
attribute NOM_FREQ : string;
attribute NOM_FREQ of OSCinst0 : label is "53.20";
signal m: std_logic_vector(3 downto 0):="0001";
 
type  memROM_Array is array (0  to  31) of std_logic_vector(7 downto 0);
constant Content: memROM_Array := 
	(
		 0 => "01101110",
		 1 => "11111100",
		 2 => "00011100",
		 4 => "11101110",
		 5 => "00000110",
		 6 => "00000111",
		 7 => "00001000",
		 8 => "00001001",
		 9 => "00001010",
		10 => "00001011",
		11 => "00001100",
		12 => "00001101",
		13 => "00001110",
		14 => "00001111",
		OTHERS => "11111111"
	);
signal clk_low: std_logic;
signal disp1,disp2,disp3,disp4: std_logic_vector(7 downto 0):="00000000";

begin 
	OSCInst0 : OSCH GENERIC MAP("53.20")PORT MAP ('0', Clock);
	
	
	lowClk: process(Clock)  
		VARIABLE count: INTEGER RANGE 0 to 13300000;
		variable muxcount: integer range 0 to 600;
	begin
		IF (Clock'EVENT AND Clock='1' )THEN
			IF(count < 13300000) THEN  				
				count := count+1; 
			ELSE
				count :=0;  
				clk_low <= NOT clk_low;
			END IF;
			
			IF(muxcount < 600) THEN  				
				muxcount := muxcount+1; 
			ELSE
				m<=m(2 downto 0)&m(3); 	
				muxcount :=0;  
			END IF;
		END IF; 
		
	end process; 
	
	
	process(clk_low, Reset, reed, Address)
	begin
		if (Reset = '1') then
			disp1 <= "00000000";
			disp2 <= "00000000";
			disp3 <= "00000000";
			disp4 <= "00000000";
		elsif (clk_low'event and clk_low = '1') then
			if Enable = '1' then
				if(reed = '1') then
					disp1 <= Content(conv_integer(Address));
					disp2 <= Content(conv_integer(Address+1));
					disp3 <= Content(conv_integer(Address+2));
					disp4 <= Content(conv_integer(Address+3));
				else
					disp1 <= "00000000";
					disp2 <= "00000000";
					disp3 <= "00000000";
					disp4 <= "00000000";
				end if;
			end if;
		end if;
	end process;
	
	muxDisp: process (m) 
	begin 
	mux <= m;
		case m is
			when "0001" => Data <= disp1;
			when "0010" => Data <= disp2;
			when "0100" => Data <= disp3;
			when "1000" => Data <= disp4;
			when others => Data <= "00000000";
		end case;
	end process;
end Behavioral;
 

