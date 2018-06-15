
--  CYPRESS NOVA XVL Structural Architecture

--  JED2VHD Reverse Assembler - 6.3 IR 35


--    VHDL File: Practica8.vhd

--    Date: Thu May 24 13:34:39 2018

--  Disassembly from Jedec file for: c22v10

--  Device Ordercode is: PALCE22V10-25PC/PI
library ieee;
use ieee.std_logic_1164.all;

library primitive;
use primitive.primitive.all;


-- Beginning Test Bench Header

ENTITY encoder IS
    PORT (
	                   i :    in std_logic_vector (9 downto 0) ;
	                   o : inout std_logic_vector (3 downto 0)
    );
END encoder;

-- End of Test Bench Header

ARCHITECTURE DSMB of encoder is

	signal jed_node1	: std_logic:='0' ; -- i(0)
	signal jed_node2	: std_logic:='0' ; -- i(1)
	signal jed_node3	: std_logic:='0' ; -- i(2)
	signal jed_node4	: std_logic:='0' ; -- i(3)
	signal jed_node5	: std_logic:='0' ; -- i(4)
	signal jed_node6	: std_logic:='0' ; -- i(5)
	signal jed_node7	: std_logic:='0' ; -- i(6)
	signal jed_node8	: std_logic:='0' ; -- i(7)
	signal jed_node9	: std_logic:='0' ; -- i(8)
	signal jed_node10	: std_logic:='0' ; -- i(9)
	signal jed_node11	: std_logic:='0' ;
	signal jed_node12	: std_logic:='0' ;
	signal jed_node13	: std_logic:='0' ;
	signal jed_node18	: std_logic:='0' ;
	signal jed_node19	: std_logic:='0' ;
	signal jed_node20	: std_logic:='0' ;
	signal jed_node21	: std_logic:='0' ;
	signal jed_node22	: std_logic:='0' ;
	signal jed_node23	: std_logic:='0' ;
	signal jed_node24	: std_logic:='0' ;

	for all: c22v10m use entity primitive.c22v10m (sim);

SIGNAL  one:std_logic:='1';
SIGNAL  zero:std_logic:='0';
SIGNAL  jed_oept_1:std_logic:='0';
--Attribute PIN_NUMBERS of i(0):SIGNAL is "0001";

SIGNAL  jed_oept_2:std_logic:='0';
--Attribute PIN_NUMBERS of i(1):SIGNAL is "0002";

SIGNAL  jed_oept_3:std_logic:='0';
--Attribute PIN_NUMBERS of i(2):SIGNAL is "0003";

SIGNAL  jed_oept_4:std_logic:='0';
--Attribute PIN_NUMBERS of i(3):SIGNAL is "0004";

SIGNAL  jed_oept_5:std_logic:='0';
--Attribute PIN_NUMBERS of i(4):SIGNAL is "0005";

SIGNAL  jed_oept_6:std_logic:='0';
--Attribute PIN_NUMBERS of i(5):SIGNAL is "0006";

SIGNAL  jed_oept_7:std_logic:='0';
--Attribute PIN_NUMBERS of i(6):SIGNAL is "0007";

SIGNAL  jed_oept_8:std_logic:='0';
--Attribute PIN_NUMBERS of i(7):SIGNAL is "0008";

SIGNAL  jed_oept_9:std_logic:='0';
--Attribute PIN_NUMBERS of i(8):SIGNAL is "0009";

SIGNAL  jed_oept_10:std_logic:='0';
--Attribute PIN_NUMBERS of i(9):SIGNAL is "0010";

SIGNAL  jed_oept_14:std_logic:='0';
SIGNAL  jed_sum_14,jed_fb_14:std_logic:='0';
--Attribute PIN_NUMBERS of o(0):SIGNAL is "0014";

SIGNAL  jed_oept_15:std_logic:='0';
SIGNAL  jed_sum_15,jed_fb_15:std_logic:='0';
--Attribute PIN_NUMBERS of o(1):SIGNAL is "0015";

