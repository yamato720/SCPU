// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 11:00:14 2025
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
gz3rLDJTR4yJe6/VQikZHJ/lMzQt5mAahQMD
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
