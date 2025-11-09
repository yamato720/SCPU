// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 10:06:10 2025
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
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
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
  wire [7:0]NLW_U0_douta_UNCONNECTED;
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.53475 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
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
  (* C_MEM_TYPE = "1" *) 
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
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
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
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27424)
`pragma protect data_block
+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
yGmFCsS9mg==
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