SIGNAL  jed_oept_16:std_logic:='0';
SIGNAL  jed_sum_16,jed_fb_16:std_logic:='0';
--Attribute PIN_NUMBERS of o(2):SIGNAL is "0016";

SIGNAL  jed_oept_17:std_logic:='0';
SIGNAL  jed_sum_17,jed_fb_17:std_logic:='0';
--Attribute PIN_NUMBERS of o(3):SIGNAL is "0017";

SIGNAL  jed_oept_25:std_logic:='0';
SIGNAL  jed_node25,jed_sum_25:std_logic:='0';
SIGNAL  jed_oept_26:std_logic:='0';
SIGNAL  jed_node26,jed_sum_26:std_logic:='0';

BEGIN
jed_node1 <= i(0) ;
jed_node2 <= i(1) ;
jed_node3 <= i(2) ;
jed_node4 <= i(3) ;
jed_node5 <= i(4) ;
jed_node6 <= i(5) ;
jed_node7 <= i(6) ;
jed_node8 <= i(7) ;
jed_node9 <= i(8) ;
jed_node10 <= i(9) ;
Mcell_14:c22v10m
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
     d=>jed_sum_14,
     clk=>jed_node1,
     oe=>jed_oept_14,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>o(0),
     fb=>jed_fb_14
   );

Mcell_15:c22v10m
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
     d=>jed_sum_15,
     clk=>jed_node1,
     oe=>jed_oept_15,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>o(1),
     fb=>jed_fb_15
   );

Mcell_16:c22v10m
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
     d=>jed_sum_16,
     clk=>jed_node1,
     oe=>jed_oept_16,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>o(2),
     fb=>jed_fb_16
   );

Mcell_17:c22v10m
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
     d=>jed_sum_17,
     clk=>jed_node1,
     oe=>jed_oept_17,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>o(3),
     fb=>jed_fb_17
   );

jed_node25<=jed_sum_25;
jed_node26<=jed_sum_26;
jed_oept_14<=(one);

jed_sum_14<= (((jed_node1) and not(jed_node2) and not(jed_node4) and not(jed_node6)
 and not(jed_node8) and not(jed_node10)) or
((jed_node3) and not(jed_node4) and not(jed_node6) and not(jed_node8)
 and not(jed_node10)) or
((jed_node5) and not(jed_node6) and not(jed_node8) and not(jed_node10)
) or
((jed_node7) and not(jed_node8) and not(jed_node10)
) or
((jed_node9) and not(jed_node10)));

jed_oept_15<=(one);

jed_sum_15<= ((not(jed_node1) and not(jed_node2) and not(jed_node5)
 and not(jed_node6) and not(jed_node9) and not(jed_node10)
) or
((jed_node4) and not(jed_node5) and not(jed_node6) and not(jed_node9)
 and not(jed_node10)) or
((jed_node3) and not(jed_node5) and not(jed_node6) and not(jed_node9)
 and not(jed_node10)) or
((jed_node8) and not(jed_node9) and not(jed_node10)
) or
((jed_node7) and not(jed_node9) and not(jed_node10)
));

jed_oept_16<=(one);

jed_sum_16<= ((not(jed_node1) and not(jed_node2) and not(jed_node3)
 and not(jed_node4) and not(jed_node9) and not(jed_node10)
) or
((jed_node8) and not(jed_node9) and not(jed_node10)
) or
((jed_node7) and not(jed_node9) and not(jed_node10)
) or
((jed_node6) and not(jed_node9) and not(jed_node10)
) or
((jed_node5) and not(jed_node9) and not(jed_node10)
));

jed_oept_17<=(one);

jed_sum_17<= ((not(jed_node1) and not(jed_node2) and not(jed_node3)
 and not(jed_node4) and not(jed_node5) and not(jed_node6)
 and not(jed_node7) and not(jed_node8)) or
((jed_node10)) or
((jed_node9)));

end DSMB;
