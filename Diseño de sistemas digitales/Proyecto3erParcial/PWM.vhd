library ieee; 
use ieee.numeric_std.all;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity Marquezina is
	port(
	 Clock: inout std_logic;
	 pPW:in std_logic;
	 mPW:in std_logic;
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
attribute NOM_FREQ of OSCinst0 : label is "44.33";
type  memROM_Array is array (0  to  16) of std_logic_vector(7 downto 0);
constant Content: memROM_Array := 
	(
		 0 => "11111111",
		 1 => "11111111", 
		 2 => "11111111",
		 3 => "11111111",
		 4 => "11111111",
		 5 => "11111111",  
		 6 => "11111111", 
		 7 => "11111111",
		 8 => "11111111",
		 9 => "11111111",
		 10=> "11111111",
		 11=> "11111111",
		 12=> "11111111",
		 13=> "11111111",
		 14=> "11111111",
		 15=> "11111111",
		OTHERS => "10000000"
	);
signal ClkArr: memROM_Array := 
	(
		 0 => "11111111",
		 1 => "11111111", 
		 2 => "11111111",
		 3 => "11111111",
		 4 => "11111111",
		 5 => "11111111", 
		 6 => "11111111", 
		 7 => "11111111",
		OTHERS => "11111111"
	);
signal PW: integer range 1 to 99 := 50;
signal onDuty: std_logic_vector(7 downto 0);
begin	OSCInst0 : OSCH GENERIC MAP("44.33")PORT MAP ('0', Clock);
	
	debouncerPlus:process(pPW,Clock)
	variable wasPressed: boolean:=false;
	variable count:integer range 0 to 1330000:=0;
	begin 
	if(rising_edge(Clock)) then
        if (wasPressed) then
			if(count < 1330000 ) then
				count := count + 1;
            else
				count := 0;
				wasPressed := false;
                if(pPW = '1'  and PW < 99) then
					PW <= PW+1;
				elsif(mPW = '1'  and PW > 1) then
					PW <= PW-1;
                end if;
			end if; 
		else
			if((pPW = '0' and mPW = '1') or (pPW = '1' and mPW = '0') ) then  
				wasPressed:= true;
			else
				wasPressed:= false;  
			end if;
		end if;
    end if;
	end process;
	
	ampMod: process(Clock) 
	variable count : integer range 0 to 13300;
	begin
		if (Clock'event and Clock='1' ) then 
			if(count < 13300) then			
				count:=count+1;
				if(count < (13300*PW/100)) then			
					onDuty<="11111111";
				else
					onDuty<="00000000";
				end if;
			else
				count:=0;
			end if; 
		end if;
	end process;
	
	
	lowClk: process(Clock)  
		variable count: integer range 0 to 13300; 
		variable count1: integer range 0 to 190000; 
		variable count2: integer range 0 to 380000; 
		variable count3: integer range 0 to 570000; 
		variable count4: integer range 0 to 760000; 
		variable count5: integer range 0 to 950000; 
		variable count6: integer range 0 to 1140000; 
		variable count7: integer range 0 to 1330000; 
		variable lowCLK: std_logic;
	begin
		if (Clock'event and Clock='1' ) then 
			if(count < 13300) then			
				count := count+1; 
			else
				mux<=mux(14 downto 0)&mux(15); 	
				count :=0;   
			end if;
			
			if(count1 < 190000) then			
				count1 := count1+1; 
			else
				ClkArr(1)<=not ClkArr(1);
				count1 :=0;   
			end if;
			
			if(count2 < 380000) then			
				count2 := count2+1; 
			else
				ClkArr(2)<=not ClkArr(2);
				count2 :=0;   
			end if;
			
			if(count3 <570000 ) then			
				count3 := count3+1; 
			else
				ClkArr(3)<=not ClkArr(3);
				count3 :=0;   
			end if;
			
			if(count4 < 760000) then			
				count4 := count4+1; 
			else
				ClkArr(4)<=not ClkArr(4);
				count4 :=0;   
			end if;
			
			if(count5 < 950000) then			
				count5 := count5+1; 
			else
				ClkArr(5)<=not ClkArr(5);
				count5 :=0;   
			end if;
			
			if(count6 <1140000 ) then			
				count6 := count6+1; 
			else
				ClkArr(6)<=not ClkArr(6);
				count6 :=0;   
			end if;
			
			if(count7 <1330000 ) then			
				count7 := count7+1; 
			else
				ClkArr(7)<=not ClkArr(7);
				count7 :=0;   
			end if;
		end if; 
	end process;  
	
	muxDisp: process (mux)
	variable adress:integer range 0 to 1 :=0;	
	begin
		case mux is
			when "1000000000000000" => Data <= Content(adress) and clkArr(0) and onDuty;
			when "0100000000000000" => Data <= Content(adress+1) and clkArr(1) and onDuty;
			when "0010000000000000" => Data <= Content(adress+2) and clkArr(2) and onDuty;
			when "0001000000000000" => Data <= Content(adress+3) and clkArr(3) and onDuty; 
			when "0000100000000000" => Data <= Content(adress+4) and clkArr(4) and onDuty;
			when "0000010000000000" => Data <= Content(adress+5) and clkArr(5) and onDuty;
			when "0000001000000000" => Data <= Content(adress+6) and clkArr(6) and onDuty;
			when "0000000100000000" => Data <= Content(adress+7) and clkArr(7) and onDuty; 
			when "0000000010000000" => Data <= Content(adress+7) and clkArr(7) and onDuty;
			when "0000000001000000" => Data <= Content(adress+6) and clkArr(6) and onDuty;
			when "0000000000100000" => Data <= Content(adress+5) and clkArr(5) and onDuty;
			when "0000000000010000" => Data <= Content(adress+4) and clkArr(4) and onDuty;
			when "0000000000001000" => Data <= Content(adress+3) and clkArr(3) and onDuty;
			when "0000000000000100" => Data <= Content(adress+2) and clkArr(2) and onDuty;
			when "0000000000000010" => Data <= Content(adress+1) and clkArr(1) and onDuty;
			when "0000000000000001" => Data <= Content(adress+0) and clkArr(0) and onDuty;
			when others => Data <= "00000000";
		end case;  
	end process;
 
end architecture;