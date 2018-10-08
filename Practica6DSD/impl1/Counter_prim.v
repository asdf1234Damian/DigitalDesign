// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.10.0.111.2
// Netlist written on Mon Oct 08 14:36:37 2018
//
// Verilog Description of module Counter
//

module Counter (clk, sel, o);   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(5[8:15])
    output clk /* synthesis .original_dir=IN_OUT */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    input [1:0]sel;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:5])
    output o;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(9[2:3])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    
    wire GND_net, VCC_net, sel_c_1, sel_c_0, o_c;
    wire [27:0]d;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(21[9:10])
    
    wire n26, n25, n24, n23, n22, n21, n20, n19, n18, n17, 
        n16, n15, n14, n13, n12, n11, n10, n9, n8, n7, n6, 
        n5, n148, n147, n149, n150, n151, n152, n153, n154, 
        n155, n156, n157, n158, n159, n160, n161, n110, n111, 
        n112, n113, n114, n115, n116, n117, n118, n119, n120, 
        n121, n122, n123, n124, n125, n126, n127, n128, n129, 
        n130, n131, n132, n133, n134, n135;
    
    VHI i2 (.Z(VCC_net));
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk_c)) /* synthesis NOM_FREQ="133.00", syn_instantiated=1 */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(23[13:17])
    defparam OSCInst0.NOM_FREQ = "133.00";
    OB clk_pad (.I(clk_c), .O(clk));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    FD1S3AX d_12_13__i25 (.D(n110), .CK(clk_c), .Q(d[25])) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i25.GSR = "ENABLED";
    GSR GSR_INST (.GSR(VCC_net));
    VLO i1 (.Z(GND_net));
    OB o_pad (.I(o_c), .O(o));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(9[2:3])
    LUT4 i18_3_lut (.A(d[23]), .B(d[22]), .C(sel_c_0), .Z(n161)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i18_3_lut.init = 16'hcaca;
    LUT4 i17_3_lut (.A(d[25]), .B(d[24]), .C(sel_c_0), .Z(n160)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i17_3_lut.init = 16'hcaca;
    PFUMX i19 (.BLUT(n160), .ALUT(n161), .C0(sel_c_1), .Z(o_c));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    TSALL TSALL_INST (.TSALL(GND_net));
    CCU2D d_12_13_add_4_27 (.A0(d[25]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n159), 
          .S0(n110));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_27.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_27.INIT1 = 16'h0000;
    defparam d_12_13_add_4_27.INJECT1_0 = "NO";
    defparam d_12_13_add_4_27.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_25 (.A0(d[23]), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(d[24]), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n158), 
          .COUT(n159), .S0(n112), .S1(n111));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_25.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_25.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_25.INJECT1_0 = "NO";
    defparam d_12_13_add_4_25.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_23 (.A0(n5), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(d[22]), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n157), 
          .COUT(n158), .S0(n114), .S1(n113));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_23.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_23.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_23.INJECT1_0 = "NO";
    defparam d_12_13_add_4_23.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_21 (.A0(n7), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n6), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n156), 
          .COUT(n157), .S0(n116), .S1(n115));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_21.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_21.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_21.INJECT1_0 = "NO";
    defparam d_12_13_add_4_21.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_19 (.A0(n9), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n8), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n155), 
          .COUT(n156), .S0(n118), .S1(n117));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_19.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_19.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_19.INJECT1_0 = "NO";
    defparam d_12_13_add_4_19.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_17 (.A0(n11), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n10), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n154), 
          .COUT(n155), .S0(n120), .S1(n119));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_17.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_17.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_17.INJECT1_0 = "NO";
    defparam d_12_13_add_4_17.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_15 (.A0(n13), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n12), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n153), 
          .COUT(n154), .S0(n122), .S1(n121));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_15.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_15.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_15.INJECT1_0 = "NO";
    defparam d_12_13_add_4_15.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_13 (.A0(n15), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n14), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n152), 
          .COUT(n153), .S0(n124), .S1(n123));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_13.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_13.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_13.INJECT1_0 = "NO";
    defparam d_12_13_add_4_13.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_11 (.A0(n17), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n16), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n151), 
          .COUT(n152), .S0(n126), .S1(n125));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_11.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_11.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_11.INJECT1_0 = "NO";
    defparam d_12_13_add_4_11.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_9 (.A0(n19), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n18), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n150), 
          .COUT(n151), .S0(n128), .S1(n127));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_9.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_9.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_9.INJECT1_0 = "NO";
    defparam d_12_13_add_4_9.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_7 (.A0(n21), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n20), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n149), 
          .COUT(n150), .S0(n130), .S1(n129));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_7.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_7.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_7.INJECT1_0 = "NO";
    defparam d_12_13_add_4_7.INJECT1_1 = "NO";
    FD1S3AX d_12_13__i0 (.D(n135), .CK(clk_c), .Q(n26)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i0.GSR = "ENABLED";
    FD1S3AX d_12_13__i24 (.D(n111), .CK(clk_c), .Q(d[24])) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i24.GSR = "ENABLED";
    FD1S3AX d_12_13__i23 (.D(n112), .CK(clk_c), .Q(d[23])) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i23.GSR = "ENABLED";
    FD1S3AX d_12_13__i22 (.D(n113), .CK(clk_c), .Q(d[22])) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i22.GSR = "ENABLED";
    FD1S3AX d_12_13__i21 (.D(n114), .CK(clk_c), .Q(n5)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i21.GSR = "ENABLED";
    FD1S3AX d_12_13__i20 (.D(n115), .CK(clk_c), .Q(n6)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i20.GSR = "ENABLED";
    FD1S3AX d_12_13__i19 (.D(n116), .CK(clk_c), .Q(n7)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i19.GSR = "ENABLED";
    FD1S3AX d_12_13__i18 (.D(n117), .CK(clk_c), .Q(n8)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i18.GSR = "ENABLED";
    FD1S3AX d_12_13__i17 (.D(n118), .CK(clk_c), .Q(n9)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i17.GSR = "ENABLED";
    FD1S3AX d_12_13__i16 (.D(n119), .CK(clk_c), .Q(n10)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i16.GSR = "ENABLED";
    FD1S3AX d_12_13__i15 (.D(n120), .CK(clk_c), .Q(n11)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i15.GSR = "ENABLED";
    FD1S3AX d_12_13__i14 (.D(n121), .CK(clk_c), .Q(n12)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i14.GSR = "ENABLED";
    FD1S3AX d_12_13__i13 (.D(n122), .CK(clk_c), .Q(n13)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i13.GSR = "ENABLED";
    FD1S3AX d_12_13__i12 (.D(n123), .CK(clk_c), .Q(n14)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i12.GSR = "ENABLED";
    FD1S3AX d_12_13__i11 (.D(n124), .CK(clk_c), .Q(n15)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i11.GSR = "ENABLED";
    FD1S3AX d_12_13__i10 (.D(n125), .CK(clk_c), .Q(n16)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i10.GSR = "ENABLED";
    FD1S3AX d_12_13__i9 (.D(n126), .CK(clk_c), .Q(n17)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i9.GSR = "ENABLED";
    FD1S3AX d_12_13__i8 (.D(n127), .CK(clk_c), .Q(n18)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i8.GSR = "ENABLED";
    FD1S3AX d_12_13__i7 (.D(n128), .CK(clk_c), .Q(n19)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i7.GSR = "ENABLED";
    FD1S3AX d_12_13__i6 (.D(n129), .CK(clk_c), .Q(n20)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i6.GSR = "ENABLED";
    FD1S3AX d_12_13__i5 (.D(n130), .CK(clk_c), .Q(n21)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i5.GSR = "ENABLED";
    FD1S3AX d_12_13__i4 (.D(n131), .CK(clk_c), .Q(n22)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i4.GSR = "ENABLED";
    FD1S3AX d_12_13__i3 (.D(n132), .CK(clk_c), .Q(n23)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i3.GSR = "ENABLED";
    FD1S3AX d_12_13__i2 (.D(n133), .CK(clk_c), .Q(n24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i2.GSR = "ENABLED";
    FD1S3AX d_12_13__i1 (.D(n134), .CK(clk_c), .Q(n25)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13__i1.GSR = "ENABLED";
    CCU2D d_12_13_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n26), .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n147), 
          .S1(n135));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_1.INIT0 = 16'hF000;
    defparam d_12_13_add_4_1.INIT1 = 16'h0555;
    defparam d_12_13_add_4_1.INJECT1_0 = "NO";
    defparam d_12_13_add_4_1.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_5 (.A0(n23), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n22), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n148), 
          .COUT(n149), .S0(n132), .S1(n131));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_5.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_5.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_5.INJECT1_0 = "NO";
    defparam d_12_13_add_4_5.INJECT1_1 = "NO";
    CCU2D d_12_13_add_4_3 (.A0(n25), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(n24), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n147), 
          .COUT(n148), .S0(n134), .S1(n133));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_13_add_4_3.INIT0 = 16'hfaaa;
    defparam d_12_13_add_4_3.INIT1 = 16'hfaaa;
    defparam d_12_13_add_4_3.INJECT1_0 = "NO";
    defparam d_12_13_add_4_3.INJECT1_1 = "NO";
    IB sel_pad_1 (.I(sel[1]), .O(sel_c_1));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:5])
    IB sel_pad_0 (.I(sel[0]), .O(sel_c_0));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:5])
    
endmodule
//
// Verilog Description of module \OSCH("133.00")(1,6) 
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

