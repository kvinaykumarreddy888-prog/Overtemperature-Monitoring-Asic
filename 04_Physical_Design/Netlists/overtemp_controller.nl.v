module overtemp_controller (clk,
    cooling_enable,
    manual_clear,
    overtemp_in,
    rst_n,
    shutdown,
    system_enable,
    system_running,
    warning);
 input clk;
 output cooling_enable;
 input manual_clear;
 input overtemp_in;
 input rst_n;
 output shutdown;
 input system_enable;
 output system_running;
 output warning;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire clear_meta;
 wire clear_sync;
 wire enable_meta;
 wire enable_sync;
 wire overtemp_meta;
 wire overtemp_sync;
 wire \persist_count[0] ;
 wire \persist_count[1] ;
 wire \persist_count[2] ;
 wire \persist_count[3] ;
 wire \state[0] ;
 wire \state[1] ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire clknet_0_clk;
 wire clknet_1_0__leaf_clk;
 wire clknet_1_1__leaf_clk;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;

 sky130_fd_sc_hd__and2b_1 _22_ (.A_N(\state[0] ),
    .B(\state[1] ),
    .X(_06_));
 sky130_fd_sc_hd__buf_1 _23_ (.A(_06_),
    .X(net6));
 sky130_fd_sc_hd__and2b_1 _24_ (.A_N(\state[1] ),
    .B(\state[0] ),
    .X(_07_));
 sky130_fd_sc_hd__or2_1 _25_ (.A(net6),
    .B(_07_),
    .X(_08_));
 sky130_fd_sc_hd__clkbuf_1 _26_ (.A(_08_),
    .X(net5));
 sky130_fd_sc_hd__and2b_1 _27_ (.A_N(net6),
    .B(enable_sync),
    .X(_09_));
 sky130_fd_sc_hd__clkbuf_1 _28_ (.A(_09_),
    .X(net7));
 sky130_fd_sc_hd__or2b_1 _29_ (.A(overtemp_sync),
    .B_N(clear_sync),
    .X(_10_));
 sky130_fd_sc_hd__and3b_1 _30_ (.A_N(\state[1] ),
    .B(\state[0] ),
    .C(overtemp_sync),
    .X(_11_));
 sky130_fd_sc_hd__and4b_1 _31_ (.A_N(\persist_count[3] ),
    .B(\persist_count[2] ),
    .C(\persist_count[0] ),
    .D(\persist_count[1] ),
    .X(_12_));
 sky130_fd_sc_hd__a22o_1 _32_ (.A1(net6),
    .A2(_10_),
    .B1(_11_),
    .B2(_12_),
    .X(_13_));
 sky130_fd_sc_hd__buf_1 _33_ (.A(_13_),
    .X(_05_));
 sky130_fd_sc_hd__a21oi_1 _34_ (.A1(\persist_count[0] ),
    .A2(\state[0] ),
    .B1(\state[1] ),
    .Y(_14_));
 sky130_fd_sc_hd__a22o_1 _35_ (.A1(\persist_count[0] ),
    .A2(_05_),
    .B1(_14_),
    .B2(overtemp_sync),
    .X(_00_));
 sky130_fd_sc_hd__nand2_1 _36_ (.A(\persist_count[0] ),
    .B(\persist_count[1] ),
    .Y(_15_));
 sky130_fd_sc_hd__or2_1 _37_ (.A(\persist_count[0] ),
    .B(\persist_count[1] ),
    .X(_16_));
 sky130_fd_sc_hd__a32o_1 _38_ (.A1(_11_),
    .A2(_15_),
    .A3(_16_),
    .B1(_05_),
    .B2(\persist_count[1] ),
    .X(_01_));
 sky130_fd_sc_hd__inv_2 _39_ (.A(\persist_count[2] ),
    .Y(_17_));
 sky130_fd_sc_hd__o21a_1 _40_ (.A1(_17_),
    .A2(_15_),
    .B1(_11_),
    .X(_18_));
 sky130_fd_sc_hd__a31o_1 _41_ (.A1(\persist_count[0] ),
    .A2(\persist_count[1] ),
    .A3(_11_),
    .B1(\persist_count[2] ),
    .X(_19_));
 sky130_fd_sc_hd__o21a_1 _42_ (.A1(_05_),
    .A2(_18_),
    .B1(_19_),
    .X(_02_));
 sky130_fd_sc_hd__and2_1 _43_ (.A(net6),
    .B(_10_),
    .X(_20_));
 sky130_fd_sc_hd__o21a_1 _44_ (.A1(_20_),
    .A2(_18_),
    .B1(net14),
    .X(_03_));
 sky130_fd_sc_hd__inv_2 _45_ (.A(overtemp_sync),
    .Y(_21_));
 sky130_fd_sc_hd__a211oi_1 _46_ (.A1(\state[0] ),
    .A2(_12_),
    .B1(net15),
    .C1(_21_),
    .Y(_04_));
 sky130_fd_sc_hd__dfrtp_2 _47_ (.CLK(clknet_1_1__leaf_clk),
    .D(_00_),
    .RESET_B(net9),
    .Q(\persist_count[0] ));
 sky130_fd_sc_hd__dfrtp_1 _48_ (.CLK(clknet_1_0__leaf_clk),
    .D(_01_),
    .RESET_B(net9),
    .Q(\persist_count[1] ));
 sky130_fd_sc_hd__dfrtp_1 _49_ (.CLK(clknet_1_0__leaf_clk),
    .D(_02_),
    .RESET_B(net9),
    .Q(\persist_count[2] ));
 sky130_fd_sc_hd__dfrtp_1 _50_ (.CLK(clknet_1_0__leaf_clk),
    .D(_03_),
    .RESET_B(net9),
    .Q(\persist_count[3] ));
 sky130_fd_sc_hd__dfrtp_1 _51_ (.CLK(clknet_1_1__leaf_clk),
    .D(_04_),
    .RESET_B(net9),
    .Q(\state[0] ));
 sky130_fd_sc_hd__dfrtp_1 _52_ (.CLK(clknet_1_0__leaf_clk),
    .D(_05_),
    .RESET_B(net9),
    .Q(\state[1] ));
 sky130_fd_sc_hd__dfrtp_1 _53_ (.CLK(clknet_1_1__leaf_clk),
    .D(net2),
    .RESET_B(net9),
    .Q(overtemp_meta));
 sky130_fd_sc_hd__dfrtp_1 _54_ (.CLK(clknet_1_1__leaf_clk),
    .D(net13),
    .RESET_B(net9),
    .Q(overtemp_sync));
 sky130_fd_sc_hd__dfrtp_1 _55_ (.CLK(clknet_1_1__leaf_clk),
    .D(net1),
    .RESET_B(net3),
    .Q(clear_meta));
 sky130_fd_sc_hd__dfrtp_1 _56_ (.CLK(clknet_1_1__leaf_clk),
    .D(net12),
    .RESET_B(net3),
    .Q(clear_sync));
 sky130_fd_sc_hd__dfrtp_1 _57_ (.CLK(clknet_1_0__leaf_clk),
    .D(net4),
    .RESET_B(net9),
    .Q(enable_meta));
 sky130_fd_sc_hd__dfrtp_1 _58_ (.CLK(clknet_1_0__leaf_clk),
    .D(net11),
    .RESET_B(net9),
    .Q(enable_sync));
 sky130_fd_sc_hd__clkbuf_1 _59_ (.A(net5),
    .X(net8));
 sky130_fd_sc_hd__decap_3 PHY_0 ();
 sky130_fd_sc_hd__decap_3 PHY_1 ();
 sky130_fd_sc_hd__decap_3 PHY_2 ();
 sky130_fd_sc_hd__decap_3 PHY_3 ();
 sky130_fd_sc_hd__decap_3 PHY_4 ();
 sky130_fd_sc_hd__decap_3 PHY_5 ();
 sky130_fd_sc_hd__decap_3 PHY_6 ();
 sky130_fd_sc_hd__decap_3 PHY_7 ();
 sky130_fd_sc_hd__decap_3 PHY_8 ();
 sky130_fd_sc_hd__decap_3 PHY_9 ();
 sky130_fd_sc_hd__decap_3 PHY_10 ();
 sky130_fd_sc_hd__decap_3 PHY_11 ();
 sky130_fd_sc_hd__decap_3 PHY_12 ();
 sky130_fd_sc_hd__decap_3 PHY_13 ();
 sky130_fd_sc_hd__decap_3 PHY_14 ();
 sky130_fd_sc_hd__decap_3 PHY_15 ();
 sky130_fd_sc_hd__decap_3 PHY_16 ();
 sky130_fd_sc_hd__decap_3 PHY_17 ();
 sky130_fd_sc_hd__decap_3 PHY_18 ();
 sky130_fd_sc_hd__decap_3 PHY_19 ();
 sky130_fd_sc_hd__decap_3 PHY_20 ();
 sky130_fd_sc_hd__decap_3 PHY_21 ();
 sky130_fd_sc_hd__decap_3 PHY_22 ();
 sky130_fd_sc_hd__decap_3 PHY_23 ();
 sky130_fd_sc_hd__decap_3 PHY_24 ();
 sky130_fd_sc_hd__decap_3 PHY_25 ();
 sky130_fd_sc_hd__decap_3 PHY_26 ();
 sky130_fd_sc_hd__decap_3 PHY_27 ();
 sky130_fd_sc_hd__decap_3 PHY_28 ();
 sky130_fd_sc_hd__decap_3 PHY_29 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_30 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_31 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_32 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_54 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(manual_clear),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(overtemp_in),
    .X(net2));
 sky130_fd_sc_hd__buf_1 input3 (.A(net10),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(system_enable),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_4 output5 (.A(net5),
    .X(cooling_enable));
 sky130_fd_sc_hd__clkbuf_4 output6 (.A(net6),
    .X(shutdown));
 sky130_fd_sc_hd__clkbuf_4 output7 (.A(net7),
    .X(system_running));
 sky130_fd_sc_hd__buf_2 output8 (.A(net8),
    .X(warning));
 sky130_fd_sc_hd__clkbuf_4 fanout9 (.A(net3),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_clk (.A(clknet_0_clk),
    .X(clknet_1_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_clk (.A(clknet_0_clk),
    .X(clknet_1_1__leaf_clk));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(rst_n),
    .X(net10));
 sky130_fd_sc_hd__dlygate4sd3_1 hold2 (.A(enable_meta),
    .X(net11));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(clear_meta),
    .X(net12));
 sky130_fd_sc_hd__dlygate4sd3_1 hold4 (.A(overtemp_meta),
    .X(net13));
 sky130_fd_sc_hd__dlygate4sd3_1 hold5 (.A(\persist_count[3] ),
    .X(net14));
 sky130_fd_sc_hd__dlygate4sd3_1 hold6 (.A(\state[1] ),
    .X(net15));
 sky130_ef_sc_hd__decap_12 FILLER_0_0_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_0_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_0_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_0_29 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_0_41 ();
 sky130_fd_sc_hd__decap_6 FILLER_0_0_49 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_0_55 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_0_57 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_0_69 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_0_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_0_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_39 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_1_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_1_55 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_57 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_1_69 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_1_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_1_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_2_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_2_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_2_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_2_29 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_2_37 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_2_44 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_2_70 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_2_82 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_2_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_3_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_3_15 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_3_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_3_35 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_3_76 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_3_84 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_4_6 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_4_18 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_4_26 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_4_38 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_4_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_4_85 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_5_78 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_6_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_6_7 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_6_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_6_44 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_6_68 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_6_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_6_85 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_7_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_7_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_7_35 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_7_47 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_7_64 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_7_76 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_7_84 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_8_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_8_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_29 ();
 sky130_fd_sc_hd__decap_6 FILLER_0_8_40 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_8_51 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_8_63 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_8_75 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_8_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_8_85 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_9_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_9_11 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_33 ();
 sky130_fd_sc_hd__decap_6 FILLER_0_9_57 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_9_69 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_9_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_9_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_10_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_10_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_10_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_10_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_10_43 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_10_55 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_10_76 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_10_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_11_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_11_15 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_11_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_11_39 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_11_51 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_11_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_11_85 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_12_3 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_12_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_12_85 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_13_3 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_13_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_13_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_13_36 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_13_48 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_13_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_13_85 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_14_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_14 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_14_23 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_14_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_14_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_14_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_53 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_14_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_14_69 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_14_76 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_14_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_14_85 ();
endmodule
