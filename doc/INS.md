# RISC-V RV32I 指令集说明

## 指令格式总览
![alt text](../image/insFormation.png)

RISC-V 使用多种指令格式来编码不同类型的指令。所有指令都是 32 位宽。

```
R-type:  [funct7:7] [rs2:5] [rs1:5] [funct3:3] [rd:5] [opcode:7]
I-type:  [imm[11:0]:12] [rs1:5] [funct3:3] [rd:5] [opcode:7]
S-type:  [imm[11:5]:7] [rs2:5] [rs1:5] [funct3:3] [imm[4:0]:5] [opcode:7]
B-type:  [imm[12|10:5]:7] [rs2:5] [rs1:5] [funct3:3] [imm[4:1|11]:5] [opcode:7]
U-type:  [imm[31:12]:20] [rd:5] [opcode:7]
J-type:  [imm[20|10:1|11|19:12]:20] [rd:5] [opcode:7]
```

## R-Type 指令（寄存器-寄存器操作）

### 算术和逻辑运算

| 指令  | funct7 | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|--------|------|------|
| ADD   | 0000000 | 000 | 0110011 | rd = rs1 + rs2 | add x1, x2, x3 |
| SUB   | 0100000 | 000 | 0110011 | rd = rs1 - rs2 | sub x1, x2, x3 |
| AND   | 0000000 | 111 | 0110011 | rd = rs1 & rs2 | and x1, x2, x3 |
| OR    | 0000000 | 110 | 0110011 | rd = rs1 \| rs2 | or x1, x2, x3 |
| XOR   | 0000000 | 100 | 0110011 | rd = rs1 ^ rs2 | xor x1, x2, x3 |
| SLL   | 0000000 | 001 | 0110011 | rd = rs1 << rs2[4:0] | sll x1, x2, x3 |
| SRL   | 0000000 | 101 | 0110011 | rd = rs1 >> rs2[4:0] (逻辑右移) | srl x1, x2, x3 |
| SRA   | 0100000 | 101 | 0110011 | rd = rs1 >> rs2[4:0] (算术右移) | sra x1, x2, x3 |
| SLT   | 0000000 | 010 | 0110011 | rd = (rs1 < rs2) ? 1 : 0 (有符号) | slt x1, x2, x3 |
| SLTU  | 0000000 | 011 | 0110011 | rd = (rs1 < rs2) ? 1 : 0 (无符号) | sltu x1, x2, x3 |

**编码格式**:
```
31      25 24   20 19   15 14  12 11    7 6      0
[funct7:7] [rs2:5] [rs1:5] [f3:3] [rd:5] [opcode:7]
```

**注意事项**:
- R-type 指令的 opcode 统一为 `0110011`
- ADD 和 SUB 的区别仅在 funct7[5] 位 (0 表示 ADD, 1 表示 SUB)
- SRL 和 SRA 的区别也在 funct7[5] 位 (0 表示逻辑右移, 1 表示算术右移)
- 移位指令只使用 rs2 的低 5 位 [4:0] 作为移位量
- x0 恒为 0（硬件固定），对 x0 的写入将被忽略

## I-Type 指令（立即数操作）

### 算术和逻辑立即数指令

| 指令  | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|------|------|
| ADDI  | 000 | 0010011 | rd = rs1 + imm | addi x1, x2, 100 |
| ANDI  | 111 | 0010011 | rd = rs1 & imm | andi x1, x2, 0xFF |
| ORI   | 110 | 0010011 | rd = rs1 \| imm | ori x1, x2, 0x10 |
| XORI  | 100 | 0010011 | rd = rs1 ^ imm | xori x1, x2, -1 |
| SLTI  | 010 | 0010011 | rd = (rs1 < imm) ? 1 : 0 (有符号) | slti x1, x2, 10 |
| SLTIU | 011 | 0010011 | rd = (rs1 < imm) ? 1 : 0 (无符号) | sltiu x1, x2, 10 |
| SLLI  | 001 | 0010011 | rd = rs1 << imm[4:0] | slli x1, x2, 5 |
| SRLI  | 101 | 0010011 | rd = rs1 >> imm[4:0] (逻辑右移) | srli x1, x2, 5 |
| SRAI  | 101 | 0010011 | rd = rs1 >> imm[4:0] (算术右移) | srai x1, x2, 5 |

**编码格式**:
```
31          20 19   15 14  12 11    7 6      0
[imm[11:0]:12] [rs1:5] [f3:3] [rd:5] [opcode:7]
```

