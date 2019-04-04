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
----------------------------------------------------------------OPCODES
--Complemento a 1, not
constant ALUComp1: std_logic_vector(7 downto 0) := "00000001";
--Operacion and
constant ALUandOP: std_logic_vector(7 downto 0) := "00000010";
--Complemento a 1, not + 1
constant ALUComp2: std_logic_vector(7 downto 0) := "00000011";
--Operacion or
constant ALUorOP_: std_logic_vector(7 downto 0) := "00000100";
--Logic Shift Left
constant ALU_LSL_: std_logic_vector(7 downto 0) := "00000101";
--Arith Shift Right
constant ALU_ASR_: std_logic_vector(7 downto 0) := "00000110";
--Add two numbers
constant ALU__ADD: std_logic_vector(7 downto 0) := "00000111";
--Substract
constant ALU__SUB: std_logic_vector(7 downto 0) := "00001000";
--Multiplication
constant PROD____: std_logic_vector(7 downto 0) := "00001001";
--Division
constant DIV_____: std_logic_vector(7 downto 0) := "00001010";
--Move data grom ROM to REG
constant ROMtoREG: std_logic_vector(7 downto 0) := "00001011";
--Move form constant to reg
constant CPCNSREG: std_logic_vector(7 downto 0) := "00001100";
--Copy from reg orig to reg Dest
constant CP_Or_De: std_logic_vector(7 downto 0) := "00001101";
--Save MBR to REG
constant SaveMBR : std_logic_vector(7 downto 0) := "00001110";
--jmp
constant JUMP____: std_logic_vector(7 downto 0) := "00001111";
--Branch
constant Branch__: std_logic_vector(7 downto 0) := "00010000";
-- TODO branches  and flags and ram functopn
--Write MBR in RAM
constant writeRAM: std_logic_vector(7 downto 0) := "00010001";
--Move from ram to reg
constant read_RAM: std_logic_vector(7 downto 0) := "00010010";
--HALT
constant HALT____: std_logic_vector(7 downto 0) := "11111111";
constant

constant ROM_Program: ROM :=
	(
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
------------------------------------Registros de proposito especifico
signal PC : integer;
signal MAR : std_logic_vector(7 downto 0):="00000000";
signal IR : std_logic_vector(7 downto 0):="00000000";
signal MBR, ACC : std_logic_vector(15 downto 0):="0000000000000000";
----------------------------------------Registros de entrada a la ALU
signal ALUA : std_logic_vector(15 downto 0);
signal ALUB : std_logic_vector(15 downto 0);
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
		ALUA <= (others =>'0');
		ALUB <= (others =>'0');
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
			elsif (IR = "00001111") then -- JUMp
				pc <= to_integer(unsigned(MAR(7 downto 4)));
				state := 0;
			elsif( IR = "00010000") then  --brnc
				if((MAR(3 downto 0) xor flagReg)="0000") then
					pc <= to_integer(unsigned(MAR(7 downto 4)));
					state := 0;
				else
					pc <= pc+3;
					state := 0;
				end if;
			else
				ALUA <= RegsGen(to_integer(unsigned(MAR(7 downto 4))));
				ALUB <= RegsGen(to_integer(unsigned(MAR(3 downto 0))));
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



aluIns: ALU port map(ALUA,ALUB,ir(3 downto 0),flagReg,acc);
oschIns: OSCH generic map(VEL) port map('0', sigOSC);
divInstanceIR: divFreq generic map(20) port map(sigOSC,muxCLK);
divmuxCU: divFreq  generic map(200000) port map(sigOSC,cuCLK);
dispM: dispMux port map (muxCLK,MBR(9),MBR(9 downto 0),dmux,disp);
end architecture;
