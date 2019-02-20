library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testBench is 
	port(
	Start : in std_logic;
	a , b: in std_logic_vector(9 downto 0);
	mux : in std_logic_vector(1 downto 0);
	disp : out std_logic_vector(6 downto 0);
	dmux : inout std_logic_vector(3 downto 0)
	);
end entity;

architecture behavioral of testbench is
component OSCH
	generic(NOM_FREQ: string);
	port(
	STDBY: in std_logic;
	OSC: out std_logic
	); 
end component;

component ALU is 
port(
	a, b: in std_logic_vector(9 downto 0);
	mux : in std_logic_vector(3 downto 0);
	c : out std_logic;
	o : inout std_logic_vector(9 downto 0)
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
	clk, neg: in std_logic;
	bin : in std_logic_vector(9 downto 0);
	mux : inout std_logic_vector(3 downto 0);
	disp : out std_logic_vector(6 downto 0)
	);
end component;
------------------------------------------------------------------ROM
constant addrssA,addrssB,addrssC,addrssD: integer := 0 ;
type ROM is array (99 downto 0) of std_logic_vector(5 downto 0);
type miniROM is array (4 downto 0) of std_logic_vector(9 downto 0);
constant ROM_Program: ROM :=
	(
		1 => "000000",
		2 => "100001",
		others => (others => '1')
	);
constant ROM_Var :miniROM :=
	(
		1 => "0000000001",
		2 => "0000000010",
		3 => "0000000100",
		4 => "0000001000",
		others => "0000000000"
	);
	
signal RegGen: miniROM:=(others => "0000000000");
------------------------------------Registros de proposito especifico
signal PC : integer :=0;
signal MAR : std_logic_vector(1 downto 0);
signal IR : std_logic_vector(3 downto 0);
signal MBR, ACC : std_logic_vector(9 downto 0); 
------------------------------------Registros de proposito especifico
signal REGA, REGB, REGC, REGD : std_logic_vector(7 downto 0);
-----------------------------------------------------Senales de reloj 
signal sigOSC, muxClk, cuCLK: std_logic;
CONSTANT VEL: string := "2.08";-----------------Velocidad a modificar
attribute NOM_FREQ: string; 
attribute NOM_FREQ of oschIns : label is VEL; 
-------------------------------------Banderas que no estamos usando:c
signal sigCarry : std_logic; 
--------------------------------------------------Inicio del programa 
begin
ControlUnit: process(Start, mux)  
variable state:integer range 0 to 2 :=0; 
begin  
if (IR /= "1111" and cuCLK'event and cuCLK = '1')then 
	if (Start = '0' or mux'event) then  
		case mux is  
			when "00" => PC <= addrssA;
			when "01" => PC <= addrssB;
			when "10" => PC <= addrssC;
			when others => PC <= addrssD;
		end case;
	else
	--Fetch------------------------------------------------------
		if(state = 0)	then 
			MAR <= ROM_program(PC)(5 downto 4); 
			IR <= ROM_program(PC)(3 downto 0);
	--Decode---------------------------------------------------------  
		elsif (state = 1 ) then 
			if (IR = "1011") then 
				MBR <= ROM_Var(to_integer(unsigned(MAR)));
			elsif (IR = "1100") then
				RegGen(to_integer(unsigned(MAR)))<= MBR ;
			else
				MBR <= ACC;
			end if; 
	--Execute--------------------------------------------------------	
		else
			RegGen(to_integer(unsigned(MAR)))<= MBR ;
		end if;
	-- Change state and PC if necessary ---------------------------- 
		if (state = 2) then 
			state := 0;   
			PC <= PC + 1;
		else 
			state := state + 1;
		end if;
	end if; 
end if; 
end process; 
oschIns: OSCH generic map(VEL) port map('0', sigOSC); 
aluIns: ALU port map(RegGen(0),RegGen(1),IR,sigCarry,ACC);
divInsMux: divFreq generic map(20) port map(sigOSC,muxCLK);
divInsCU: divFreq  generic map(200) port map(sigOSC,cuCLK);   dispIns: dispMux port map (muxCLK,sigCarry,MBR,dmux,disp);     
end architecture;      