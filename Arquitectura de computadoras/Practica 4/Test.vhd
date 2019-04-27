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
constant addrssA : integer:=20;
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
constant writeRAM: std_logic_vector(7 downto 0) := "00010001";
--Move from ram to reg
constant read_RAM: std_logic_vector(7 downto 0) := "00010010";
--HALT
constant HALT: std_logic_vector(7 downto 0) := "11111111";
type ROM is array (100 downto 0) of std_logic_vector(7 downto 0);
type miniROM is array (9 downto 0) of std_logic_vector(15 downto 0);
constant ROM_Program: ROM :=
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
		20  => ROMtoREG,--ROM to REGSGEN
		21  => "00000000",--Regsgen(0)
		22  => "00000000",--0 contador
		23  => ROMtoREG,--ROM to REGSGEN
		24  => "00001001",--regsgen9
		25  => "00000001",--0
		26  => ROMtoREG,--
		27  => "00000001",--
		28  => ROMtoREG,--
		29  => ROMtoREG,--
		30  => ROMtoREG,--
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
-- Variable para controlar si el mux esta en numeros o chars
signal RegsGen: miniROM:=(others => "0000000000000000"); 
------------------------------------Registros de proposito especifico
signal PC : integer;  
signal MAR : std_logic_vector(7 downto 0):="00000000";
signal IR : std_logic_vector(7 downto 0):="00000000"; 
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
 charoutput <=RegsGen(1)(4 downto 0)&
	RegsGen(2)(4 downto 0)&
	RegsGen(3)(4 downto 0)&
	RegsGen(4)(4 downto 0);
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
dispM: dispMux port map (muxCLK,MBR(9),RegsGen(9)(0),MBR(9 downto 0),charoutput,dmux,disp);      
end architecture;       