library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testBench is 
	port(
	Start : in std_logic;
	rw,rs,e : out std_logic;
	lcd_data :out std_logic_vector(7 downto 0);
	selchr : in std_logic_vector(1 downto 0);
	FlagReg: inout std_logic_vector(3 downto 0);
	sel : inout std_logic_vector(1 downto 0);
	pcview : out std_logic_vector(7 downto 0):="00000000"
	);  
end entity;   
  
architecture behavioral of testbench is 
component lcd_controller IS
  PORT(
	clk : in std_logic;
	reset_n    : IN    STD_LOGIC;  --active low reinitializes lcd
	rw, rs, e  : OUT   STD_LOGIC;  --read/write, setup/data, and enable for lcd
	lcd_data   : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0); --data signals for lcd
	missing : in std_logic_vector(7 downto 0);
	line1_buffer : IN STD_LOGIC_VECTOR(63 downto 0); -- Data for the top line of the LCD
	line2_buffer : IN STD_LOGIC_VECTOR(7 downto 0)); -- Datak  for the bottom line of the LCD
END component;
   
   
component ALU is   
port( 
	a, b: in std_logic_vector(15 downto 0); 
	mux : in std_logic_vector(3 downto 0);
	flags : out std_logic_vector(3 downto 0); 
	o : inout std_logic_vector(15 downto 0) 
	); 
end component;
    
component OSCH
	generic(NOM_FREQ: string);
	port(
	STDBY: in std_logic;   
	OSC: out std_logic
	);  
end component;  
 
component divFreq is   
	generic(
	div :integer
	);
	port(
	osc : in std_logic;
	clk: inout std_logic 
	); 
end component; 

component dispMux is 
	port( 
	clk, neg, ischar : in std_logic;
	bin : in std_logic_vector(9 downto 0);
	char : in std_logic_vector(19 downto 0);
	mux : inout std_logic_vector(3 downto 0) := "0001";
	disp : out std_logic_vector(7 downto 0)
	);
