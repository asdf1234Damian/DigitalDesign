/* Verilog model created from schematic Mux4a1.sch -- Sep 14, 2018 17:16 */

module Mux4a1( a0, a1, a2, a3, o, s0, s1 );
 input a0;
 input a1;
 input a2;
 input a3;
output o;
 input s0;
 input s1;
wire N_6;
wire N_7;
wire N_2;
wire N_3;
wire N_4;
wire N_5;



AND3 I4 ( .A(N_7), .B(a1), .C(s0), .Z(N_4) );
AND3 I1 ( .A(N_7), .B(a0), .C(N_6), .Z(N_5) );
AND3 I2 ( .A(s0), .B(a3), .C(s1), .Z(N_2) );
AND3 I3 ( .A(s1), .B(a2), .C(N_6), .Z(N_3) );
INV I6 ( .A(s0), .Z(N_6) );
INV I5 ( .A(s1), .Z(N_7) );
OR4 I7 ( .A(N_5), .B(N_4), .C(N_3), .D(N_2), .Z(o) );

endmodule // Mux4a1
