library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testBench is 
	port(
	Start : in std_logic;
	disp : out std_logic_vector(7 downto 0);
	dmux : inout  std_logic_vector(3 downto 0);
	FlagReg: inout std_logic_vector(3 downto 0);
	sel : inout std_logic_vector(1 downto 0);
	pcview : out std_logic_vector(7 downto 0):="00000000"
	);
end entity;  
     
architecture behavioral of testbench is 
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
constant addrssA : integer:=0;
constant addrssB : integer:=20;
constant addrssC : integer:=20;
constant addrssD : integer:=20;
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
		------Comienza funcion 1----------------------
		0   => "00010010",--H
		1   => "00000000",--0
		2   => "00010011",--L
		3   => "00010001",--A
		4   => "00011101",--
		5   => "00010100",--E
		6   => "00000101",--5
		7   => "00011001",--C
		8   => "00000000",--0
		9   => "00010101",--r
		10  => "00010110",--n
		11  => "00011110",--.
		12  => "00011110",--.
		13  => "00011110",--.
		14  => "00010111",--b
		15  => "00011000",--y
		16  => "00010100",--E
		17  => "00011111",---
		18  => "00011111",---
		19  => "00011111",---
		-- Inicializacion de variables 
		20  => ROMtoREG,--ROM to REGSGEN  ischar  =  true
		21  => "00001011",--Regsgen(11)=ischar
		22  => "00000001",--true/falsee
		23  => ROMtoREG,--ROM to REGSGEN x = tam mensaje
		24  => "00000010",--Regsgen(2)=x 
		25  => "00010100",--0 contadors
		26  => ROMtoREG, --ROM to REGSGEN y = num rep
		27  => "00000011",--RegsGen(3)=y
		28  => "00000001",--num rep
		29  => ROMtoREG, --ROM to REGSGEN s = step
		30  => "00000100",--RegsGen(4)=step
		31  => "00000001",--rep
		--Empieza ciclo for	
		32  => ROMtoRAM, --From rom to RAM ram(i) = rom (i)
		33  => "00000000",--dest ram i
		34  => "00000000",--orig rom i
		35  => ALUADD, 
		36  => "00000100",--i  + 1
		37  => SaveMBR,
		38  => "00000000",--i = i+1
		39  => ALUSUB,
		40  => "00000010",--i-tam mensaje 
		41  => Branch,	  --if i - tam != 0 
		42  => "00001001",
		43  => "00100000",-- Goto  
		--Termina ciclo para cargar a ram
		--Se inicializa i a 0
		44  => ROMtoREG ,--ROM to REGSGEN i = 0
		45  => "00000000",--Regsgen(0) 
		46  => "00000000",--0 contador
		--Mover mensaje de ROM a RAM
		47  => CPOrDe,-- Move char 
		48  => "11111110",--char(2)to char(3)
		49  => CPOrDe,--Move char
		50  => "11101101",--char(2)to char(3)
		51  => CPOrDe,--Movechar
		52  => "11011100",--char(1)to char(2)
		53  => read_RAM,--Load char from ram
		54  => "00001100",-- into reggen 12 
		55  => "00000000",-- from ram(0)=1
		56  => ALUADD, 
		57  => "00000100",--i  + 1
		58  => SaveMBR,
		59  => "00000000",--i = i+1
		60  => ALUSUB, 
		61  => "00000010",
		62  => Branch, 
		63  => "00001001",
		64  => "00101111",
		65  => ALUADD, 
		66  => "00010100",--j  + 1
		67  => SaveMBR,
		68  => "00000001",--i = i+1
		69  => ALUSUB, 
		70  => "00010011",
		71  => Branch, 
		72  => "00001001",
		73  => "00101100",
		-- Re establecer variables
		74  => ROMtoREG ,--ROM to REGSGEN i = 0
		75  => "00000000",--Regsgen(0) 
		76  => "00000000",--0 contador
		77  => ROMtoREG ,--ROM to REGSGEN j = 0
		78  => "00000000",--Regsgen(0) 
		79  => "00000000",--0 contador
		80  => ROMtoREG ,--ROM to REGSGEN t = 50
		81  => "00000101",--Regsgen(5)=t 
		82  => "00000101",--5
		83  => ROMtoREG ,--ROM to REGSGEN ischar = false
		84  => "00001011",--Regsgen(11)=ischar 
		85  => "00000000",--false
		--Compienza ciclo interno
		86  => ALUADD,-- i + 50
		87 => "00000101",--
		88 => SaveMBR,--i = i +50
		89 => "00000000",--
		90  => ALUADD,-- j + 1
		91 => "00010100",--
		92 => SaveMBR,--i = j +1
		93 => "00000001",--
		94 => ALUSUB,--
		95 => "00010010",--false 
		96 => BRANCH,--false
		97 => "00001001",--false
		98 => "01010110",--false
		99  => ROMtoREG ,--ROM to REGSGEN ischar = true
		100  => "00001011",--Regsgen(11)=ischar 
		101  => "00000001",--true
		102  => ROMtoREG ,--ROM to REGSGEN j=0
		103  => "00000001",--
		104  => "00000000",--
		105 => jump,
		106 => "00101100",  
		others => ("11111111")
	);  
constant ROM_Var :miniROM :=
	(
		0 => "0000000000000100",--W
		1 => "0000000000000010",--X
		2 => "0000000000000100",--Y
		3 => "0000000000001000",--Z	
		others => "0000000000000000" 
	); 
signal RAM : MemArr :=(others => "00000000"); 
-- Variable para controlar si el mux esta en numeros o chars
signal RegsGen: miniROM:=(others => "0000000000000000"); 
------------------------------------Registros de proposito especifico
signal PC : integer;  
signal MAR : std_logic_vector(7 downto 0):="00000000";
signal IR : std_logic_vector(7 downto 0):="00000000"; 
signal muxALU : std_logic_vector(3 downto 0) := "0000";
signal MBR, ACC : std_logic_vector(15 downto 0):="0000000000000000"; 
----------------------------------------Registros de entrada a la ALU
signal REGA : std_logic_vector(15 downto 0); 
signal REGB : std_logic_vector(15 downto 0);
signal charoutput: std_logic_vector(19 downto 0);
-----------------------------------------------------Senales de reloj 
signal sigOSC, muxClk, cuCLK: std_logic;
CONSTANT VEL: string := "2.08";-----------------Velocidad a modificar
attribute NOM_FREQ: string; 
attribute NOM_FREQ of oschins : label is VEL; 
--------------------------------------------------Inicio del programa 
 begin
 pcview<=std_logic_vector(to_unsigned(Pc,8));
 charoutput <=RegsGen(15)(4 downto 0)& 
	RegsGen(14)(4 downto 0)&
	RegsGen(13)(4 downto 0)&
	RegsGen(12)(4 downto 0);
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
 
  
 
aluIns: ALU port map(rega,regb,muxalu(3 downto 0),flagReg,acc); 
oschIns: OSCH generic map(VEL) port map('0', sigOSC);  
divInstanceIR: divFreq generic map(200) port map(sigOSC,muxCLK);
divmuxCU: divFreq  generic map(50000) port map(sigOSC,cuCLK); 
dispM: dispMux port map (muxCLK,regsgen(0)(9),RegsGen(11)(0),RegsGen(0)(9 downto 0),charoutput,dmux,disp);      
end architecture;       