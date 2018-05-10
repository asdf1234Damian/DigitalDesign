
--  CYPRESS NOVA XVL Structural Architecture

--  JED2VHD Reverse Assembler - 6.3 IR 35


--    VHDL File: Practica8.vhd

--    Date: Wed May 09 21:24:48 2018

--  Disassembly from Jedec file for: c22v10

--  Device Ordercode is: PALCE22V10-25PC/PI
library ieee;
use ieee.std_logic_1164.all;

library primitive;
use primitive.primitive.all;


-- Beginning Test Bench Header

ENTITY encoder IS
    PORT (
	               input :    in std_logic_vector (9 downto 0) ;
	              output : inout std_logic_vector (3 downto 0)
    );
END encoder;

-- End of Test Bench Header

ARCHITECTURE DSMB of encoder is

	signal jed_node1	: std_logic:='0' ; -- input(9)
	signal jed_node2	: std_logic:='0' ; -- input(8)
	signal jed_node3	: std_logic:='0' ; -- input(7)
	signal jed_node4	: std_logic:='0' ; -- input(6)
	signal jed_node5	: std_logic:='0' ; -- input(5)
	signal jed_node6	: std_logic:='0' ; -- input(4)
	signal jed_node7	: std_logic:='0' ; -- input(3)
	signal jed_node8	: std_logic:='0' ; -- input(2)
	signal jed_node9	: std_logic:='0' ; -- input(1)
	signal jed_node10	: std_logic:='0' ; -- input(0)
	signal jed_node11	: std_logic:='0' ;
	signal jed_node12	: std_logic:='0' ;
	signal jed_node13	: std_logic:='0' ;
	signal jed_node16	: std_logic:='0' ;
	signal jed_node17	: std_logic:='0' ;
	signal jed_node18	: std_logic:='0' ;
	signal jed_node19	: std_logic:='0' ;
	signal jed_node20	: std_logic:='0' ;
	signal jed_node21	: std_logic:='0' ;
	signal jed_node24	: std_logic:='0' ;

	for all: c22v10m use entity primitive.c22v10m (sim);

SIGNAL  one:std_logic:='1';
SIGNAL  zero:std_logic:='0';
SIGNAL  jed_oept_1:std_logic:='0';
--Attribute PIN_NUMBERS of input(9):SIGNAL is "0001";

SIGNAL  jed_oept_2:std_logic:='0';
--Attribute PIN_NUMBERS of input(8):SIGNAL is "0002";

SIGNAL  jed_oept_3:std_logic:='0';
--Attribute PIN_NUMBERS of input(7):SIGNAL is "0003";

SIGNAL  jed_oept_4:std_logic:='0';
--Attribute PIN_NUMBERS of input(6):SIGNAL is "0004";

SIGNAL  jed_oept_5:std_logic:='0';
--Attribute PIN_NUMBERS of input(5):SIGNAL is "0005";

SIGNAL  jed_oept_6:std_logic:='0';
--Attribute PIN_NUMBERS of input(4):SIGNAL is "0006";

SIGNAL  jed_oept_7:std_logic:='0';
--Attribute PIN_NUMBERS of input(3):SIGNAL is "0007";

SIGNAL  jed_oept_8:std_logic:='0';
--Attribute PIN_NUMBERS of input(2):SIGNAL is "0008";

SIGNAL  jed_oept_9:std_logic:='0';
--Attribute PIN_NUMBERS of input(1):SIGNAL is "0009";

SIGNAL  jed_oept_10:std_logic:='0';
--Attribute PIN_NUMBERS of input(0):SIGNAL is "0010";

SIGNAL  jed_oept_14:std_logic:='0';
SIGNAL  jed_sum_14,jed_fb_14:std_logic:='0';
--Attribute PIN_NUMBERS of output(2):SIGNAL is "0014";

SIGNAL  jed_oept_15:std_logic:='0';
SIGNAL  jed_sum_15,jed_fb_15:std_logic:='0';
--Attribute PIN_NUMBERS of output(0):SIGNAL is "0015";

