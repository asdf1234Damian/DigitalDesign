library ieee; 
use ieee.numeric_std.all;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity Marquezina is
	port(
	 Clock: inout std_logic;
	 mux :inout std_logic_vector(15 downto 0):="0000000000000001";
	 Data : out std_logic_vector(7 downto 0)
	);
end entity;

architecture arch_marquezina of Marquezina is 
COMPONENT  OSCH
			GENERIC (NOM_FREQ: string);
			PORT(STDBY: in std_logic; OSC: out std_logic);
END COMPONENT;
attribute NOM_FREQ: string;
attribute NOM_FREQ of OSCinst0 : label is "53.20";
type  memROM_Array is array (0  to  146) of std_logic_vector(7 downto 0);
constant Content: memROM_Array := 
	(
		 0 => "00111100",
		 1 => "01000010", 
		 2 => "10010101",
		 3 => "10100001",
		 4 => "10100001",
		 5 => "10010101", 
		 6 => "01000010", 
		 7 => "00111100",
		 8 => "10000000",
		 9 => "10000000",
		10 => "10000000",
		11 => "11111111",
		12 => "00011000",
		13 => "00011000",
		14 => "00011000",
		15 => "11111111",
		16 => "00000000",
		17 => "01110000",
		18 => "10001000",
		19 => "10001000",
		20 => "10001000",
		21 => "01110000",
		22 => "00000000",
		23 => "11111111",
		24 => "00000000",
		25 => "01000000",
		26 => "10101000",
		27 => "10101000",
		28 => "10101000",
		29 => "11110000",
		30 => "00000000",
		31 => "11111111",
		32 => "10010001",
		33 => "10010001",
		34 => "10010001",
		35 => "10000001",
		36 => "10000001",
		37 => "00000000",
		38 => "01000110",
		39 => "10001001",
		40 => "10001001",
		41 => "10001001",
		42 => "01110001",
		43 => "00000000",
		44 => "01111110",
		45 => "10000001",
		46 => "10000001",
		47 => "10000001",
		48 => "01000010",
		49 => "00000000",
		50 => "01111110",
		51 => "10000001",
		52 => "10000001",
		53 => "10000001",
		54 => "01111110",
		55 => "00000000",
		56 => "11111111",
		57 => "00000010",
		58 => "00001100",
		59 => "00000010",
		60 => "11111111",
		61 => "00010000",
		62 => "00010000",
		63 => "00010000",
		64 => "10000001",
		65 => "11111111",
		66 => "10000001",
		67 => "00000000",
		68 => "11111111",
		69 => "00010001",
		70 => "00010001",
		71 => "00001110",
		72 => "00000000",
		73 => "11111111",
		74 => "00001100",
		75 => "00011000",
		76 => "01100000",
		77 => "11111111",
		78 => "00000000",
		79 => "11111111",
		80 => "10000001",
		81 => "10000001",
		82 => "01000010",
		83 => "00111100",
		84 => "00000000",
		85 => "01000110",
		86 => "10001001",
		87 => "10001001",
		88 => "10001001",
		89 => "01110001",
		90 => "00000000",
		91 => "11111111",
		92 => "10000001",
		93 => "10000001",
		94 => "01000010",
		95 => "00111100",
		96 => "00000000",
		97 => "00010000",
		98 => "00010000",
		99 => "01111100",
		100=> "00010000",
		101=> "00010000",
		102=> "00000000",
		103=> "11111111",
		104=> "10010001",
		105=> "10010001",
		106=> "10010001",
		107=> "10000001",
		108=> "00000000",
		109=> "11111111",
		110=> "00000000",
		111=> "11111111",
		112=> "00010001",
		113=> "00110001",
		114=> "01010001",
		115=> "10001110",
		116=> "01110000",
		117=> "10001000",
		118=> "10001000",
		119=> "10001000",
		120=> "01110000",
		121=> "00000000",
		122=> "10010000",
		123=> "10101000",
		124=> "10101000",
		125=> "10101000",
		126=> "01001000",
		127=> "00000000",
		128=> "01000000",
		129=> "10101000",
		130=> "10101000",
		131=> "10101000",
		132=> "11110000",
		133=> "00000000",
		134=> "11111000",
		135=> "00010000",
		136=> "00001000",
		137=> "00001000",
		138=> "00010000",
		139=> "00000000",
		140=> "11110100",
		141=> "00000000",
		142=> "01110000",
		143=> "10001000",
		144=> "10001000",
		145=> "10001000",
		146=> "01110000",
		OTHERS => "00000000"
	);
	signal Adress: integer range 0 to 147;
begin	OSCInst0 : OSCH GENERIC MAP("53.20")PORT MAP ('0', Clock);
	lowClk: process(Clock)  
		variable count: integer range 0 to 13300;
		variable ring: integer range 0 to 13300000;
	begin
		if (Clock'event and Clock='1' ) then 
			if(count < 13300) then			
				count:= count+1; 
			else
				mux<=mux(14 downto 0)&mux(15); 	
				count :=0;  
			end if; 
			 
			if(ring < 13300000) then			
				ring:= ring+1; 
			else
				if (conv_integer(Adress)= 146) then 
					Adress <= 0; 
				else
					Adress <= Adress+1;
				end if;
				ring :=0;  
			end if;
		end if; 
	end process; 
	
	muxDisp: process (mux) 
	begin 
		case mux is
			when "1000000000000000" => Data <= Content(conv_integer(Adress));
			when "0100000000000000" => Data <= Content(conv_integer(Adress)+1);
			when "0010000000000000" => Data <= Content(conv_integer(Adress)+2);
			when "0001000000000000" => Data <= Content(conv_integer(Adress)+3); 
			when "0000100000000000" => Data <= Content(conv_integer(Adress)+4);
			when "0000010000000000" => Data <= Content(conv_integer(Adress)+5);
			when "0000001000000000" => Data <= Content(conv_integer(Adress)+6);  
			when "0000000100000000" => Data <= Content(conv_integer(Adress)+7);
			when "0000000010000000" => Data <= Content(conv_integer(Adress)+8);
			when "0000000001000000" => Data <= Content(conv_integer(Adress)+9);
			when "0000000000100000" => Data <= Content(conv_integer(Adress)+10);
			when "0000000000010000" => Data <= Content(conv_integer(Adress)+11);
			when "0000000000001000" => Data <= Content(conv_integer(Adress)+12);
			when "0000000000000100" => Data <= Content(conv_integer(Adress)+13);
			when "0000000000000010" => Data <= Content(conv_integer(Adress)+14);
			when "0000000000000001" => Data <= Content(conv_integer(Adress)+15);
			when others => Data <= "00000000";
		end case; 
	end process;

end architecture; 