// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 11:15:15 2025
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
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
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