**注意事项**:
- I-type 算术指令的 opcode 为 `0010011`
- 立即数范围: -2048 到 2047 (12 位有符号)
- SLLI/SRLI/SRAI 的立即数 imm[11:5] 有特殊含义:
  - SLLI/SRLI: imm[11:5] = 0000000
  - SRAI: imm[11:5] = 0100000 (与 SRA 的 funct7 一致)
- NOP 指令通常编码为 `ADDI x0, x0, 0` (0x00000013)

### Load 指令

| 指令  | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|------|------|
| LB    | 000 | 0000011 | rd = sign_ext(MEM[rs1+imm][7:0]) | lb x1, 4(x2) |
| LH    | 001 | 0000011 | rd = sign_ext(MEM[rs1+imm][15:0]) | lh x1, 4(x2) |
| LW    | 010 | 0000011 | rd = MEM[rs1+imm][31:0] | lw x1, 4(x2) |
| LBU   | 100 | 0000011 | rd = zero_ext(MEM[rs1+imm][7:0]) | lbu x1, 4(x2) |
| LHU   | 101 | 0000011 | rd = zero_ext(MEM[rs1+imm][15:0]) | lhu x1, 4(x2) |

**编码格式**:
```
31          20 19   15 14  12 11    7 6      0
[imm[11:0]:12] [rs1:5] [f3:3] [rd:5] [opcode:7]
```

**注意事项**:
- Load 指令的 opcode 为 `0000011`
- 地址 = rs1 + sign_ext(imm)
- LB/LH 执行符号扩展，LBU/LHU 执行零扩展
- 偏移量范围: -2048 到 2047

### Jump and Link Register

| 指令  | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|------|------|
| JALR  | 000 | 1100111 | rd = PC+4; PC = (rs1+imm) & ~1 | jalr x1, 8(x2) |

**注意事项**:
- JALR 的 opcode 为 `1100111`
- 返回地址 (PC+4) 保存到 rd
- 目标地址 = (rs1 + sign_ext(imm)) & 0xFFFFFFFE (最低位清零)
- 常用于函数返回: `jalr x0, 0(x1)` 或简写 `ret`

## S-Type 指令（Store 存储）

| 指令  | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|------|------|
| SB    | 000 | 0100011 | MEM[rs1+imm][7:0] = rs2[7:0] | sb x2, 4(x1) |
| SH    | 001 | 0100011 | MEM[rs1+imm][15:0] = rs2[15:0] | sh x2, 4(x1) |
| SW    | 010 | 0100011 | MEM[rs1+imm][31:0] = rs2[31:0] | sw x2, 4(x1) |

**编码格式**:
```
31      25 24   20 19   15 14  12 11    7 6      0
[imm[11:5]:7] [rs2:5] [rs1:5] [f3:3] [imm[4:0]:5] [opcode:7]
```

**注意事项**:
- Store 指令的 opcode 为 `0100011`
- 地址 = rs1 + sign_ext(imm[11:0])
- 立即数分为两部分: imm[11:5] 和 imm[4:0]
- 偏移量范围: -2048 到 2047
- SB 存储 1 字节，SH 存储 2 字节，SW 存储 4 字节

## B-Type 指令（条件分支）

| 指令  | funct3 | opcode | 操作 | 示例 |
|-------|--------|--------|------|------|
| BEQ   | 000 | 1100011 | if (rs1 == rs2) PC += imm | beq x1, x2, label |
| BNE   | 001 | 1100011 | if (rs1 != rs2) PC += imm | bne x1, x2, label |
| BLT   | 100 | 1100011 | if (rs1 < rs2) PC += imm (有符号) | blt x1, x2, label |
| BGE   | 101 | 1100011 | if (rs1 >= rs2) PC += imm (有符号) | bge x1, x2, label |
| BLTU  | 110 | 1100011 | if (rs1 < rs2) PC += imm (无符号) | bltu x1, x2, label |
| BGEU  | 111 | 1100011 | if (rs1 >= rs2) PC += imm (无符号) | bgeu x1, x2, label |

**编码格式**:
```
31          25 24   20 19   15 14  12 11          7 6      0
[imm[12|10:5]:7] [rs2:5] [rs1:5] [f3:3] [imm[4:1|11]:5] [opcode:7]
```

