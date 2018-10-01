library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity contadorBCD is 
	port(
		clk_0: inout std_logic;
		load, reset, arriba: in std_logic;
		data: in std_logic_vector(7 downto 0);
		mux:inout std_logic_vector(3 downto 0 );
		dispA: inout std_logic_vector(6 downto 0);
		off_LED: out std_logic_vector(2 downto 0);
		blink_LED: out std_logic
	);
end contadorBCD;

architecture test_osc of contadorBCD is	Constant Dig0: std_logic_vector(6 downto 0):="1111110";
	Constant Dig1: std_logic_vector(6 downto 0):="0110000";
	Constant Dig2: std_logic_vector(6 downto 0):="1101101";
	Constant Dig3: std_logic_vector(6 downto 0):="1111001";
	Constant Dig4: std_logic_vector(6 downto 0):="0110011";
	Constant Dig5: std_logic_vector(6 downto 0):="1011011";
	Constant Dig6: std_logic_vector(6 downto 0):="1011111";
	Constant Dig7: std_logic_vector(6 downto 0):="1110000";
	Constant Dig8: std_logic_vector(6 downto 0):="1111111";
	Constant Dig9: std_logic_vector(6 downto 0):="1110011";
	Constant Apag: std_logic_vector(6 downto 0):="0000000";
	Constant HexA: std_logic_vector(6 downto 0):="1110111";
	Constant HexB: std_logic_vector(6 downto 0):="0011111";
	Constant HexC: std_logic_vector(6 downto 0):="0001101";
	Constant HexD: std_logic_vector(6 downto 0):="0111101";
	Constant HexE: std_logic_vector(6 downto 0):="1001111";
	Constant HexF: std_logic_vector(6 downto 0):="1000111";	
	
	COMPONENT  OSCH
		GENERIC (NOM_FREQ: string);
		PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;
	 
	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "26.60";
	
	
	signal clk_low: std_logic:= '0'; 
	signal s_count: std_logic_vector(3 downto 0 ); 
	signal d_count: std_logic_vector(3 downto 0 ); 
begin 
	OSCInst0 : OSCH GENERIC  MAP("26.60") PORT MAP('0', clk_0);
	off_LED <= "000";
	mux <= "0001";
contaBCD: process(clk_low,reset)begin 
	if reset='1' then 
		s_count <="0000";
		d_count <="0000";		
	elsif (clk_low'event and clk_low='1') then
		case mux is 
			when "0001" => mux <="0010";
			when "0010" => mux <="0100";
			when "0100" => mux <="1000";
			when others => mux <="0001";
		end case; 
		if load='1' then 
			s_count <= data(3 downto 0);
			d_count <= data(7 downto 4);
		elsif arriba='1' then 
			if s_count= "1111" then 
				s_count<="0000";
				if d_count="1111" then 
					d_count<= "0000" ;
				else
					d_count<= d_count+1;
				end if;
			else
				s_count <=s_count+1;
			end if;  
		else
			if s_count ="0000" then
				s_count<="1111";
				if d_count="0000" then 
					d_count<= "1111" ;
				else
					d_count<= d_count-1;
				end if;
			else
				s_count <=s_count-1;
			end if; 
		end if; 
	end if ;
end process;

P_blink_LED: PROCESS(clk_0)
	VARIABLE count: INTEGER RANGE 0 to 25000000;
	BEGIN 
		IF (clk_0'EVENT AND clk_0='1' )THEN 
			IF(count < 24000000) THEN  
				count := count+1; 
			ELSE
				count :=0; 
				clk_low <= NOT clk_low;
			END IF;
		END IF; 
	END PROCESS; 	blink_LED<= clk_low;
	
decoder: process(s_count)
variable disp1, disp2, disp3, disp4 :std_logic_vector(6 downto 0);
	begin 
	disp3 := Dig0;
	disp4 := Dig0;
	case(s_count) is
        when "0000" => disp1 := Dig0;
        when "0001" => disp1 := Dig1;
        when "0010" => disp1 := Dig2;
        when "0011" => disp1 := Dig3;
        when "0100" => disp1 := Dig4;
        when "0101" => disp1 := Dig5;
        when "0110" => disp1 := Dig6;
        when "0111" => disp1 := Dig7;
        when "1000" => disp1 := Dig8;
        when "1001" => disp1 := Dig9;
        when "1010" => disp1 := HexA;
        when "1011" => disp1 := HexB;
        when "1100" => disp1 := HexC;
        when "1101" => disp1 := HexD;
        when "1110" => disp1 := HexE;
        when "1111" => disp1 := HexF;
        when others => disp1 := Apag;
      end case; 
	  
	  case(d_count) is
        when "0000" => disp2 := Dig0;
        when "0001" => disp2 := Dig1;
        when "0010" => disp2 := Dig2; 
        when "0011" => disp2 := Dig3;
        when "0100" => disp2 := Dig4;
        when "0101" => disp2 := Dig5;
        when "0110" => disp2 := Dig6;
        when "0111" => disp2 := Dig7;
        when "1000" => disp2 := Dig8;
        when "1001" => disp2 := Dig9;
        when "1010" => disp2 := HexA;
        when "1011" => disp2 := HexB;
        when "1100" => disp2 := HexC;
        when "1101" => disp2 := HexD;
        when "1110" => disp2 := HexE;
        when "1111" => disp2 := HexF;
        when others => disp2 := Apag;
      end case;
	  
	  case (mux) is 
		  when "0001" => dispA <= disp1;
		  when "0010" => dispA <= disp2;
		  when "0100" => dispA <= disp3;
		  when others => dispA <= disp4;
	  end case;
	  
	end process;end test_osc; 


	