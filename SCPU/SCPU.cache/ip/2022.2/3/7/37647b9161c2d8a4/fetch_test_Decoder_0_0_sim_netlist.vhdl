-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Nov  5 16:02:12 2025
-- Host        : Plana running 64-bit Arch Linux
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ fetch_test_Decoder_0_0_sim_netlist.vhdl
-- Design      : fetch_test_Decoder_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder is
  port (
    Q : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rst : in STD_LOGIC;
    instruction : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder is
begin
\instruction_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(0),
      Q => Q(0),
      R => rst
    );
\instruction_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(10),
      Q => Q(10),
      R => rst
    );
\instruction_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(11),
      Q => Q(11),
      R => rst
    );
\instruction_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(12),
      Q => Q(12),
      R => rst
    );
\instruction_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(13),
      Q => Q(13),
      R => rst
    );
\instruction_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(14),
      Q => Q(14),
      R => rst
    );
\instruction_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(15),
      Q => Q(15),
      R => rst
    );
\instruction_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(16),
      Q => Q(16),
      R => rst
    );
\instruction_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(17),
      Q => Q(17),
      R => rst
    );
\instruction_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(18),
      Q => Q(18),
      R => rst
    );
\instruction_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(19),
      Q => Q(19),
      R => rst
    );
\instruction_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(1),
      Q => Q(1),
      R => rst
    );
\instruction_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(20),
      Q => Q(20),
      R => rst
    );
\instruction_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(21),
      Q => Q(21),
      R => rst
    );
\instruction_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(22),
      Q => Q(22),
      R => rst
    );
\instruction_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(23),
      Q => Q(23),
      R => rst
    );
\instruction_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(24),
      Q => Q(24),
      R => rst
    );
\instruction_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(25),
      Q => Q(25),
      R => rst
    );
\instruction_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(26),
      Q => Q(26),
      R => rst
    );
\instruction_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(27),
      Q => Q(27),
      R => rst
    );
\instruction_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(28),
      Q => Q(28),
      R => rst
    );
\instruction_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(29),
      Q => Q(29),
      R => rst
    );
\instruction_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(2),
      Q => Q(2),
      R => rst
    );
\instruction_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(30),
      Q => Q(30),
      R => rst
    );
\instruction_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(31),
      Q => Q(31),
      R => rst
    );
\instruction_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(3),
      Q => Q(3),
      R => rst
    );
\instruction_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(4),
      Q => Q(4),
      R => rst
    );
\instruction_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(5),
      Q => Q(5),
      R => rst
    );
\instruction_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(6),
      Q => Q(6),
      R => rst
    );
\instruction_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(7),
      Q => Q(7),
      R => rst
    );
\instruction_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(8),
      Q => Q(8),
      R => rst
    );
\instruction_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => instruction(9),
      Q => Q(9),
      R => rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    instruction : in STD_LOGIC_VECTOR ( 31 downto 0 );
    opcode : out STD_LOGIC_VECTOR ( 6 downto 0 );
    rd : out STD_LOGIC_VECTOR ( 4 downto 0 );
    rs1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    rs2 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    funct3 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    funct7 : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "fetch_test_Decoder_0_0,Decoder,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "Decoder,Vivado 2022.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Decoder
     port map (
      Q(31 downto 25) => funct7(6 downto 0),
      Q(24 downto 20) => rs2(4 downto 0),
      Q(19 downto 15) => rs1(4 downto 0),
      Q(14 downto 12) => funct3(2 downto 0),
      Q(11 downto 7) => rd(4 downto 0),
      Q(6 downto 0) => opcode(6 downto 0),
      clk => clk,
      instruction(31 downto 0) => instruction(31 downto 0),
      rst => rst
    );
end STRUCTURE;