end component;
------------------------------------------------------------------ROM
constant addrssA : integer:=36;
constant addrssB : integer:=41;
constant addrssC : integer:=46;
constant addrssD : integer:=51;
--Complemento a 1, not
constant ALUComp1: std_logic_vector(7 downto 0) := "00000001";
--Operacion and
constant ALUandOP: std_logic_vector(7 downto 0) := "00000010";
--Complemento a 1, not + 1
constant ALUComp2: std_logic_vector(7 downto 0) := "00000011";
--Operacion or
constant ALUorOP: std_logic_vector(7 downto 0) := "00000100";
--Logic Shift Left
constant ALULSL: std_logic_vector(7 downto 0) := "00000101";
--Arith Shift Right
constant ALUASR: std_logic_vector(7 downto 0) := "00000110";
--Add two numbers
constant ALUADD: std_logic_vector(7 downto 0) := "00000111";
--Substract
constant ALUSUB: std_logic_vector(7 downto 0) := "00001000";
--Multiplication
constant PROD: std_logic_vector(7 downto 0) := "00001001";
--Division
constant DIV: std_logic_vector(7 downto 0) := "00001010";
--Move data grom ROM to REG
constant ROMtoREG: std_logic_vector(7 downto 0) := "00001011";
--Move form constant to reg
constant CPCNSREG: std_logic_vector(7 downto 0) := "00001100";
--Copy from reg orig to reg Dest
constant CPOrDe: std_logic_vector(7 downto 0) := "00001101";
--Save MBR to REG
constant SaveMBR : std_logic_vector(7 downto 0) := "00001110";
--jmp
constant JUMP: std_logic_vector(7 downto 0) := "00001111";
--Branch
constant Branch: std_logic_vector(7 downto 0) := "00010000";
-- TODO branches  and flags and ram functopn
--Write MBR in RAM
constant MBRtoRAM: std_logic_vector(7 downto 0) := "00010001";
--Move from ram to reg
constant read_RAM: std_logic_vector(7 downto 0) := "00010010";
--Move from ram to reg
constant ROMtoRAM: std_logic_vector(7 downto 0) := "00010011";
--HALT
constant HALT: std_logic_vector(7 downto 0) := "11111111";
type MemArr is array (200 downto 0) of std_logic_vector(7 downto 0);
type miniROM is array (15  downto 0) of std_logic_vector(15 downto 0);
constant ROM_Program: MemArr :=
	(
		--Palabra : Pastrana (P_str_n_)
		0   => "01010000", --P
		1   => "01100001", --a
		2   => "01110011", --s
		3   => "01110100", --t
		4	=> "01110010", --r
		5 	=> "01100001", --a
		6	=> "01101110", --n
		7	=> "01100001", --a
		8	=> "10111010", --missingltrs
		-- Palabra : habanero (ha__ner_)
		9  	=>	"01101000", --h
		10  => 	"01100001", --a
		11  =>	"01100010", --b
		12	=>	"01100001", --a
		13	=>	"01101110", --n
		14 	=>	"01100101", --e
		15  =>	"01110010", --r
		16 	=>	"01101111", --o
		17	=>  "11001110", --missingltrs
		-- Palabra : cafetera (c_f_t___)
		18 	=>	"01100011", --c
		19	=>	"01100001", --a
		20	=>	"01100110", --f
		21	=>	"01100101", --e
		22 	=>	"01110100", --t
		23	=>	"01100101", --e
		24 	=>	"01110010", --r
		25	=>	"01100001", --a
		26	=>  "11001110", --missingltrs
		-- Palabra : abreviar (abr___ar)
		27	=>	"01100001", --a
		28	=>	"01100010", --b
		29	=>	"01110010", --r
		30	=>	"01100101", --e
		31	=>	"01110110", --v
		32	=>	"01101001", --i
		33	=>	"01100001", --a
		34	=>	"01110010", --r
		35	=>  "11001110", --missingltrs
		-- Inicializacion de variables 
		-- Palabra 1: inicia en 0
		36  => ROMtoREG, -- Carga el indice y se va a la funcion principal
		37  => "00000001",
		38  => "00000000",
		39  => JUMP,
		40 	=> "00111000",
		-- Palabra 2: inicia en 9
		41  => ROMtoREG, -- Carga el indice y se va a la funcion principal
		42  => "00000001",-- 
		43  => "00001001",
		44  => JUMP,
		45 	=> "00111000",
		-- Palabra 3: inicia en 18
		46  => ROMtoREG, -- Carga el indice y se va a la funcion principal
		47  => "00000001",
		48  => "00010010",
		49  => JUMP,
		50 	=> "00111000",
		-- Palabra 4: inicia en 27
		51  => ROMtoREG, -- Carga el indice y se va a la funcion principal
		52  => "00000001",
		53  => "00011011",
		54  => JUMP,
		55 	=> "00111000",
		-- Comienza a cargar la palabra a la ram
		-- -- Inicializacion de variables
		56  => ROMtoREG, -- i = 0
		57  => "00000000",--reggen(0)
		58  => "00000000",-- 0
		59  => ROMtoREG, -- step = 1
		60  => "00000010",--reggen(2)
		61  => "00000001",-- 1
		62  => ROMtoREG, -- size= 8
		63  => "00000011",--reggen(3)
		64  => "00001001",-- 8
		-- -- Ciclo
		65  => ROMtoRAM, --ROM(j) to RAM(i) 
		66 	=> "00000000", -- dest ram i(reggen(0))
		67  => "00000001", -- orig rom j(reggen(1))
		68  => ALUADD, 
		69  => "00000010",-- i + step
		70  => SaveMBR,
		71  => "00000000",-- i = i+1-- 
		72  => ALUADD, 
		73  => "00010010",-- j + step
		74  => SaveMBR,
		75  => "00000001",-- j = i+1
		76  => ALUSUB,
		77  => "00000011",-- i-size
		78  => Branch,	  -- if i - size != 0 
		79  => "00001001",
		80  => "01000001",-- Goto  
		-- --Empieza ciclo for	
		-- 32  => ROMtoRAM, --From rom to RAM ram(i) = rom (i)
		-- 33  => "00000000",--dest ram i
		-- 34  => "00000000",--orig rom i
		-- 35  => ALUADD, 
		-- 36  => "00000100",--i  + 1
		-- 37  => SaveMBR,
		-- 38  => "00000000",--i = i+1
		-- 39  => ALUSUB,
		-- 40  => "00000010",--i-tam mensaje 
		-- 41  => Branch,	  --if i - tam != 0 
		-- 42  => "00001001",
		-- 43  => "00100000",-- Goto  
		-- --Termina ciclo para cargar a ram
		-- --Se inicializa i a 0
		-- 44  => ROMtoREG ,--ROM to REGSGEN i = 0
		-- 45  => "00000000",--Regsgen(0) 
		-- 46  => "00000000",--0 contador
		-- --Mover mensaje de ROM a RAM
		-- 47  => CPOrDe,-- Move char 
		-- 48  => "11111110",--char(2)to char(3)
		-- 49  => CPOrDe,--Move char
		-- 50  => "11101101",--char(2)to char(3)
		-- 51  => CPOrDe,--Movechar
		-- 52  => "11011100",--char(1)to char(2)
		-- 53  => read_RAM,--Load char from ram
		-- 54  => "00001100",-- into reggen 12 
		-- 55  => "00000000",-- from ram(0)=1
		-- 56  => ALUADD, 
		-- 57  => "00000100",--i  + 1
		-- 58  => SaveMBR,
		-- 59  => "00000000",--i = i+1
		-- 60  => ALUSUB, 
		-- 61  => "00000010",
		-- 62  => Branch, 
		-- 63  => "00001001",
		-- 64  => "00101111",
		-- 65  => ALUADD, 
		-- 66  => "00010100",--j  + 1
		-- 67  => SaveMBR,
		-- 68  => "00000001",--i = i+1
		-- 69  => ALUSUB, 
		-- 70  => "00010011",
		-- 71  => Branch, 
		-- 72  => "00001001",
		-- 73  => "00101100",
		-- -- Re establecer variables
		-- 74  => ROMtoREG ,--ROM to REGSGEN i = 0
		-- 75  => "00000000",--Regsgen(0) 
		-- 76  => "00000000",--0 contador
		-- 77  => ROMtoREG ,--ROM to REGSGEN j = 0
		-- 78  => "00000000",--Regsgen(0) 
		-- 79  => "00000000",--0 contador
		-- 80  => ROMtoREG ,--ROM to REGSGEN t = 50
		-- 81  => "00000101",--Regsgen(5)=t 
		-- 82  => "00000101",--5
		-- 83  => ROMtoREG ,--ROM to REGSGEN ischar = false
		-- 84  => "00001011",--Regsgen(11)=ischar 
		-- 85  => "00000000",--false
		-- --Compienza ciclo interno
		-- 86  => ALUADD,-- i + 50
		-- 87 => "00000101",--
		-- 88 => SaveMBR,--i = i +50
		-- 89 => "00000000",--
		-- 90  => ALUADD,-- j + 1
		-- 91 => "00010100",--
		-- 92 => SaveMBR,--i = j +1
		-- 93 => "00000001",--
		-- 94 => ALUSUB,--
		-- 95 => "00010010",--false 
		-- 96 => BRANCH,--false
		-- 97 => "00001001",--false
		-- 98 => "01010110",--false
		-- 99  => ROMtoREG ,--ROM to REGSGEN ischar = true
		-- 100  => "00001011",--Regsgen(11)=ischar 
		-- 101  => "00000001",--true
		-- 102  => ROMtoREG ,--ROM to REGSGEN j=0
		-- 103  => "00000001",--
		-- 104  => "00000000",--
		-- 105 => jump,
		-- 106 => "00101100",   
		others => ("11111111")
	);  
