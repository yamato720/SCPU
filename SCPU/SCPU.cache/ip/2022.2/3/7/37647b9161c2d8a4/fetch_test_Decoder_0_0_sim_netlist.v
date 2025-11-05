// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Nov  5 16:02:12 2025
// Host        : Plana running 64-bit Arch Linux
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fetch_test_Decoder_0_0_sim_netlist.v
// Design      : fetch_test_Decoder_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder
   (Q,
    rst,
    instruction,
    clk);
  output [31:0]Q;
  input rst;
  input [31:0]instruction;
  input clk;

  wire [31:0]Q;
  wire clk;
  wire [31:0]instruction;
  wire rst;

  FDRE \instruction_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[0]),
        .Q(Q[0]),
        .R(rst));
  FDRE \instruction_reg_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[10]),
        .Q(Q[10]),
        .R(rst));
  FDRE \instruction_reg_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[11]),
        .Q(Q[11]),
        .R(rst));
  FDRE \instruction_reg_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[12]),
        .Q(Q[12]),
        .R(rst));
  FDRE \instruction_reg_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[13]),
        .Q(Q[13]),
        .R(rst));
  FDRE \instruction_reg_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[14]),
        .Q(Q[14]),
        .R(rst));
  FDRE \instruction_reg_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[15]),
        .Q(Q[15]),
        .R(rst));
  FDRE \instruction_reg_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[16]),
        .Q(Q[16]),
        .R(rst));
  FDRE \instruction_reg_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[17]),
        .Q(Q[17]),
        .R(rst));
  FDRE \instruction_reg_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[18]),
        .Q(Q[18]),
        .R(rst));
  FDRE \instruction_reg_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[19]),
        .Q(Q[19]),
        .R(rst));
  FDRE \instruction_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[1]),
        .Q(Q[1]),
        .R(rst));
  FDRE \instruction_reg_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[20]),
        .Q(Q[20]),
        .R(rst));
  FDRE \instruction_reg_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[21]),
        .Q(Q[21]),
        .R(rst));
  FDRE \instruction_reg_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[22]),
        .Q(Q[22]),
        .R(rst));
  FDRE \instruction_reg_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[23]),
        .Q(Q[23]),
        .R(rst));
  FDRE \instruction_reg_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[24]),
        .Q(Q[24]),
        .R(rst));
  FDRE \instruction_reg_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[25]),
        .Q(Q[25]),
        .R(rst));
  FDRE \instruction_reg_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[26]),
        .Q(Q[26]),
        .R(rst));
  FDRE \instruction_reg_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[27]),
        .Q(Q[27]),
        .R(rst));
  FDRE \instruction_reg_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[28]),
        .Q(Q[28]),
        .R(rst));
  FDRE \instruction_reg_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[29]),
        .Q(Q[29]),
        .R(rst));
  FDRE \instruction_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[2]),
        .Q(Q[2]),
        .R(rst));
  FDRE \instruction_reg_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[30]),
        .Q(Q[30]),
        .R(rst));
  FDRE \instruction_reg_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[31]),
        .Q(Q[31]),
        .R(rst));
  FDRE \instruction_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[3]),
        .Q(Q[3]),
        .R(rst));
  FDRE \instruction_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[4]),
        .Q(Q[4]),
        .R(rst));
  FDRE \instruction_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[5]),
        .Q(Q[5]),
        .R(rst));
  FDRE \instruction_reg_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[6]),
        .Q(Q[6]),
        .R(rst));
  FDRE \instruction_reg_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[7]),
        .Q(Q[7]),
        .R(rst));
  FDRE \instruction_reg_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[8]),
        .Q(Q[8]),
        .R(rst));
  FDRE \instruction_reg_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(instruction[9]),
        .Q(Q[9]),
        .R(rst));
endmodule

(* CHECK_LICENSE_TYPE = "fetch_test_Decoder_0_0,Decoder,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Decoder,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    rst,
    instruction,
    opcode,
    rd,
    rs1,
    rs2,
    funct3,
    funct7);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input [31:0]instruction;
  output [6:0]opcode;
  output [4:0]rd;
  output [4:0]rs1;
  output [4:0]rs2;
  output [2:0]funct3;
  output [6:0]funct7;

  wire clk;
  wire [2:0]funct3;
  wire [6:0]funct7;
  wire [31:0]instruction;
  wire [6:0]opcode;
  wire [4:0]rd;
  wire [4:0]rs1;
  wire [4:0]rs2;
  wire rst;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder inst
       (.Q({funct7,rs2,rs1,funct3,rd,opcode}),
        .clk(clk),
        .instruction(instruction),
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
