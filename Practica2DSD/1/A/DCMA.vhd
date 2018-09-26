LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY lattice;
USE lattice.components.all;

ENTITY blinking_led IS
   PORT(
      led  : BUFFER  STD_LOGIC);
END blinking_led;

ARCHITECTURE behavior OF blinking_led IS
   SIGNAL  clk  : STD_LOGIC;
   --internal oscillator
   COMPONENT OSCH
      GENERIC(
            NOM_FREQ: string := "53.20");
      PORT( 
            STDBY    : IN  STD_LOGIC;
            OSC      : OUT STD_LOGIC;
            SEDSTDBY : OUT STD_LOGIC);
   END COMPONENT;
BEGIN
   --internal oscillator
   OSCInst0: OSCH
      GENERIC MAP (NOM_FREQ  => "53.20")
      PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
   PROCESS(clk)
      VARIABLE count :   INTEGER RANGE 0 TO 25_000_000;
   BEGIN
      IF(clk'EVENT AND clk = '1') THEN
         IF(count < 25_000_000) THEN
            count := count + 1;
         ELSE
            count := 0;
            led <= NOT led;
         END IF;
      END IF;
   END PROCESS;
END behavior;