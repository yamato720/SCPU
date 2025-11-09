// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 11:11:25 2025
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
  wire clkb;
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
  (* C_COMMON_CLK = "0" *) 
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
        .clkb(clkb),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28432)
`pragma protect data_block
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
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