signal RAM : MemArr :=( others => "00000000"); 
-- Variable para controlar si el mux esta en numeros o chars
signal RegsGen: miniROM:=(others => "0000000000000000"); 
signal rom_var: miniROM:=(others => "0000000000000000");  
signal wordcontent : std_logic_vector(63 DOWNTO 0);
signal wordspaces : std_logic_vector(7 DOWNTO 0);
------------------------------------Registros de proposito especifico
signal PC : integer;  
signal MAR : std_logic_vector(7 downto 0):="00000000";
signal IR : std_logic_vector(7 downto 0):="00000000"; 
signal muxALU : std_logic_vector(3 downto 0) := "0000";
signal MBR, ACC : std_logic_vector(15 downto 0):="0000000000000000"; 
----------------------------------------Registros de entrada a la ALU
signal REGA : std_logic_vector(15 downto 0); 
signal REGB : std_logic_vector(15 downto 0);
signal charSelection : std_logic_vector(7 downto 0) := "01100001";
-----------------------------------------------------Senales de reloj 
signal sigOSC, cuCLK: std_logic;
CONSTANT VEL: string := "7";-----------------Velocidad a modificar
attribute NOM_FREQ: string; 
attribute NOM_FREQ of oschins : label is VEL; 
--------------------------------------------------Inicio del programa 
 begin
 pcview<=std_logic_vector(to_unsigned(Pc,8));
 wordcontent <= RAM(0)(7 DOWNTO 0)&
				ram(1)(7 DOWNTO 0)&
				ram(2)(7 DOWNTO 0)&
				RAM(3)(7 DOWNTO 0)&
				RAM(4)(7 DOWNTO 0)&
				RAM(5)(7 DOWNTO 0)&
				RAM(6)(7 DOWNTO 0)&
				RAM(7)(7 DOWNTO 0);
 wordspaces <= RAM(8)(7 DOWNTO 0);
ControlUnit: process(Start, IR,cuclk)    
	variable state:integer range 0 to 3 :=0;  
