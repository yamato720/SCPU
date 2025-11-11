# RISC-V Load/Store 完整测试指令说明

## 测试环境配置

### 寄存器初始值 (通过 ADDI/AUIPC/LUI 设置)
| 寄存器 | 初始值 (十进制) | 初始值 (十六进制) | 用途说明 |
|--------|----------------|-------------------|----------|
| x0     | 0              | 0x00000000        | 恒为 0 (硬件固定) |
| x1     | 200            | 0x000000C8        | 基地址指针 |
| x2     | 127            | 0x0000007F        | 测试 byte: 最大正数 |
| x3     | -128           | 0xFFFFFF80        | 测试 byte: 最小负数 |
| x4     | 255            | 0x000000FF        | 测试 byte unsigned: 最大值 |
| x5     | 27767          | 0x00006C77        | 测试 half: 中间值 (AUIPC+ADDI) |
| x6     | -32768         | 0xFFFF8000        | 测试 half: 最小负数 (LUI) |
| x7     | 65535          | 0x0000FFFF        | 测试 half unsigned: 最大值 (AUIPC+ADDI) |
| x8     | 1024           | 0x00000400        | 测试 word |
| x9     | -1             | 0xFFFFFFFF        | 测试 word: 全 1 |
| x10-x31| -              | -                 | 用于存储加载结果 |

### 内存布局 (基地址 = 200)
| 地址 | 初始内容   | Store 后内容 | 说明 |
|------|-----------|-------------|------|
| 200  | 0x00000000| 0x0000007F  | SB x2, 0(x1) - byte |
| 201  | 0x00000000| 0x00000080  | SB x3, 1(x1) - byte (负数) |
| 202  | 0x00000000| 0x000000FF  | SB x4, 2(x1) - byte unsigned |
| 204  | 0x00000000| 0x00006C77  | SH x5, 4(x1) - halfword (27767) |
| 206  | 0x00000000| 0x00008000  | SH x6, 6(x1) - halfword (-32768) |
| 210  | 0x00000000| 0x0000FFFF  | SH x7, 10(x1) - halfword (65535) |
| 212  | 0x00000000| 0x00000400  | SW x8, 12(x1) - word |
| 216  | 0x00000000| 0xFFFFFFFF  | SW x9, 16(x1) - word (全1) |

## 完整指令编码列表 (便于 BRAM 初始化)


|地址 | 指令编码     | 汇编指令                    | 说明|
|-----|-------------|----------------------------|------|
|0x00 | 0x0C800093  | ADDI x1, x0, 200           | 基地址 = 200|
|0x04 | 0x07F00113  | ADDI x2, x0, 127           | x2 = 127 (byte 最大正)|
|0x08 | 0xF8000193  | ADDI x3, x0, -128          | x3 = -128 (byte 最小负)|
|0x0C | 0x0FF00213  | ADDI x4, x0, 255           | x4 = 255 (byte unsigned 最大)|
|0x10 | 0x00007297  | AUIPC x5, 0x00007          | x5 = PC + 0x7000 = 0x10 + 0x7000 = 0x7010 = 28688|
|0x14 | 0xC6728293  | ADDI x5, x5, -921          | x5 = 28688 - 921 = 27767 (0x6C77)|
|0x18 | 0xFFFF8337  | LUI  x6, 0xFFFF8           | x6 = 0xFFFF8000 = -32768|
|0x1C | 0x00010397  | AUIPC x7, 0x00010          | x7 = PC + 0x10000 = 0x1C + 0x10000 = 0x1001C = 65564|
|0x20 | 0xFE338393  | ADDI x7, x7, -29           | x7 = 65564 - 29 = 65535 (0xFFFF)|
|0x24 | 0x40000413  | ADDI x8, x0, 1024          | x8 = 1024|
|0x28 | 0xFFF00493  | ADDI x9, x0, -1            | x9 = -1|
|0x2C | 0x00208023  | SB   x2, 0(x1)             | MEM[200] = 0x7F|
|0x30 | 0x003080A3  | SB   x3, 1(x1)             | MEM[201] = 0x80|
|0x34 | 0x00408123  | SB   x4, 2(x1)             | MEM[202] = 0xFF|
|0x38 | 0x00509223  | SH   x5, 4(x1)             | MEM[204-205] = 0x6C77|
|0x3C | 0x00609323  | SH   x6, 6(x1)             | MEM[206-207] = 0x8000|
|0x40 | 0x00709523  | SH   x7, 10(x1)            | MEM[210-211] = 0xFFFF|
|0x44 | 0x0080A623  | SW   x8, 12(x1)            | MEM[212-215] = 0x00000400|
|0x48 | 0x0090A823  | SW   x9, 16(x1)            | MEM[216-219] = 0xFFFFFFFF|
|0x4C | 0x00008503  | LB   x10, 0(x1)            | x10 = 127 (signed ext)|
|0x50 | 0x00108583  | LB   x11, 1(x1)            | x11 = -128 (signed ext)|
|0x54 | 0x0020C603  | LBU  x12, 2(x1)            | x12 = 255 (zero ext)|
|0x58 | 0x00409683  | LH   x13, 4(x1)            | x13 = 27767 (signed ext)|
|0x5C | 0x00609703  | LH   x14, 6(x1)            | x14 = -32768 (signed ext)|
|0x60 | 0x00A0D783  | LHU  x15, 10(x1)           | x15 = 65535 (zero ext)|
|0x64 | 0x00C0A803  | LW   x16, 12(x1)           | x16 = 1024|
|0x68 | 0x0100A883  | LW   x17, 16(x1)           | x17 = -1|
|0x6C | 0x00000013  | NOP                        | 结束|

