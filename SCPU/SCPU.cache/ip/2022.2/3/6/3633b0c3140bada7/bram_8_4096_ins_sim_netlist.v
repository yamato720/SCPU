// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov  7 08:58:06 2025
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
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
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
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.535699 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
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
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
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
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 26464)
`pragma protect data_block
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
zN33Ad2PS61knu9jdqAvGw==
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
