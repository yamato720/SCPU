-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Nov  5 17:08:45 2025
-- Host        : Plana running 64-bit Arch Linux
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ins_fetch_Ins_buffer_0_0_sim_netlist.vhdl
-- Design      : ins_fetch_Ins_buffer_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer is
  port (
    ins_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    rst : in STD_LOGIC;
    clk : in STD_LOGIC;
    pc_in : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer is
  signal \ins_out1_carry__0_n_1\ : STD_LOGIC;
  signal \ins_out1_carry__0_n_2\ : STD_LOGIC;
  signal \ins_out1_carry__0_n_3\ : STD_LOGIC;
  signal \ins_out1_carry__0_n_4\ : STD_LOGIC;
  signal \ins_out1_carry_i_1__0_n_0\ : STD_LOGIC;
  signal ins_out1_carry_i_1_n_0 : STD_LOGIC;
  signal \ins_out1_carry_i_2__0_n_0\ : STD_LOGIC;
  signal ins_out1_carry_i_2_n_0 : STD_LOGIC;
  signal \ins_out1_carry_i_3__0_n_0\ : STD_LOGIC;
  signal ins_out1_carry_i_3_n_0 : STD_LOGIC;
  signal \ins_out1_carry_i_4__0_n_0\ : STD_LOGIC;
  signal ins_out1_carry_i_4_n_0 : STD_LOGIC;
  signal ins_out1_carry_n_0 : STD_LOGIC;
  signal ins_out1_carry_n_1 : STD_LOGIC;
  signal ins_out1_carry_n_2 : STD_LOGIC;
  signal ins_out1_carry_n_3 : STD_LOGIC;
  signal ins_out1_carry_n_4 : STD_LOGIC;
  signal ins_out1_carry_n_5 : STD_LOGIC;
  signal ins_out1_carry_n_6 : STD_LOGIC;
  signal ins_out1_carry_n_7 : STD_LOGIC;
  signal \ins_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \ins_out[28]_i_1_n_0\ : STD_LOGIC;
  signal \ins_out[29]_i_1_n_0\ : STD_LOGIC;
  signal \ins_out[30]_i_1_n_0\ : STD_LOGIC;
  signal \ins_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \NLW_ins_out1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_ins_out1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of ins_out1_carry : label is 35;
  attribute ADDER_THRESHOLD of \ins_out1_carry__0\ : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ins_out[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ins_out[4]_i_1\ : label is "soft_lutpair0";
begin
ins_out1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ins_out1_carry_n_0,
      CO(2) => ins_out1_carry_n_1,
      CO(1) => ins_out1_carry_n_2,
      CO(0) => ins_out1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => pc_in(3 downto 0),
      O(3) => ins_out1_carry_n_4,
      O(2) => ins_out1_carry_n_5,
      O(1) => ins_out1_carry_n_6,
      O(0) => ins_out1_carry_n_7,
      S(3) => ins_out1_carry_i_1_n_0,
      S(2) => \ins_out1_carry_i_2__0_n_0\,
      S(1) => \ins_out1_carry_i_3__0_n_0\,
      S(0) => \ins_out1_carry_i_4__0_n_0\
    );
\ins_out1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => ins_out1_carry_n_0,
      CO(3) => \NLW_ins_out1_carry__0_CO_UNCONNECTED\(3),
      CO(2) => \ins_out1_carry__0_n_1\,
      CO(1) => \ins_out1_carry__0_n_2\,
      CO(0) => \ins_out1_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => pc_in(6 downto 4),
      O(3) => \ins_out1_carry__0_n_4\,
      O(2 downto 0) => \NLW_ins_out1_carry__0_O_UNCONNECTED\(2 downto 0),
      S(3) => \ins_out1_carry_i_1__0_n_0\,
      S(2) => ins_out1_carry_i_2_n_0,
      S(1) => ins_out1_carry_i_3_n_0,
      S(0) => ins_out1_carry_i_4_n_0
    );
ins_out1_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(3),
      O => ins_out1_carry_i_1_n_0
    );
\ins_out1_carry_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(7),
      O => \ins_out1_carry_i_1__0_n_0\
    );
ins_out1_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(6),
      O => ins_out1_carry_i_2_n_0
    );
\ins_out1_carry_i_2__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(2),
      O => \ins_out1_carry_i_2__0_n_0\
    );
