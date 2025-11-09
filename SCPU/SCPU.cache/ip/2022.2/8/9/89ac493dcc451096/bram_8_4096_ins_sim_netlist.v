// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 09:05:53 2025
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
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27408)
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
