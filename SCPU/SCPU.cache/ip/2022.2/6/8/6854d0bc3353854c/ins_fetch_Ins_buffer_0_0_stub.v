// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Nov  5 18:32:49 2025
// Host        : Plana running 64-bit Arch Linux
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ins_fetch_Ins_buffer_0_0_stub.v
// Design      : ins_fetch_Ins_buffer_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Ins_buffer,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, rst, pc_in, base_in, ins_out)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,pc_in[31:0],base_in[31:0],ins_out[31:0]" */;
  input clk;
  input rst;
  input [31:0]pc_in;
  input [31:0]base_in;
  output [31:0]ins_out;
endmodule