## 测试说明

### 初始化阶段（指令0-10，共11条）
- 使用 ADDI 指令设置基地址 x1=200 和小数值
  - x1: 基地址 200 (ADDI)
  - x2-x4: byte 测试数据 (ADDI)
  - x8-x9: word 测试数据 (ADDI)
- 使用 AUIPC+ADDI 构造 halfword 边界值：
  - x5: 27767 (AUIPC + ADDI)
  - x7: 65535 (AUIPC + ADDI)
- 使用 LUI 直接加载负数：
  - x6: -32768 (LUI)

### Store 测试阶段
- SB: 测试 byte 存储（3次），包括正数边界、负数边界、unsigned最大值
- SH: 测试 halfword 存储（3次），包括中间值、负数边界、unsigned最大值
- SW: 测试 word 存储（2次），包括正常值和全1

### Load 测试阶段
- LB: 测试 signed byte 加载和符号扩展（2次）
- LBU: 测试 unsigned byte 加载和零扩展（1次）
- LH: 测试 signed halfword 加载和符号扩展（2次）
- LHU: 测试 unsigned halfword 加载和零扩展（1次）
- LW: 测试 word 加载（2次）

## 指令格式说明

### I-type (Load 指令 + ADDI)
```
imm[11:0] | rs1[19:15] | funct3[14:12] | rd[11:7] | opcode[6:0]
```
- **Load opcode**: 0000011
- **ADDI opcode**: 0010011
- **funct3** (Load):
  - 000: LB (load byte, 有符号扩展)
  - 001: LH (load halfword, 有符号扩展)
  - 010: LW (load word)
  - 100: LBU (load byte, 零扩展)
  - 101: LHU (load halfword, 零扩展)

### S-type (Store 指令)
```
imm[11:5] | rs2[24:20] | rs1[19:15] | funct3[14:12] | imm[4:0] | opcode[6:0]
```
- **opcode**: 0100011
- **funct3**:
  - 000: SB (store byte)
  - 001: SH (store halfword)
  - 010: SW (store word)

### U-type (LUI, AUIPC)
```
imm[31:12] | rd[11:7] | opcode[6:0]
```
- **LUI opcode**: 0110111 (加载立即数到高20位，低12位清零)
- **AUIPC opcode**: 0010111 (PC + 立即数左移12位)

## Opcode_ctrl 控制信号

| 指令类型 | opcode  | aluop | alu_src | mem_read | mem_write | mem2reg | reg_write |
|---------|---------|-------|---------|----------|-----------|---------|-----------|
| Load    | 0000011 | 00    | 1       | 1        | 0         | 1       | 1         |
| Store   | 0100011 | 00    | 1       | 0        | 1         | 0       | 0         |
| I-type  | 0010011 | 11    | 1       | 0        | 0         | 0       | 1         |
| R-type  | 0110011 | 10    | 0       | 0        | 0         | 0       | 1         |

## 预期寄存器最终状态

| 寄存器 | 值 (十进制) | 值 (十六进制) | 备注 / 操作 |
|--------|------------|---------------|------------|
| x0     | 0          | 0x00000000    | 恒为 0 (硬件固定) |
| x1     | 200        | 0x000000C8    | 基地址 (ADDI) |
| x2     | 127        | 0x0000007F    | byte 最大正值 (ADDI) |
| x3     | -128       | 0xFFFFFF80    | byte 最小负值 (ADDI) |
| x4     | 255        | 0x000000FF    | byte 最大 unsigned (ADDI) |
| x5     | 27767      | 0x00006C77    | halfword 测试值 (AUIPC+ADDI) |
| x6     | -32768     | 0xFFFF8000    | halfword 最小负值 (LUI) |
| x7     | 65535      | 0x0000FFFF    | halfword 最大 unsigned (AUIPC+ADDI) |
| x8     | 1024       | 0x00000400    | word 测试值 (ADDI) |
| x9     | -1         | 0xFFFFFFFF    | 全1测试值 (ADDI) |
| x10    | 127        | 0x0000007F    | LB from MEM[200] (signed ext) |
| x11    | -128       | 0xFFFFFF80    | LB from MEM[201] (signed ext) |
| x12    | 255        | 0x000000FF    | LBU from MEM[202] (zero ext) |
| x13    | 27767      | 0x00006C77    | LH from MEM[204] (signed ext) |
| x14    | -32768     | 0xFFFF8000    | LH from MEM[206] (signed ext) |
| x15    | 65535      | 0x0000FFFF    | LHU from MEM[210] (zero ext) |
| x16    | 1024       | 0x00000400    | LW from MEM[212] |
| x17    | -1         | 0xFFFFFFFF    | LW from MEM[216] |
| x18-x31| 0          | 0x00000000    | 未使用 |