begin
	if (Start = '0') then   
		state := 0;
		IR <= "00000000"; 
		RegA <= (others =>'0');
		RegB <= (others =>'0');
		MBR <= "0000000000000000";
		RegsGen<=(others => "0000000000000000");
		case sel is  
			when "00" => PC <= addrssA;
			when "01" => PC <= addrssB;
			when "10" => PC <= addrssC; 
			when others => PC <= addrssD;  
		end case;
	elsif (cuCLK'event and cuCLK = '1' and IR /="11111111")then  
	--Fetch------------------------------------------------------
		if(state = 0)then 
			IR <= ROM_program(PC);  
			MAR <= ROM_program(PC+1);   
			state:=1;
	--Decode---------------------------------------------------------  
		elsif (state = 1 ) then  
			if (IR = "00001011") then -- Cargar dato de ROM_prog a RegsGen
				RegsGen(to_integer(unsigned(MAR))) <= "00000000"&ROM_program(PC+2);
				pc <= pc+3;
				state := 0; 
			elsif (IR = "00001100") then  -- Cargar dato de ROM_Var a RegsGen
				RegsGen(to_integer(unsigned(MAR(7 downto 4)))) <= ROM_Var(to_integer(unsigned(MAR(3 downto 0))));
				state := 0;
				pc <= pc+2; 
			elsif( IR = "00010010") then  --READ RaM? fromo ram to reg
				RegsGen(to_integer(unsigned(MAR))) <= "00000000"&RAM(to_integer(unsigned(regsgen(to_integer(unsigned(ROM_Program(PC+2)))))));
				pc <= pc+3;
				state := 0;
			elsif( IR = "00010001") then  --Write MBR in RAM
				ram(to_integer(unsigned(MAR)))<= MBR(7 downto 0);
				state := 0;
				pc <= pc+2; 
			elsif( IR = "00010011") then  --Write ROM to RAM
				RAM(to_integer(unsigned(regsgen(to_integer(unsigned(MAR)))))) <= rom_program(to_integer(unsigned(regsgen(to_integer(unsigned(ROM_Program(PC+2)))))));
				pc <= pc+3;
				state := 0;
			elsif (IR = "00001101") then -- Copiar reg(orig) a reg(dest)
				RegsGen(to_integer(unsigned(MAR(7 downto 4))))<= RegsGen(to_integer(unsigned(MAR(3 downto 0)))) ;
				state := 0;
				pc <= pc+2;
			elsif (IR = "00001110") then -- Copiar MBR a reg(dest) 
				RegsGen(to_integer(unsigned(MAR)))<= MBR; 
				state := 0;
				pc <= pc+2;  
			elsif( IR = "00010000") then  --Branch 
				if((MAR(3 downto 0) xor flagReg)="0000") then 
					pc <= to_integer(unsigned(rom_program(pc+2)));
				else  
					pc <= pc+3; 
				end if;			
				state := 0;
			elsif( IR = "00001111") then  --JUMP
				pc <= to_integer(signed(MAR));
				state := 0;
			else  
				muxalu <= ir(3 downto 0 );
				RegA <= RegsGen(to_integer(unsigned(MAR(7 downto 4))));
				RegB <= RegsGen(to_integer(unsigned(MAR(3 downto 0)))); 
				state:=2;
			end if; 
	--Execute--------------------------------------------------------	
		else 
			MBR <= ACC; 
			state := 0;     
			PC <= PC + 2; 
		end if; 
	-- Change state and PC if necessary ----------------------------  
	end if;  
end process;   

currChar: process(cuclk) is 
variable debauncer: integer range 0 to 1000;
begin 
if (cuCLK'event and cuclk = '1') then 
	if (Start /= '0') then  
		if selchr /= "00" then 
			if debauncer <1000 then 
				debauncer:=debauncer+1;
				charSelection <= charselection;
			else
				debauncer:=0;
				case selchr is
					when "01" => 
						if charSelection = "01111010" then 
							charSelection <= "01100001";
						else
							charSelection <= charSelection+1;
						end if;
					when "10" => 
						if charSelection = "01100001" then 
							charSelection <= "01111010";
						else
							charSelection <= charSelection - 1;
						end if;
					when others =>charSelection <= charselection;
				end case;
			end if;
		end if;
end if;
end if; 
end process; 
aluIns: ALU port map(rega,regb,muxalu(3 downto 0),flagReg,acc); 
oschIns: OSCH generic map(VEL) port map('0', sigOSC);  
divCU: divFreq  generic map(700) port map(sigOSC,cuCLK); 
lcd: lcd_controller port map(sigosc,Start,rw,rs,e,lcd_data,wordspaces,wordcontent,charSelection); 
end architecture;       