**注意事项**:
- Branch 指令的 opcode 为 `1100011`
- 立即数编码: imm[12:1] (imm[0] 恒为 0，保证 2 字节对齐)
- 完整立即数重构: {imm[12], imm[10:5], imm[4:1], imm[11], 0}
- 偏移量范围: -4096 到 4094 (13 位，2 字节对齐)
- 条件满足时: PC = PC + sign_ext(imm)
- 条件不满足时: PC = PC + 4

## U-Type 指令（高位立即数）

| 指令  | opcode | 操作 | 示例 |
|-------|--------|------|------|
| LUI   | 0110111 | rd = imm << 12 | lui x1, 0x12345 |
| AUIPC | 0010111 | rd = PC + (imm << 12) | auipc x1, 0x12345 |

**编码格式**:
```
31          12 11    7 6      0
[imm[31:12]:20] [rd:5] [opcode:7]
```

**注意事项**:
- LUI (Load Upper Immediate): 将 20 位立即数加载到 rd 的高 20 位，低 12 位清零
  - LUI opcode: `0110111`
  - rd = imm[31:12] << 12 = {imm[31:12], 12'b0}
- AUIPC (Add Upper Immediate to PC): PC 加上 20 位立即数左移 12 位
  - AUIPC opcode: `0010111`
  - rd = PC + (imm[31:12] << 12)
  - 常用于 PC 相对寻址

**组合使用**:
- 加载 32 位立即数: `LUI x1, upper20` + `ADDI x1, x1, lower12`
- PC 相对寻址: `AUIPC x1, upper20` + `ADDI x1, x1, lower12`

## J-Type 指令（无条件跳转）

| 指令  | opcode | 操作 | 示例 |
|-------|--------|------|------|
| JAL   | 1101111 | rd = PC+4; PC += imm | jal x1, label |

**编码格式**:
```
31                    12 11    7 6      0
[imm[20|10:1|11|19:12]:20] [rd:5] [opcode:7]
```

**注意事项**:
- JAL (Jump and Link) opcode: `1101111`
- 立即数编码: {imm[20], imm[10:1], imm[11], imm[19:12]} (imm[0] 恒为 0)
- 完整立即数重构: {imm[20], imm[19:12], imm[11], imm[10:1], 0}
- 偏移量范围: -1048576 到 1048574 (21 位，2 字节对齐)
- rd = PC + 4 (返回地址)
- PC = PC + sign_ext(imm)
- 常用于函数调用: `jal x1, function` 或 `jal ra, function`

## RISC-V NOP 指令

NOP（No Operation）指令在 RISC-V 中通常是 `ADDI x0, x0, 0`，即 I-type 指令，不改变任何状态。

| 指令 | opcode | funct3 | imm[11:0] | rs1 | rd | 编码 | 语义 |
|------|--------|--------|-----------|-----|----|------|------|
| NOP  | 0010011 | 000 | 000000000000 | 00000 | 00000 | 0x00000013 | x0 = x0 + 0 |

**替代编码（R-type NOP）**:

| 指令 | opcode | funct3 | funct7 | rs2 | rs1 | rd | 编码 | 语义 |
|------|--------|--------|--------|--------|-----|----|------|------|
| NOP  | 0110011 | 000 | 0000000 | 00000 | 00000 | 00000 | 0x00000033 | x0 = x0 + x0 |

## 控制信号表

### Opcode 控制信号

| 指令类型 | opcode  | aluop | alu_src | mem_read | mem_write | mem2reg | reg_write | branch | jump |
|---------|---------|-------|---------|----------|-----------|---------|-----------|--------|------|
| R-type  | 0110011 | 10    | 0       | 0        | 0         | 0       | 1         | 0      | 0    |
| I-type  | 0010011 | 11    | 1       | 0        | 0         | 0       | 1         | 0      | 0    |
| Load    | 0000011 | 00    | 1       | 1        | 0         | 1       | 1         | 0      | 0    |
| Store   | 0100011 | 00    | 1       | 0        | 1         | 0       | 0         | 0      | 0    |
| Branch  | 1100011 | 01    | 0       | 0        | 0         | 0       | 0         | 1      | 0    |
| JAL     | 1101111 | XX    | X       | 0        | 0         | 0       | 1         | 0      | 1    |
| JALR    | 1100111 | 00    | 1       | 0        | 0         | 0       | 1         | 0      | 1    |
| LUI     | 0110111 | XX    | 1       | 0        | 0         | 0       | 1         | 0      | 0    |
| AUIPC   | 0010111 | 00    | 1       | 0        | 0         | 0       | 1         | 0      | 0    |

### ALU 控制码

| ALUOp[1:0] | funct7[5] | funct3[2:0] | ALU_control[3:0] | 操作 |
|------------|-----------|-------------|------------------|------|
| 00         | X         | XXX         | 0000             | ADD (地址计算) |
| 01         | X         | XXX         | 0001             | SUB (分支比较) |
| 10         | 0         | 000         | 0000             | ADD |
| 10         | 1         | 000         | 0001             | SUB |
| 10         | X         | 111         | 0011             | AND |
| 10         | X         | 110         | 0100             | OR |
| 10         | X         | 100         | 0101             | XOR |
| 10         | X         | 010         | 0110             | SLT |
| 10         | X         | 011         | 0111             | SLTU |
| 10         | 0         | 001         | 1000             | SLL |
| 10         | 0         | 101         | 1001             | SRL |
| 10         | 1         | 101         | 1010             | SRA |
| 11         | (同 10)   | (同 10)     | (同 10)          | I-type 算术 |

**注意**:
- ALUOp 由主控制器根据 opcode 产生
  - 00: Load/Store (地址计算用 ADD)
  - 01: Branch (比较用 SUB)
  - 10: R-type (根据 funct7/funct3 选择)
  - 11: I-type 算术 (根据 funct3 选择，与 R-type 相同)
- X 表示"不关心"

## 立即数扩展规则

| 指令类型 | 立即数位宽 | 扩展方式 | 重构规则 |
|---------|-----------|---------|---------|
| I-type  | 12 位     | 符号扩展 | imm[11:0] |
| S-type  | 12 位     | 符号扩展 | {imm[11:5], imm[4:0]} |
| B-type  | 13 位     | 符号扩展 | {imm[12], imm[10:5], imm[4:1], imm[11], 1'b0} |
| U-type  | 20 位     | 无需扩展 | {imm[31:12], 12'b0} |
| J-type  | 21 位     | 符号扩展 | {imm[20], imm[19:12], imm[11], imm[10:1], 1'b0} |

## 测试覆盖率

### 已测试指令

#### R-Type 测试 (R-TypeTest.md)
- ✅ ADD, SUB, AND, OR, XOR
- ✅ SLL, SRL, SRA
- ✅ SLT, SLTU

#### I-Type 测试 (LoadStoreTest.md + R-TypeTest.md)
- ✅ ADDI (多次使用)
- ✅ LB, LBU (符号扩展和零扩展)
- ✅ LH, LHU (符号扩展和零扩展)
- ✅ LW

#### S-Type 测试 (LoadStoreTest.md)
- ✅ SB, SH, SW (多种数据宽度)

#### B-Type 测试 (BranchTest.md)
- ✅ BEQ, BNE (相等和不等分支)
- ✅ BLT, BGE (有符号比较)
- ✅ BLTU, BGEU (无符号比较)

#### U-Type 测试 (LoadStoreTest.md)
- ✅ LUI (加载高位立即数)
- ✅ AUIPC (PC 相对寻址)

#### J-Type 测试 (BranchTest.md)
- ✅ JAL, JALR (无条件跳转和链接)

### 测试说明
- **R-TypeTest.md**: 19 条 R-type 指令的完整测试，包括算术、逻辑、移位、比较操作
- **BranchTest.md**: 8 条跳转和分支指令的完整测试，包括条件分支和无条件跳转
- **LoadStoreTest.md**: 完整的 Load/Store 测试，包括不同数据宽度、符号扩展、零扩展、边界值测试

## 相关文件

1. **rtl/ALU.v**: 算术逻辑单元，执行各种运算操作
2. **rtl/ALU_ctrl.v**: ALU 控制器，根据 ALUOp 和 funct 字段生成 ALU 控制信号
3. **rtl/Opcode_ctrl.v**: 主控制器，根据 opcode 生成控制信号
4. **rtl/ImmGenerator.v**: 立即数生成器，处理 I/S/B/U/J-type 立即数扩展
5. **rtl/Registers.v**: 寄存器文件，32 个通用寄存器
6. **rtl/DataMemory.v**: 数据内存模块，支持 Load/Store 操作
7. **rtl/PC_ctrl.v**: PC 控制器，处理分支和跳转

## 参考资料

- RISC-V Instruction Set Manual Volume I: Unprivileged ISA
- RISC-V 官方规范: https://riscv.org/specifications/