SIGNAL  jed_oept_22:std_logic:='0';
SIGNAL  jed_sum_22,jed_fb_22:std_logic:='0';
--Attribute PIN_NUMBERS of output(3):SIGNAL is "0022";

SIGNAL  jed_oept_23:std_logic:='0';
SIGNAL  jed_sum_23,jed_fb_23:std_logic:='0';
--Attribute PIN_NUMBERS of output(1):SIGNAL is "0023";

SIGNAL  jed_oept_25:std_logic:='0';
SIGNAL  jed_node25,jed_sum_25:std_logic:='0';
SIGNAL  jed_oept_26:std_logic:='0';
SIGNAL  jed_node26,jed_sum_26:std_logic:='0';

BEGIN
jed_node1 <= input(9) ;
jed_node2 <= input(8) ;
jed_node3 <= input(7) ;
jed_node4 <= input(6) ;
jed_node5 <= input(5) ;
jed_node6 <= input(4) ;
jed_node7 <= input(3) ;
jed_node8 <= input(2) ;
jed_node9 <= input(1) ;
jed_node10 <= input(0) ;
Mcell_14:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_14,
     clk=>jed_node1,
     oe=>jed_oept_14,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>output(2),
     fb=>jed_fb_14
   );

Mcell_15:c22v10m
generic map(comb,
   invt,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_15,
     clk=>jed_node1,
     oe=>jed_oept_15,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>output(0),
     fb=>jed_fb_15
   );

Mcell_22:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_22,
     clk=>jed_node1,
     oe=>jed_oept_22,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>output(3),
     fb=>jed_fb_22
   );

Mcell_23:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_23,
     clk=>jed_node1,
     oe=>jed_oept_23,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>output(1),
     fb=>jed_fb_23
   );

jed_node25<=jed_sum_25;
jed_node26<=jed_sum_26;
jed_oept_14<=(one);

jed_sum_14<= ((not(jed_node1) and not(jed_node2) and not(jed_node7)
 and not(jed_node8) and not(jed_node9) and not(jed_node10)
) or
(not(jed_node1) and not(jed_node2) and (jed_node3)) or
(not(jed_node1) and not(jed_node2) and (jed_node4)) or
(not(jed_node1) and not(jed_node2) and (jed_node5)) or
(not(jed_node1) and not(jed_node2) and (jed_node6)));

jed_oept_15<=(one);

jed_sum_15<= ((not(jed_node1) and not(jed_node3) and not(jed_node5)
 and not(jed_node7) and not(jed_node9) and (jed_node10)
) or
(not(jed_node1) and not(jed_node3) and not(jed_node5)
 and not(jed_node7) and (jed_node8)) or
(not(jed_node1) and not(jed_node3) and not(jed_node5)
 and (jed_node6)) or
(not(jed_node1) and not(jed_node3) and (jed_node4)) or
(not(jed_node1) and (jed_node2)));

jed_oept_22<=(one);

jed_sum_22<= ((not(jed_node3) and not(jed_node4) and not(jed_node5)
 and not(jed_node6) and not(jed_node7) and not(jed_node8)
 and not(jed_node9) and not(jed_node10)) or
((jed_node1)) or
((jed_node2)));

jed_oept_23<=(one);

jed_sum_23<= ((not(jed_node1) and not(jed_node2) and not(jed_node5)
 and not(jed_node6) and not(jed_node9) and not(jed_node10)
) or
(not(jed_node1) and not(jed_node2) and not(jed_node5)
 and not(jed_node6) and (jed_node7)) or
(not(jed_node1) and not(jed_node2) and not(jed_node5)
 and not(jed_node6) and (jed_node8)) or
(not(jed_node1) and not(jed_node2) and (jed_node3)) or
(not(jed_node1) and not(jed_node2) and (jed_node4)));

end DSMB;
