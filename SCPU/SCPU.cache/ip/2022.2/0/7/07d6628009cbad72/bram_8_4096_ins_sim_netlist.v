// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 10:14:40 2025
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
  (* C_USE_DEFAULT_DATA = "0" *) 
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
DpooxE3O4hrE1lNLtU2cT2K0O0V5n23t3J1U
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
