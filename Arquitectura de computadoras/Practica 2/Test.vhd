library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testBench is 
	port(
	Start : in std_logic;
	disp : out std_logic_vector(6 downto 0);
	digIR : out std_logic_vector(3 downto 0);
	digPC: out std_logic_vector(9 downto 0);	digDisp: out std_logic_vector(9 downto 0);
	dmux : inout  std_logic_vector(3 downto 0);
	sel : inout std_logic_vector(1 downto 0)
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
constant addrssB : integer:=0;
constant addrssC : integer:=0;
constant addrssD : integer:=0;
type ROM is array (99 downto 0) of std_logic_vector(7 downto 0);
type miniROM is array (4 downto 0) of std_logic_vector(9 downto 0);
attribute syn_romstyle : string;

constant ROM_Program: ROM :=
	(															
		0 => "00001011",--Carga a A
		1 => "00001101",--A:=13
		2 => "01011100",--B:=X
		3 => "00011001",--Multiplicar A a por B
		4 => "10001110",--C := 13X
		5 => "00001011",--Cargar a A
		6 => "00010111",--A:=23 
		7 => "01101100",--B:= Y
		8 => "00011001",--Multiplicar A a por B
		9 => "11001110",--D:=23Y
		10=> "00001100",--Mover variable W a A
		11=> "01001011",--Cargar a B
		12=> "00000100",--4
		13=> "00011010",--Dividr A entre B
		14=> "00001110",--A:=W/4
		15=> "10110111",--Sumar C con D (13X + 23Y)
		16=> "01001110",--B:=(13X + 23Y)
		17=> "01001100",--Restar B menos A
		others => ("00001111")
	);
constant ROM_Var :miniROM :=
	(
		0 => "0000000001",--W
		1 => "0000000010",--X
		2 => "0000000100",--Y
		3 => "0000001000",--Z	
		others => "0000000000"
	); 
signal RegsGen: miniROM;
------------------------------------Registros de proposito especifico
signal PC : integer := 0; 
signal MAR : std_logic_vector(3 downto 0):="0000";signal IR : std_logic_vector(3 downto 0):="0000"; 
signal MBR, ACC : std_logic_vector(9 downto 0):="0000000000"; 
----------------------------------------Registros de entrada a la ALU
signal REGA : std_logic_vector(7 downto 0):="00000000";
signal REGB : std_logic_vector(7 downto 0):="00000000";
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
		IR <= "0000";
		RegA <= (others =>'0');
		RegB <= (others =>'0');
		MBR <= "0000000000";
		RegsGen<=(others => "0000000000");
		case sel is  
			when "00" => PC <= addrssA;
			when "01" => PC <= 1;
			when "10" => PC <= 2; 
			when others => PC <= 0;
		end case;
	elsif (cuCLK'event and cuCLK = '1' and IR /="1111")then 
	--Fetch------------------------------------------------------
		if(state = 0)	then 
			MAR <= ROM_program(PC)(7 downto 4); 
			IR <= ROM_program(PC)(3 downto 0); 
			state:=1;
	--Decode---------------------------------------------------------  
		elsif (state = 1 ) then  
			if (IR = "1011") then -- Cargar dato de ROM_prog a RegsGen
				RegsGen(to_integer(unsigned(MAR(3 downto 2)))) <= "00"&ROM_program(PC+1);
				pc <= pc+2;
				state := 0;
			elsif (IR = "1100") then  -- Cargar dato de ROM_Var a RegsGen
				RegsGen(to_integer(unsigned(MAR(3 downto 2)))) <= ROM_Var(to_integer(unsigned(MAR(1 downto 0))));
				state := 0;
				pc <= pc+1;
			elsif (IR = "1101") then -- Copiar reg(orig) a reg(dest)
				RegsGen(to_integer(unsigned(MAR(3 downto 2))))<= RegsGen(to_integer(unsigned(MAR(1 downto 0)))) ;
				state := 0;
				pc <= pc+1;
			elsif (IR = "1110") then -- Copiar MBR a reg(dest)
				RegsGen(to_integer(unsigned(MAR(3 downto 2))))<= MBR;
				state := 0;
				pc <= pc+1;
			else
				RegA <= RegsGen(to_integer(unsigned(MAR(3 downto 2))))(7 downto 0);
				RegB <= RegsGen(to_integer(unsigned(MAR(1 downto 0))))(7 downto 0);
				state:=2;
			end if; 
			
	--Execute--------------------------------------------------------	
		else
			MBR <= ACC;
			state := 0;    
			PC <= PC + 1;
		end if; 
	-- Change state and PC if necessary ----------------------------  
	end if; 
digDisp <= MBR;
digIR <= IR;
digPC<= std_logic_vector(to_unsigned(PC,10));
end process;

regALU : process(IR, RegA, RegB)
variable shifter : std_logic_vector(9 downto 0);
variable remaining :  integer;
variable coc, res, div : unsigned(4 downto 0 ); -- unsigned para que tengan valor numerico
begin
	if (Ir = "0101" or IR = "0110") then 
		shifter := "00"&RegA;
		remaining := to_integer(signed(RegB));
		for i in 0 to (10) loop
			if (remaining > 0)then 
				if(IR = "0101") then 
					shifter:= shifter(8 downto 0) & "0";
				else 
					shifter:= shifter(9) & shifter(9 downto 1);
				end if;
				remaining := remaining - 1;  
			end if; 			
		end loop; 
		acc <= shifter;
	elsif (IR= "1010")  then 
		if regb(4 downto 0) /= "00000" then -- valida division entre cero
			if regb(4 downto 0) ="00001" then -- si se divide entre uno, se pasa directo
				acc <= "00000"&rega(6 downto 2);
			else-- si se divide entre dos acc mas
				coc := "00000";--inicializa en 0
				res := unsigned(rega(6 downto 2));-- se inicializa el  res a A
				div := unsigned(regb(4 downto 0));-- se inicializa divisor a B
				for i in 0 to 128 loop -- peor caso 255/2 (optimizado del paso pasado)
					if (res >= div) then-- mientras el residuo sea mayor acc igual al divisor 
						coc := coc+ 1;
						res := res - div;-- se hace la resta
					end if;
				end loop;	
				acc <= "00000"&std_logic_vector(coc);-- se convierten en stdlogic
			end if;
		end if; 
	else		
		case IR is
			when "0001" => acc <= "00"&not rega;
			when "0011" => acc <= "00"&(not rega) + 1;
			when "0010" => acc <= "00"&rega and "00"&regb; 
			when "0100" => acc <= "00"&rega or "00"&regb;
			when "0111" => acc <= ("00"&rega)+("00"&regb);
			when "1000" => acc <= "00"&(rega - regb); 
			when "1001" => acc <= rega(4 downto 0) * regb(4 downto 0); 
			when others => acc <= "00"&rega;   
		end case; 
	end if;  
end process;  		 
oschIns: OSCH generic map(VEL) port map('0', sigOSC); 
divInsIR: divFreq generic map(20) port map(sigOSC,muxCLK);
--divmuxCU: divFreq  generic map(2000000) port map(sigOSC,cuCLK);
divmuxCU: divFreq  generic map(200000) port map(sigOSC,cuCLK);
dispM: dispMux port map (muxCLK,'0',MBR,dmux,disp);      
end architecture;      