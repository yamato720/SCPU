// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Nov  5 14:38:21 2025
// Host        : Plana running 64-bit Arch Linux
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fetch_test_Decoder_0_0_stub.v
// Design      : fetch_test_Decoder_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Decoder,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, instruction, pc, opcode, rd, rs1, rs2, funct3, 
  funct7)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,instruction[31:0],pc[31:0],opcode[6:0],rd[4:0],rs1[4:0],rs2[4:0],funct3[2:0],funct7[6:0]" */;
  input clk;
  input rst;
  input [31:0]instruction;
  input [31:0]pc;
  output [6:0]opcode;
  output [4:0]rd;
  output [4:0]rs1;
  output [4:0]rs2;
  output [2:0]funct3;
  output [6:0]funct7;
endmodule