## 预期内存最终状态

| 地址 | 偏移 | 值 (十六进制) | 备注 |
|------|------|--------------|------|
| 200  | +0   | 0x7F         | SB x2, 0(x1) - byte |
| 201  | +1   | 0x80         | SB x3, 1(x1) - byte |
| 202  | +2   | 0xFF         | SB x4, 2(x1) - byte |
| 203  | +3   | 0x00         | 未写入 |
| 204  | +4   | 0x77         | SH x5, 4(x1) - halfword 低字节 |
| 205  | +5   | 0x6C         | SH x5, 4(x1) - halfword 高字节 |
| 206  | +6   | 0x00         | SH x6, 6(x1) - halfword 低字节 |
| 207  | +7   | 0x80         | SH x6, 6(x1) - halfword 高字节 |
| 208  | +8   | 0x00         | 未写入 |
| 209  | +9   | 0x00         | 未写入 |
| 210  | +10  | 0xFF         | SH x7, 10(x1) - halfword 低字节 |
| 211  | +11  | 0xFF         | SH x7, 10(x1) - halfword 高字节 |
| 212  | +12  | 0x00         | SW x8, 12(x1) - word 字节0 |
| 213  | +13  | 0x04         | SW x8, 12(x1) - word 字节1 |
| 214  | +14  | 0x00         | SW x8, 12(x1) - word 字节2 |
| 215  | +15  | 0x00         | SW x8, 12(x1) - word 字节3 |
| 216  | +16  | 0xFF         | SW x9, 16(x1) - word 字节0 |
| 217  | +17  | 0xFF         | SW x9, 16(x1) - word 字节1 |
| 218  | +18  | 0xFF         | SW x9, 16(x1) - word 字节2 |
| 219  | +19  | 0xFF         | SW x9, 16(x1) - word 字节3 |

## 测试覆盖率

- ✅ **Load 指令**:
  - LB (2次) - signed byte load with sign extension
  - LBU (1次) - unsigned byte load with zero extension
  - LH (2次) - signed halfword load with sign extension
  - LHU (1次) - unsigned halfword load with zero extension
  - LW (2次) - word load
- ✅ **Store 指令**:
  - SB (3次) - byte store (127, -128, 255)
  - SH (3次) - halfword store (27767, -32768, 65535)
  - SW (2次) - word store (1024, -1)
- ✅ **I-type 算术**: ADDI (7次，用于初始化小值和微调)
- ✅ **U-type 指令**:
  - LUI (1次) - 直接加载高20位立即数
  - AUIPC (2次) - PC相对寻址构造大数
- ✅ **立即数扩展**: 
  - ADDI 12位立即数 [-2048, 2047]
  - LUI 20位立即数 (高位)
  - AUIPC + ADDI 组合构造任意值
- ✅ **内存访问**: 
  - 字节对齐 (byte)
  - 半字对齐 (halfword)
  - 字对齐 (word)
- ✅ **数据模式**: 
  - byte: 正数边界 (127)、负数边界 (-128)、unsigned 最大 (255)
  - halfword: 中间值 (27767)、负数边界 (-32768)、unsigned 最大 (65535)
  - word: 正数 (1024)、全1 (-1)
- ✅ **符号扩展测试**: LB/LH 对负数的符号扩展
- ✅ **零扩展测试**: LBU/LHU 对数据的零扩展

## DataMemory 时序说明

根据 `DataMemory.v` 实现，内存访问需要 **4 个时钟周期**：
1. **周期 1**: 地址稳定，发送地址到 BRAM
2. **周期 2**: 数据稳定 (读取低 16 位)
3. **周期 3**: 地址切换 (高 16 位地址)
4. **周期 4**: 数据稳定 (读取高 16 位)，完成读写

## 验证方法

1. 在仿真环境中运行测试台 (`tb_top.v` 或 `tb_mem.v`)
2. 加载指令到指令 BRAM (`bram_8_4096_ins_shell.v`)
3. 观察每个周期的寄存器和内存变化
4. 对比实际结果与预期结果表
5. 检查控制信号 (mem_read, mem_write, mem2reg) 是否正确
6. 验证 DataMemory 状态机在 4 周期内完成读写

## 相关文件

1. **rtl/Opcode_ctrl.v**: 主控制器，区分 Load/Store/I-type
2. **rtl/DataMemory.v**: 数据内存模块，支持双端口 BRAM
3. **rtl/ALU.v**: ALU 用于地址计算 (base + offset)
4. **rtl/ImmGenerator.v**: 立即数生成器，处理 I/S/U-type 立即数
5. **rtl/Registers.v**: 寄存器文件
6. **BRAM 初始化文件**: 存储测试指令和数据
