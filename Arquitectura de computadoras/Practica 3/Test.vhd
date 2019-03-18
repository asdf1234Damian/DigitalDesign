library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testBench is 
	port(
	Start : in std_logic;
	disp : out std_logic_vector(6 downto 0);
	dmux : inout  std_logic_vector(3 downto 0);
	FlagReg: inout std_logic_vector(3 downto 0);
	sel : inout std_logic_vector(1 downto 0)
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

component dispMUx is 
	port(
	clk, neg: in std_logic; 
	bin : in std_logic_vector(9 downto 0);
	mux : inout std_logic_vector(3 downto 0);
	disp : out std_logic_vector(6 downto 0)
	);
end component;
------------------------------------------------------------------ROM
constant addrssA : integer:=0;
constant addrssB : integer:=34;
constant addrssC : integer:=72;
constant addrssD : integer:=106;
type ROM is array (109 downto 0) of std_logic_vector(7 downto 0);
type miniROM is array (4 downto 0) of std_logic_vector(15 downto 0);

constant ROM_Program: ROM :=
	(
		------Comienza funcion 1----------------------
		0 => "00001011",-- Carga
		1 => "00000000",-- en A
		2 => "00010001",-- 17
		3 => "00001100",-- Mover de variable a general
		4 => "00010001",-- B:=X   (2)
		5 => "00001001",-- Multiplicar
		6 => "00000001",-- A a por B (17 x 2)
		7 => "00001110",-- Guardar MBR en
		8 => "00100000",-- C (34)
		9 => "00001011",-- Carga
		10 => "00000000",-- en A
		11 => "00011001",-- 25
		12 => "00001100",-- Mover de variable a general
		13 => "00010010",-- B:=Y   (4)
		14 => "00001001",-- Multiplicar
		15 => "00000001",-- A a por B (25 * 4)
		16 => "00001110",-- Guardar MBR en
		17 => "00110000",-- D (100)
		18 => "00001100",-- Mover de variable a general
		19 => "00000000",-- A := W (4)
		20 => "00001011",-- Cargar
		21 => "00010000",-- en B
		22 => "00000100",-- 4   
		23 => "00001010",-- Dividr 
		24 => "00000001",-- A entre B (4/4)
		25 => "00001110",-- Guardar MBR en
		26 => "00000000",-- A:=W/4 (1)
		27 => "00000111",-- Sumar 
		28 => "00100011",-- C con D (13X + 23Y)
		29 => "00001110",-- Guardar MBR
		30 => "00010000",-- B:=(13X + 23Y)
		31 => "00001000",-- Restar  
		32 => "00010000",-- B menos A
		------Termina funcion 1 ----------------------
		33 => "11111111",-- HALT
		------Comienza funcion 2----------------------
		34 => "00001011",-- Carga
		35 => "00000000",-- en A
		36 => "00001010",-- A:=10
		37 => "00001100",-- Cargar variable 
		38 => "00010001",-- B:=X
		39 => "00000111",-- Multiplicar 
		40 => "00010001",-- B * B
		41 => "00001110",-- Guardar MBR
		42 => "00010000",-- B := X^2 
		43 => "00001001",-- Multiplicar 
		44 => "00000001",-- A * B
		45 => "00001110",-- Guardar MBR
		46 => "00100000",-- C := 10x^2
		47 => "00001011",-- Cargar
		48 => "00000000",-- en A
		49 => "00011110",-- A:=30 
		50 => "00001100",-- Cargar variable
		51 => "00010001",-- B:=X
		52 => "00001001",-- Multiplicar A a por B
		53 => "00000001",-- A*B
		54 => "00001110",-- Guardar MBR
		55 => "00110000",-- D:=30x
		56 => "00001100",-- Mover variable 
		57 => "00000011",-- A:=Z
		58 => "00001011",-- Cargar
		59 => "00010000",-- en B
		60 => "00000010",-- 2
		61 => "00001010",-- Dividr 
		62 => "00000001",-- A entre B
		63 => "00001110",-- Guardar MBR
		64 => "00000000",-- A:=Z/2
		65 => "00000111",--Sumar 
		66 => "00100011",-- C con D (13X + 23Y)
		67 => "00001110",-- Guardar MBR 
		68 => "00010000",-- B:=(5X^2 + 30x)
		69 => "00001000",-- Restar 
		70 => "00010000",-- B menos A
		-- ------Termina funcion 2 ----------------------
		71 => "11111111",-- HALT
		-- ------Comienza funcion 3----------------------
		72 => "00001100",-- Mov variable
		73 => "00000000",-- A:=W
		74 => "00001011",-- Cargar
		75 => "00010000",-- en B
		76 => "00001010",-- Dato 10
		77 => "00001010",-- Dividir
		78 => "00000001",-- A entre B
		79 => "00001110",-- Guardar MBR
		80 => "00000000",-- A:=W/10
		81 => "00001011",-- Cargar
		82 => "00010000",-- en reg B
		83 => "00000111",-- Dato 7
		84 => "00001100",-- Cargar var 
		85 => "00100011",-- C:=Z
		86 => "00001001",-- Multiplcar
		87 => "00100001",-- C x B
		88 => "00001110",-- Guardar MBR 
		89 => "00010000",-- B := 7z
		90 => "00001100",-- Cargar var 
		91 => "00100001",-- C:=x
		92 => "00001001",-- Multiplcar
		93 => "00100010",-- C x C
		94 => "00001110",-- Guardar MBR 
		95 => "00110000",-- C := x^2
		96 => "00001001",-- Multiplcar
		97 => "00110010",-- C x C
		98 => "00001110",-- Guardar MBR 
		99 => "00100000",-- C := x^3
		100=> "00000111",-- Sumar 
		101=> "00010010",-- b + c
		102=> "00001110",-- Guardar MBR 
		103=> "00010000",-- B := x^3 + 7z
		104=> "00001000",-- Restar
		105=> "00000001",-- A - B
		------Termina funcion 3 ----------------------
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
signal RegsGen: miniROM;
--signal FlagReg: std_logic_vector(3 downto 0);
------------------------------------Registros de proposito especifico
signal PC : integer; 
signal MAR : std_logic_vector(7 downto 0):="00000000";
signal IR : std_logic_vector(7 downto 0):="00000000"; 
signal MBR, ACC : std_logic_vector(15 downto 0):="0000000000000000"; 
----------------------------------------Registros de entrada a la ALU
signal REGA : std_logic_vector(15 downto 0); 
signal REGB : std_logic_vector(15 downto 0);
-----------------------------------------------------Senales de reloj 
signal sigOSC, muxClk, cuCLK: std_logic;
CONSTANT VEL: string := "2.08";-----------------Velocidad a modificar
attribute NOM_FREQ: string; 
attribute NOM_FREQ of oschins : label is VEL; 
--------------------------------------------------Inicio del programa 
 begin
ControlUnit: process(Start, IR)  
	variable state:integer range 0 to 3 :=0; 
begin  
	if (Start = '0') then  
		state := 0 ;
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
		if(state = 0)	then 
			IR <= ROM_program(PC); 
			MAR <= ROM_program(PC+1); 
			state:=1;
	--Decode---------------------------------------------------------  
		elsif (state = 1 ) then  
			if (IR = "00001011") then -- Cargar dato de ROM_prog a RegsGen
				RegsGen(to_integer(unsigned(MAR(7 downto 4)))) <= "00000000"&ROM_program(PC+2);
				pc <= pc+3;
				state := 0; 
			elsif (IR = "00001100") then  -- Cargar dato de ROM_Var a RegsGen
				RegsGen(to_integer(unsigned(MAR(7 downto 4)))) <= ROM_Var(to_integer(unsigned(MAR(3 downto 0))));
				state := 0;
				pc <= pc+2; 
			elsif (IR = "00001101") then -- Copiar reg(orig) a reg(dest)
				RegsGen(to_integer(unsigned(MAR(7 downto 4))))<= RegsGen(to_integer(unsigned(MAR(3 downto 0)))) ;
				state := 0;
				pc <= pc+2;
			elsif (IR = "00001110") then -- Copiar MBR a reg(dest)
				RegsGen(to_integer(unsigned(MAR(7 downto 4))))<= MBR;
				state := 0;
				pc <= pc+2; 
			elsif( IR = "00010000") then  --jmp
				if((MAR(3 downto 0) xor flagReg)="0000") then 
					pc <= to_integer(unsigned(MAR(7 downto 4)));
					state := 0;
				else 
					pc <= pc+3; 
					state := 0;
				end if;
			else
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
 
  
 
aluIns: ALU port map(rega,regb,ir(3 downto 0),flagReg,acc); 
oschIns: OSCH generic map(VEL) port map('0', sigOSC); 
divInstanceIR: divFreq generic map(20) port map(sigOSC,muxCLK);
divmuxCU: divFreq  generic map(200000) port map(sigOSC,cuCLK); 
dispM: dispMux port map (muxCLK,MBR(9),MBR(9 downto 0),dmux,disp);      
end architecture;      