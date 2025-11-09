// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 10:56:05 2025
// Host        : Plana running 64-bit Arch Linux
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bram_8_4096_ins_sim_netlist.v
// Design      : bram_8_4096_ins
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bram_8_4096_ins,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire [7:0]dina;
  wire [7:0]dinb;
  wire [7:0]douta;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.74405 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "bram_8_4096_ins.mem" *) 
  (* C_INIT_FILE_NAME = "bram_8_4096_ins.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28128)
`pragma protect data_block
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
jjT0uGaYIovBghvcDz88t1E51QHny2wkAm62
`pragma protect end_protected
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