ins_out1_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(5),
      O => ins_out1_carry_i_3_n_0
    );
\ins_out1_carry_i_3__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(1),
      O => \ins_out1_carry_i_3__0_n_0\
    );
ins_out1_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(4),
      O => ins_out1_carry_i_4_n_0
    );
\ins_out1_carry_i_4__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pc_in(0),
      O => \ins_out1_carry_i_4__0_n_0\
    );
\ins_out[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
        port map (
      I0 => \ins_out1_carry__0_n_4\,
      I1 => ins_out1_carry_n_4,
      I2 => ins_out1_carry_n_6,
      I3 => rst,
      O => \ins_out[1]_i_1_n_0\
    );
\ins_out[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000444"
    )
        port map (
      I0 => ins_out1_carry_n_4,
      I1 => ins_out1_carry_n_7,
      I2 => ins_out1_carry_n_5,
      I3 => ins_out1_carry_n_6,
      I4 => \ins_out1_carry__0_n_4\,
      I5 => rst,
      O => \ins_out[28]_i_1_n_0\
    );
\ins_out[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000444"
    )
        port map (
      I0 => ins_out1_carry_n_4,
      I1 => ins_out1_carry_n_6,
      I2 => ins_out1_carry_n_7,
      I3 => ins_out1_carry_n_5,
      I4 => \ins_out1_carry__0_n_4\,
      I5 => rst,
      O => \ins_out[29]_i_1_n_0\
    );
\ins_out[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000070"
    )
        port map (
      I0 => ins_out1_carry_n_6,
      I1 => ins_out1_carry_n_7,
      I2 => ins_out1_carry_n_5,
      I3 => \ins_out1_carry__0_n_4\,
      I4 => rst,
      O => \ins_out[30]_i_1_n_0\
    );
\ins_out[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
        port map (
      I0 => \ins_out1_carry__0_n_4\,
      I1 => ins_out1_carry_n_4,
      I2 => ins_out1_carry_n_7,
      I3 => rst,
      O => \ins_out[4]_i_1_n_0\
    );
\ins_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ins_out[1]_i_1_n_0\,
      Q => ins_out(0),
      R => '0'
    );
\ins_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ins_out[28]_i_1_n_0\,
      Q => ins_out(2),
      R => '0'
    );
\ins_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ins_out[29]_i_1_n_0\,
      Q => ins_out(3),
      R => '0'
    );
\ins_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ins_out[30]_i_1_n_0\,
      Q => ins_out(4),
      R => '0'
    );
\ins_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \ins_out[4]_i_1_n_0\,
      Q => ins_out(1),
      R => '0'
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
    pc_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    base_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ins_out : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "ins_fetch_Ins_buffer_0_0,Ins_buffer,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "Ins_buffer,Vivado 2022.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal \^ins_out\ : STD_LOGIC_VECTOR ( 26 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  ins_out(31) <= \<const0>\;
  ins_out(30 downto 28) <= \^ins_out\(26 downto 24);
  ins_out(27) <= \<const0>\;
  ins_out(26 downto 24) <= \^ins_out\(26 downto 24);
  ins_out(23) <= \<const0>\;
  ins_out(22 downto 20) <= \^ins_out\(26 downto 24);
  ins_out(19) <= \<const0>\;
  ins_out(18 downto 16) <= \^ins_out\(26 downto 24);
  ins_out(15) <= \<const0>\;
  ins_out(14 downto 12) <= \^ins_out\(26 downto 24);
  ins_out(11) <= \<const0>\;
  ins_out(10 downto 8) <= \^ins_out\(26 downto 24);
  ins_out(7) <= \<const0>\;
  ins_out(6 downto 5) <= \^ins_out\(26 downto 25);
  ins_out(4) <= \^ins_out\(0);
  ins_out(3) <= \<const0>\;
  ins_out(2) <= \^ins_out\(26);
  ins_out(1 downto 0) <= \^ins_out\(1 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Ins_buffer
     port map (
      clk => clk,
      ins_out(4 downto 2) => \^ins_out\(26 downto 24),
      ins_out(1) => \^ins_out\(0),
      ins_out(0) => \^ins_out\(1),
      pc_in(7 downto 0) => pc_in(7 downto 0),
      rst => rst
    );
end STRUCTURE;
