library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity contadorBCD is 
	port(
		clk_0: inout std_logic;
		load, reset, arriba: in std_logic;
		data: in std_logic_vector(15 downto 0);
		mux: inout std_logic_vector(3 downto 0 );
		disp: out std_logic_vector(6 downto 0);
		blink_LED: out std_logic
	);
end contadorBCD;

architecture test_osc of contadorBCD is	
------------------------------------------------------------------------------
	Constant Dig0: std_logic_vector(6 downto 0):="1111110";
	Constant Dig1: std_logic_vector(6 downto 0):="0110000";
	Constant Dig2: std_logic_vector(6 downto 0):="1101101";
	Constant Dig3: std_logic_vector(6 downto 0):="1111001";
	Constant Dig4: std_logic_vector(6 downto 0):="0110011";
	Constant Dig5: std_logic_vector(6 downto 0):="1011011";
	Constant Dig6: std_logic_vector(6 downto 0):="1011111";
	Constant Dig7: std_logic_vector(6 downto 0):="1110000";
	Constant Dig8: std_logic_vector(6 downto 0):="1111111";
	Constant Dig9: std_logic_vector(6 downto 0):="1111011";
	Constant Apag: std_logic_vector(6 downto 0):="0000000";
	COMPONENT  OSCH
			GENERIC (NOM_FREQ: string);
			PORT(STDBY: in std_logic; OSC: out std_logic);
	END COMPONENT;
	attribute NOM_FREQ: string ;
	attribute NOM_FREQ of OSCinst0 : label is "2.08";
	signal clk_low: std_logic:= '0';  
	signal s_count: std_logic_vector(3 downto 0 ); 
	signal d_count: std_logic_vector(3 downto 0 ); 
	signal c_count: std_logic_vector(3 downto 0 ); 
	signal m_count: std_logic_vector(3 downto 0 ); 
	signal disp1,disp2,disp3,disp4: std_logic_vector(6 downto 0);
	signal m: std_logic_vector(7 downto 0):="00000001";
------------------------------------------------------------------------------
begin
	OSCInst0 : OSCH GENERIC  MAP("2.08") PORT MAP('0', clk_0);
------------------------------------------------------------------------------
	lowClk: process(clk_0)  
		VARIABLE count: INTEGER RANGE 0 to 500000;
	begin
		IF (clk_0'EVENT AND clk_0='1' )THEN
			m<=m(6 downto 0)&m(7); 	
			IF(count < 500000) THEN  				
				count := count+1; 
			ELSE
				count :=0; 
				clk_low <= NOT clk_low;
			END IF;
		END IF; 
		blink_LED<= clk_low;
	end process; 
------------------------------------------------------------------------------

	contaBCD: process(clk_low,reset,load,arriba)begin 
		if reset='1' then 
			s_count <="0000";
			d_count <="0000";		
			c_count <="0000";
			m_count <="0000";		
		elsif (clk_low'event and clk_low='1') then
			if load='1' then 
				s_count <= data(3 downto 0);
				d_count <= data(7 downto 4);
				c_count <= data(11 downto 8);
				m_count <= data(15 downto 12);
			elsif arriba='0' then 
				if s_count= "1001" then 
					s_count<="0000";
					if d_count="1001" then 
						d_count<= "0000" ;
						if c_count="1001" then 
							c_count<="0000";
							if m_count="1001" then 
								m_count<="0000";
							else
								m_count<=m_count+1;
							end if;
						else
							c_count<=c_count+1;
						end if;
					else
						d_count<= d_count+1;
					end if;
				else
					s_count <=s_count+1;
				end if;  
			else
				if s_count= "0000" then 
					s_count<="1001";
					if d_count="0000" then 
						d_count<= "1001" ;
						if c_count="0000" then 
							c_count<="1001";
							if m_count="0000" then 
								m_count<="1001";
							else
								m_count<=m_count-1;
							end if;
						else
							c_count<=c_count-1;
						end if;
					else
						d_count<= d_count-1;
					end if;
				else
					s_count <=s_count-1;
				end if;
			end if;	
		end if;
	end process;

	decoUno: process(s_count)
	begin 
		case s_count is 
		when "0000" => disp1 <= dig0;
		when "0001" => disp1 <= dig1;
		when "0010" => disp1 <= dig2;
		when "0011" => disp1 <= dig3;
		when "0100" => disp1 <= dig4;
		when "0101" => disp1 <= dig5;
		when "0110" => disp1 <= dig6;
		when "0111" => disp1 <= dig7;
		when "1000" => disp1 <= dig8;
		when others => disp1 <= dig9;
		end case;
	end process;

	decoDiez:process(d_count)
	begin 
		case d_count is 
		when "0000" => disp2 <= dig0;
		when "0001" => disp2 <= dig1;
		when "0010" => disp2 <= dig2;
		when "0011" => disp2 <= dig3;
		when "0100" => disp2 <= dig4;
		when "0101" => disp2 <= dig5;
		when "0110" => disp2 <= dig6;
		when "0111" => disp2 <= dig7;
		when "1000" => disp2 <= dig8;
		when others => disp2 <= dig9;
		end case;
	end process;

	decoCien:process(c_count)
	begin
		case c_count is 
		when "0000" => disp3 <= dig0;
		when "0001" => disp3 <= dig1;
		when "0010" => disp3 <= dig2;
		when "0011" => disp3 <= dig3;
		when "0100" => disp3 <= dig4;
		when "0101" => disp3 <= dig5;
		when "0110" => disp3 <= dig6;
		when "0111" => disp3 <= dig7;
		when "1000" => disp3 <= dig8;
		when others => disp3 <= dig9;
		end case;
	end process; 

	decoMil:process(m_count)
	begin 
		case m_count is 
		when "0000" => disp4 <= dig0;
		when "0001" => disp4 <= dig1;
		when "0010" => disp4 <= dig2;
		when "0011" => disp4 <= dig3;
		when "0100" => disp4 <= dig4;
		when "0101" => disp4 <= dig5;
		when "0110" => disp4 <= dig6;
		when "0111" => disp4 <= dig7;
		when "1000" => disp4 <= dig8;
		when others => disp4 <= dig9;
		end case;
	end process;
------------------------------------------------------------------------------

	muxDisp: process (m) 
	begin 
	mux <= m(6)&m(4)&m(2)&m(0);
		case m is
			when "00000001" => disp <= disp1;
			when "00000100" => disp <= disp2;
			when "00010000" => disp <= disp3;
			when "01000000" => disp <= disp4;
			when others => disp <= apag;
		end case;
	end process;
	
end architecture;