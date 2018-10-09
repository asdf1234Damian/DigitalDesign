// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.10.0.111.2
// Netlist written on Mon Oct 08 19:04:18 2018
//
// Verilog Description of module Counter
//

module Counter (clk, data);   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(5[8:15])
    output clk /* synthesis .original_dir=IN_OUT */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    output [25:0]data;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    
    wire GND_net, VCC_net, data_c_25, data_c_24, data_c_23, data_c_22, 
        data_c_21, data_c_20, data_c_19, data_c_18, data_c_17, data_c_16, 
        data_c_15, data_c_14, data_c_13, data_c_12, data_c_11, data_c_10, 
        data_c_9, data_c_8, data_c_7, data_c_6, data_c_5, data_c_4, 
        data_c_3, data_c_2, data_c_1, data_c_0, n110, n111, n112, 
        n113, n114, n115, n116, n117_adj_1, n118_adj_2, n119_adj_3, 
        n120_adj_4, n121_adj_5, n122_adj_6, n123_adj_7, n124_adj_8, 
        n125_adj_9, n126_adj_10, n127_adj_11, n128_adj_12, n129_adj_13, 
        n130, n131, n132, n133, n134, n135, n117, n118, n119, 
        n120, n121, n122, n123, n124, n125, n126, n127, n128, 
        n129;
    
    VHI i2 (.Z(VCC_net));
    OSCH OSCInst0 (.STDBY(GND_net), .OSC(clk_c)) /* synthesis NOM_FREQ="53.20", syn_instantiated=1 */ ;   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(25[13:17])
    defparam OSCInst0.NOM_FREQ = "53.20";
    OB clk_pad (.I(clk_c), .O(clk));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(7[2:5])
    TSALL TSALL_INST (.TSALL(GND_net));
    OB data_pad_25 (.I(data_c_25), .O(data[25]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    GSR GSR_INST (.GSR(VCC_net));
    VLO i1 (.Z(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    CCU2D d_12_add_4_27 (.A0(data_c_25), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n129), 
          .S0(n110));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_27.INIT0 = 16'hfaaa;
    defparam d_12_add_4_27.INIT1 = 16'h0000;
    defparam d_12_add_4_27.INJECT1_0 = "NO";
    defparam d_12_add_4_27.INJECT1_1 = "NO";
    CCU2D d_12_add_4_25 (.A0(data_c_23), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_24), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n128), .COUT(n129), .S0(n112), .S1(n111));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_25.INIT0 = 16'hfaaa;
    defparam d_12_add_4_25.INIT1 = 16'hfaaa;
    defparam d_12_add_4_25.INJECT1_0 = "NO";
    defparam d_12_add_4_25.INJECT1_1 = "NO";
    CCU2D d_12_add_4_23 (.A0(data_c_21), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_22), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n127), .COUT(n128), .S0(n114), .S1(n113));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_23.INIT0 = 16'hfaaa;
    defparam d_12_add_4_23.INIT1 = 16'hfaaa;
    defparam d_12_add_4_23.INJECT1_0 = "NO";
    defparam d_12_add_4_23.INJECT1_1 = "NO";
    CCU2D d_12_add_4_21 (.A0(data_c_19), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_20), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n126), .COUT(n127), .S0(n116), .S1(n115));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_21.INIT0 = 16'hfaaa;
    defparam d_12_add_4_21.INIT1 = 16'hfaaa;
    defparam d_12_add_4_21.INJECT1_0 = "NO";
    defparam d_12_add_4_21.INJECT1_1 = "NO";
    CCU2D d_12_add_4_19 (.A0(data_c_17), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_18), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n125), .COUT(n126), .S0(n118_adj_2), .S1(n117_adj_1));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_19.INIT0 = 16'hfaaa;
    defparam d_12_add_4_19.INIT1 = 16'hfaaa;
    defparam d_12_add_4_19.INJECT1_0 = "NO";
    defparam d_12_add_4_19.INJECT1_1 = "NO";
    CCU2D d_12_add_4_17 (.A0(data_c_15), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_16), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n124), .COUT(n125), .S0(n120_adj_4), .S1(n119_adj_3));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_17.INIT0 = 16'hfaaa;
    defparam d_12_add_4_17.INIT1 = 16'hfaaa;
    defparam d_12_add_4_17.INJECT1_0 = "NO";
    defparam d_12_add_4_17.INJECT1_1 = "NO";
    CCU2D d_12_add_4_15 (.A0(data_c_13), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_14), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n123), .COUT(n124), .S0(n122_adj_6), .S1(n121_adj_5));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_15.INIT0 = 16'hfaaa;
    defparam d_12_add_4_15.INIT1 = 16'hfaaa;
    defparam d_12_add_4_15.INJECT1_0 = "NO";
    defparam d_12_add_4_15.INJECT1_1 = "NO";
    CCU2D d_12_add_4_13 (.A0(data_c_11), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_12), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n122), .COUT(n123), .S0(n124_adj_8), .S1(n123_adj_7));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_13.INIT0 = 16'hfaaa;
    defparam d_12_add_4_13.INIT1 = 16'hfaaa;
    defparam d_12_add_4_13.INJECT1_0 = "NO";
    defparam d_12_add_4_13.INJECT1_1 = "NO";
    CCU2D d_12_add_4_11 (.A0(data_c_9), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_10), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n121), .COUT(n122), .S0(n126_adj_10), .S1(n125_adj_9));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_11.INIT0 = 16'hfaaa;
    defparam d_12_add_4_11.INIT1 = 16'hfaaa;
    defparam d_12_add_4_11.INJECT1_0 = "NO";
    defparam d_12_add_4_11.INJECT1_1 = "NO";
    CCU2D d_12_add_4_9 (.A0(data_c_7), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_8), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n120), 
          .COUT(n121), .S0(n128_adj_12), .S1(n127_adj_11));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_9.INIT0 = 16'hfaaa;
    defparam d_12_add_4_9.INIT1 = 16'hfaaa;
    defparam d_12_add_4_9.INJECT1_0 = "NO";
    defparam d_12_add_4_9.INJECT1_1 = "NO";
    CCU2D d_12_add_4_7 (.A0(data_c_5), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_6), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n119), 
          .COUT(n120), .S0(n130), .S1(n129_adj_13));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_7.INIT0 = 16'hfaaa;
    defparam d_12_add_4_7.INIT1 = 16'hfaaa;
    defparam d_12_add_4_7.INJECT1_0 = "NO";
    defparam d_12_add_4_7.INJECT1_1 = "NO";
    CCU2D d_12_add_4_5 (.A0(data_c_3), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_4), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n118), 
          .COUT(n119), .S0(n132), .S1(n131));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_5.INIT0 = 16'hfaaa;
    defparam d_12_add_4_5.INIT1 = 16'hfaaa;
    defparam d_12_add_4_5.INJECT1_0 = "NO";
    defparam d_12_add_4_5.INJECT1_1 = "NO";
    CCU2D d_12_add_4_3 (.A0(data_c_1), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_2), .B1(GND_net), .C1(GND_net), .D1(GND_net), .CIN(n117), 
          .COUT(n118), .S0(n134), .S1(n133));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_3.INIT0 = 16'hfaaa;
    defparam d_12_add_4_3.INIT1 = 16'hfaaa;
    defparam d_12_add_4_3.INJECT1_0 = "NO";
    defparam d_12_add_4_3.INJECT1_1 = "NO";
    FD1S3AX d_12__i26 (.D(n110), .CK(clk_c), .Q(data_c_25)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i26.GSR = "ENABLED";
    FD1S3AX d_12__i25 (.D(n111), .CK(clk_c), .Q(data_c_24)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i25.GSR = "ENABLED";
    FD1S3AX d_12__i24 (.D(n112), .CK(clk_c), .Q(data_c_23)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i24.GSR = "ENABLED";
    FD1S3AX d_12__i23 (.D(n113), .CK(clk_c), .Q(data_c_22)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i23.GSR = "ENABLED";
    FD1S3AX d_12__i22 (.D(n114), .CK(clk_c), .Q(data_c_21)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i22.GSR = "ENABLED";
    FD1S3AX d_12__i21 (.D(n115), .CK(clk_c), .Q(data_c_20)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i21.GSR = "ENABLED";
    FD1S3AX d_12__i20 (.D(n116), .CK(clk_c), .Q(data_c_19)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i20.GSR = "ENABLED";
    FD1S3AX d_12__i19 (.D(n117_adj_1), .CK(clk_c), .Q(data_c_18)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i19.GSR = "ENABLED";
    FD1S3AX d_12__i18 (.D(n118_adj_2), .CK(clk_c), .Q(data_c_17)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i18.GSR = "ENABLED";
    FD1S3AX d_12__i17 (.D(n119_adj_3), .CK(clk_c), .Q(data_c_16)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i17.GSR = "ENABLED";
    FD1S3AX d_12__i16 (.D(n120_adj_4), .CK(clk_c), .Q(data_c_15)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i16.GSR = "ENABLED";
    FD1S3AX d_12__i15 (.D(n121_adj_5), .CK(clk_c), .Q(data_c_14)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i15.GSR = "ENABLED";
    FD1S3AX d_12__i14 (.D(n122_adj_6), .CK(clk_c), .Q(data_c_13)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i14.GSR = "ENABLED";
    FD1S3AX d_12__i13 (.D(n123_adj_7), .CK(clk_c), .Q(data_c_12)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i13.GSR = "ENABLED";
    FD1S3AX d_12__i12 (.D(n124_adj_8), .CK(clk_c), .Q(data_c_11)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i12.GSR = "ENABLED";
    FD1S3AX d_12__i11 (.D(n125_adj_9), .CK(clk_c), .Q(data_c_10)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i11.GSR = "ENABLED";
    FD1S3AX d_12__i10 (.D(n126_adj_10), .CK(clk_c), .Q(data_c_9)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i10.GSR = "ENABLED";
    FD1S3AX d_12__i9 (.D(n127_adj_11), .CK(clk_c), .Q(data_c_8)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i9.GSR = "ENABLED";
    FD1S3AX d_12__i8 (.D(n128_adj_12), .CK(clk_c), .Q(data_c_7)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i8.GSR = "ENABLED";
    FD1S3AX d_12__i7 (.D(n129_adj_13), .CK(clk_c), .Q(data_c_6)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i7.GSR = "ENABLED";
    FD1S3AX d_12__i6 (.D(n130), .CK(clk_c), .Q(data_c_5)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i6.GSR = "ENABLED";
    FD1S3AX d_12__i5 (.D(n131), .CK(clk_c), .Q(data_c_4)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i5.GSR = "ENABLED";
    FD1S3AX d_12__i4 (.D(n132), .CK(clk_c), .Q(data_c_3)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i4.GSR = "ENABLED";
    FD1S3AX d_12__i3 (.D(n133), .CK(clk_c), .Q(data_c_2)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i3.GSR = "ENABLED";
    FD1S3AX d_12__i2 (.D(n134), .CK(clk_c), .Q(data_c_1)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i2.GSR = "ENABLED";
    FD1S3AX d_12__i1 (.D(n135), .CK(clk_c), .Q(data_c_0)) /* synthesis syn_use_carry_chain=1 */ ;   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12__i1.GSR = "ENABLED";
    CCU2D d_12_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(data_c_0), .B1(GND_net), .C1(GND_net), .D1(GND_net), .COUT(n117), 
          .S1(n135));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam d_12_add_4_1.INIT0 = 16'hF000;
    defparam d_12_add_4_1.INIT1 = 16'h0555;
    defparam d_12_add_4_1.INJECT1_0 = "NO";
    defparam d_12_add_4_1.INJECT1_1 = "NO";
    OB data_pad_24 (.I(data_c_24), .O(data[24]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_23 (.I(data_c_23), .O(data[23]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_22 (.I(data_c_22), .O(data[22]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_21 (.I(data_c_21), .O(data[21]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_20 (.I(data_c_20), .O(data[20]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_19 (.I(data_c_19), .O(data[19]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_18 (.I(data_c_18), .O(data[18]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_17 (.I(data_c_17), .O(data[17]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_16 (.I(data_c_16), .O(data[16]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_15 (.I(data_c_15), .O(data[15]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_14 (.I(data_c_14), .O(data[14]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_13 (.I(data_c_13), .O(data[13]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_12 (.I(data_c_12), .O(data[12]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_11 (.I(data_c_11), .O(data[11]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_10 (.I(data_c_10), .O(data[10]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_9 (.I(data_c_9), .O(data[9]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_8 (.I(data_c_8), .O(data[8]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_7 (.I(data_c_7), .O(data[7]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_6 (.I(data_c_6), .O(data[6]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_5 (.I(data_c_5), .O(data[5]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_4 (.I(data_c_4), .O(data[4]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_3 (.I(data_c_3), .O(data[3]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_2 (.I(data_c_2), .O(data[2]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_1 (.I(data_c_1), .O(data[1]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    OB data_pad_0 (.I(data_c_0), .O(data[0]));   // c:/users/asdf1/documents/digitaldesign/practica6dsd/counter.vhd(8[2:6])
    
endmodule
//
// Verilog Description of module \OSCH("53.20")(1,5) 
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

