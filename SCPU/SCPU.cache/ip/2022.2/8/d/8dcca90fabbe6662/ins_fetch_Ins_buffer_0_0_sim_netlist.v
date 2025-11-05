// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Nov  5 17:08:45 2025
// Host        : Plana running 64-bit Arch Linux
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ins_fetch_Ins_buffer_0_0_sim_netlist.v
// Design      : ins_fetch_Ins_buffer_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer
   (ins_out,
    rst,
    clk,
    pc_in);
  output [4:0]ins_out;
  input rst;
  input clk;
  input [7:0]pc_in;

  wire clk;
  wire [4:0]ins_out;
  wire ins_out1_carry__0_n_1;
  wire ins_out1_carry__0_n_2;
  wire ins_out1_carry__0_n_3;
  wire ins_out1_carry__0_n_4;
  wire ins_out1_carry_i_1__0_n_0;
  wire ins_out1_carry_i_1_n_0;
  wire ins_out1_carry_i_2__0_n_0;
  wire ins_out1_carry_i_2_n_0;
  wire ins_out1_carry_i_3__0_n_0;
  wire ins_out1_carry_i_3_n_0;
  wire ins_out1_carry_i_4__0_n_0;
  wire ins_out1_carry_i_4_n_0;
  wire ins_out1_carry_n_0;
  wire ins_out1_carry_n_1;
  wire ins_out1_carry_n_2;
  wire ins_out1_carry_n_3;
  wire ins_out1_carry_n_4;
  wire ins_out1_carry_n_5;
  wire ins_out1_carry_n_6;
  wire ins_out1_carry_n_7;
  wire \ins_out[1]_i_1_n_0 ;
  wire \ins_out[28]_i_1_n_0 ;
  wire \ins_out[29]_i_1_n_0 ;
  wire \ins_out[30]_i_1_n_0 ;
  wire \ins_out[4]_i_1_n_0 ;
  wire [7:0]pc_in;
  wire rst;
  wire [3:3]NLW_ins_out1_carry__0_CO_UNCONNECTED;
  wire [2:0]NLW_ins_out1_carry__0_O_UNCONNECTED;

  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ins_out1_carry
       (.CI(1'b0),
        .CO({ins_out1_carry_n_0,ins_out1_carry_n_1,ins_out1_carry_n_2,ins_out1_carry_n_3}),
        .CYINIT(1'b1),
        .DI(pc_in[3:0]),
        .O({ins_out1_carry_n_4,ins_out1_carry_n_5,ins_out1_carry_n_6,ins_out1_carry_n_7}),
        .S({ins_out1_carry_i_1_n_0,ins_out1_carry_i_2__0_n_0,ins_out1_carry_i_3__0_n_0,ins_out1_carry_i_4__0_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ins_out1_carry__0
       (.CI(ins_out1_carry_n_0),
        .CO({NLW_ins_out1_carry__0_CO_UNCONNECTED[3],ins_out1_carry__0_n_1,ins_out1_carry__0_n_2,ins_out1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,pc_in[6:4]}),
        .O({ins_out1_carry__0_n_4,NLW_ins_out1_carry__0_O_UNCONNECTED[2:0]}),
        .S({ins_out1_carry_i_1__0_n_0,ins_out1_carry_i_2_n_0,ins_out1_carry_i_3_n_0,ins_out1_carry_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_1
       (.I0(pc_in[3]),
        .O(ins_out1_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_1__0
       (.I0(pc_in[7]),
        .O(ins_out1_carry_i_1__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_2
       (.I0(pc_in[6]),
        .O(ins_out1_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_2__0
       (.I0(pc_in[2]),
        .O(ins_out1_carry_i_2__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_3
       (.I0(pc_in[5]),
        .O(ins_out1_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_3__0
       (.I0(pc_in[1]),
        .O(ins_out1_carry_i_3__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_4
       (.I0(pc_in[4]),
        .O(ins_out1_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ins_out1_carry_i_4__0
       (.I0(pc_in[0]),
        .O(ins_out1_carry_i_4__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \ins_out[1]_i_1 
       (.I0(ins_out1_carry__0_n_4),
        .I1(ins_out1_carry_n_4),
        .I2(ins_out1_carry_n_6),
        .I3(rst),
        .O(\ins_out[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000444)) 
    \ins_out[28]_i_1 
       (.I0(ins_out1_carry_n_4),
        .I1(ins_out1_carry_n_7),
        .I2(ins_out1_carry_n_5),
        .I3(ins_out1_carry_n_6),
        .I4(ins_out1_carry__0_n_4),
        .I5(rst),
        .O(\ins_out[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000444)) 
    \ins_out[29]_i_1 
       (.I0(ins_out1_carry_n_4),
        .I1(ins_out1_carry_n_6),
        .I2(ins_out1_carry_n_7),
        .I3(ins_out1_carry_n_5),
        .I4(ins_out1_carry__0_n_4),
        .I5(rst),
        .O(\ins_out[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000070)) 
    \ins_out[30]_i_1 
       (.I0(ins_out1_carry_n_6),
        .I1(ins_out1_carry_n_7),
        .I2(ins_out1_carry_n_5),
        .I3(ins_out1_carry__0_n_4),
        .I4(rst),
        .O(\ins_out[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \ins_out[4]_i_1 
       (.I0(ins_out1_carry__0_n_4),
        .I1(ins_out1_carry_n_4),
        .I2(ins_out1_carry_n_7),
        .I3(rst),
        .O(\ins_out[4]_i_1_n_0 ));
  FDRE \ins_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\ins_out[1]_i_1_n_0 ),
        .Q(ins_out[0]),
        .R(1'b0));
  FDRE \ins_out_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(\ins_out[28]_i_1_n_0 ),
        .Q(ins_out[2]),
        .R(1'b0));
  FDRE \ins_out_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(\ins_out[29]_i_1_n_0 ),
        .Q(ins_out[3]),
        .R(1'b0));
  FDRE \ins_out_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(\ins_out[30]_i_1_n_0 ),
        .Q(ins_out[4]),
        .R(1'b0));
  FDRE \ins_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\ins_out[4]_i_1_n_0 ),
        .Q(ins_out[1]),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "ins_fetch_Ins_buffer_0_0,Ins_buffer,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Ins_buffer,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    rst,
    pc_in,
    base_in,
    ins_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input [31:0]pc_in;
  input [31:0]base_in;
  output [31:0]ins_out;

  wire \<const0> ;
  wire clk;
  wire [26:0]\^ins_out ;
  wire [31:0]pc_in;
  wire rst;

  assign ins_out[31] = \<const0> ;
  assign ins_out[30:28] = \^ins_out [26:24];
  assign ins_out[27] = \<const0> ;
  assign ins_out[26:24] = \^ins_out [26:24];
  assign ins_out[23] = \<const0> ;
  assign ins_out[22:20] = \^ins_out [26:24];
  assign ins_out[19] = \<const0> ;
  assign ins_out[18:16] = \^ins_out [26:24];
  assign ins_out[15] = \<const0> ;
  assign ins_out[14:12] = \^ins_out [26:24];
  assign ins_out[11] = \<const0> ;
  assign ins_out[10:8] = \^ins_out [26:24];
  assign ins_out[7] = \<const0> ;
  assign ins_out[6:5] = \^ins_out [26:25];
  assign ins_out[4] = \^ins_out [0];
  assign ins_out[3] = \<const0> ;
  assign ins_out[2] = \^ins_out [26];
  assign ins_out[1:0] = \^ins_out [1:0];
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer inst
       (.clk(clk),
        .ins_out({\^ins_out [26:24],\^ins_out [0],\^ins_out [1]}),
        .pc_in(pc_in[7:0]),
        .rst(rst));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
