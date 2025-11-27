# BRAM 初始化指南

## 概述

本指南介绍如何在 Chisel 中初始化 BRAM（Block RAM）模块，用于在仿真测试时预加载指令或数据。

## 初始化方法

### 方法1：使用初始化文件（推荐）

这是最灵活和常用的方法，适用于加载程序代码或大量数据。

#### 步骤1：创建初始化文件

创建一个十六进制格式的文本文件，每行一个字节值（十六进制）：

**文件位置**: `/home/pyx/Workspace/sCPU/init_data/test_program.hex`

```hex
93
00
f0
00
13
00
a0
00
...
```

**注意**:
- 每行表示一个字节（8位）的数据
- 使用十六进制格式（不需要 0x 前缀）
- 按地址顺序从 0 开始
- 文件路径相对于项目根目录

#### 步骤2：使用初始化文件创建模块

```scala
// 创建带初始化文件的指令缓存
val insCache = Module(new insCacheL1(
  useBlackBox = false,  // 使用 Chisel 实现
  initFile = Some("init_data/test_program.hex")  // 初始化文件路径
))

// 创建带初始化文件的数据缓存
val dataCache = Module(new dataCacheL1(
  useBlackBox = false,
  initFile = Some("init_data/my_data.hex")
))
```

### 方法2：不使用初始化文件（默认为零）

如果不提供初始化文件，BRAM 默认初始化为全零：

```scala
// 内存初始化为全零
val cache = Module(new insCacheL1())

// 或者显式指定不初始化
val cache2 = Module(new dataCacheL1(initFile = None))
```

### 方法3：在测试中动态写入数据

在测试代码中使用写操作预加载数据：

```scala
test(new insCacheL1()) { dut =>
  dut.io.ena.poke(true.B)
  dut.io.wea.poke(true.B)
  
  // 写入指令序列
  val instructions = Seq(0x93, 0x00, 0xf0, 0x00, 0x13, 0x00, 0xa0, 0x00)
  for ((byte, addr) <- instructions.zipWithIndex) {
    dut.io.addra.poke(addr.U)
    dut.io.dina.poke(byte.U)
    dut.clock.step(1)
  }
  
  // 切换到读模式进行测试
  dut.io.wea.poke(false.B)
  // ... 测试代码
}
```

## 完整示例

### 示例1：加载 RISC-V 程序

```scala
// 1. 准备初始化文件 (init_data/riscv_program.hex)
// 内容：RISC-V 指令的字节码（小端序）

// 2. 创建带初始化的指令缓存
class MyProcessor extends Module {
  val insCache = Module(new insCacheL1(
    useBlackBox = false,
    initFile = Some("init_data/riscv_program.hex")
  ))
  
  // 连接处理器逻辑
  insCache.io.ena := true.B
  insCache.io.wea := false.B  // 只读
  insCache.io.addra := pc  // 程序计数器
  val instruction = insCache.io.douta
}
```

### 示例2：测试初始化功能

```scala
class InitTest extends AnyFlatSpec with ChiselScalatestTester {
  "Cache" should "load data from file" in {
    test(new insCacheL1(initFile = Some("init_data/test_program.hex"))) { dut =>
      dut.io.ena.poke(true.B)
      dut.io.wea.poke(false.B)
      
      // 验证地址 0 的值
      dut.io.addra.poke(0.U)
      dut.clock.step(1)
      dut.io.douta.expect(0x93.U)  // 期望值来自初始化文件
      
      // 验证地址 1 的值
      dut.io.addra.poke(1.U)
      dut.clock.step(1)
      dut.io.douta.expect(0x00.U)
    }
  }
}
```

### 示例3：覆盖初始化数据

初始化后的数据可以通过写操作覆盖：

```scala
test(new insCacheL1(initFile = Some("init_data/test_program.hex"))) { dut =>
  dut.io.ena.poke(true.B)
  
  // 读取初始值
  dut.io.wea.poke(false.B)
  dut.io.addra.poke(0.U)
  dut.clock.step(1)
  val originalValue = dut.io.douta.peek()
  
  // 写入新值
  dut.io.wea.poke(true.B)
  dut.io.dina.poke(0xAA.U)
  dut.clock.step(1)
  
  // 验证新值
  dut.io.wea.poke(false.B)
  dut.io.addra.poke(0.U)
  dut.clock.step(1)
  dut.io.douta.expect(0xAA.U)  // 新值覆盖了初始值
}
```

## 初始化文件格式详解

### 十六进制格式（推荐）

```
93
00
f0
00
```

- 每行一个字节
- 使用十六进制（0-9, a-f）
- 不需要 0x 前缀
- 大小写不敏感

### 从 RISC-V 汇编生成初始化文件

如果你有 RISC-V 汇编代码，可以使用以下步骤生成初始化文件：

```bash
# 1. 汇编并链接
riscv32-unknown-elf-as -o program.o program.s
riscv32-unknown-elf-ld -o program.elf program.o

# 2. 生成二进制文件
riscv32-unknown-elf-objcopy -O binary program.elf program.bin

# 3. 转换为十六进制格式（每行一个字节）
xxd -p -c 1 program.bin > init_data/program.hex
```

### 从 C 代码生成初始化文件

```bash
# 1. 编译
riscv32-unknown-elf-gcc -o program.elf program.c -nostdlib -march=rv32i

# 2. 生成二进制并转换
riscv32-unknown-elf-objcopy -O binary program.elf program.bin
xxd -p -c 1 program.bin > init_data/program.hex
```

## API 参考

### insCacheL1 构造函数

```scala
class insCacheL1(
  useBlackBox: Boolean = false,  // 是否使用 Verilog BlackBox
  initFile: Option[String] = None // 初始化文件路径（可选）
) extends Module
```

**参数**:
- `useBlackBox`: 
  - `false` (默认): 使用 Chisel `SyncReadMem` 实现，支持初始化文件
  - `true`: 使用 Verilog BlackBox，初始化在 Verilog 代码中定义
- `initFile`: 
  - `None` (默认): 不加载初始化数据，内存为全零
  - `Some("path/to/file.hex")`: 从文件加载初始化数据

### dataCacheL1 构造函数

```scala
class dataCacheL1(
  useBlackBox: Boolean = false,
  initFile: Option[String] = None
) extends Module
```

参数与 `insCacheL1` 相同。

## 文件位置说明

初始化文件的路径相对于 **项目根目录** (`/home/pyx/Workspace/sCPU/`)：

```
sCPU/
├── init_data/              # 初始化文件目录（项目根）
│   ├── test_program.hex
│   ├── riscv_program.hex
│   └── data.hex
├── chisel/
│   └── src/
│       ├── main/
│       │   └── resources/
│       │       └── init_data/  # 也可以放在这里（会被复制）
│       └── test/
│           └── resources/
│               └── init_data/  # 测试专用初始化文件
```

**推荐做法**:
- 将初始化文件放在项目根目录的 `init_data/` 目录
- 或者在 `chisel/src/main/resources/init_data/` 目录（编译时会复制到 classpath）

## 注意事项

1. **文件格式**: 确保使用正确的十六进制格式，每行一个字节
2. **文件大小**: 文件最多应包含 4096 行（对应 4KB BRAM）
3. **路径**: 文件路径相对于项目根目录
4. **仿真限制**: 初始化文件仅在仿真时有效，实际 FPGA 综合时需要在 Verilog 代码中定义
5. **BlackBox 模式**: 当 `useBlackBox = true` 时，`initFile` 参数会被忽略，初始化由 Verilog 代码控制

## 测试示例

参考测试文件：`chisel/src/test/scala/InitializedCacheTest.scala`

运行测试：
```bash
sbt "testOnly scpu.InitializedCacheTest"
```

## 常见问题

### Q: 为什么找不到初始化文件？
A: 确保文件路径相对于项目根目录正确，或者使用绝对路径。

### Q: 可以在运行时更改初始化文件吗？
A: 不可以，初始化文件在模块创建时确定，之后不能更改。但可以通过写操作覆盖内存内容。

### Q: BlackBox 模式下如何初始化？
A: BlackBox 模式下，初始化在 Verilog 代码的 `initial` 块中定义（参见 `bram_8_4096_ins_shell.v`）。

### Q: 支持其他格式的初始化文件吗？
A: 目前仅支持十六进制文本格式（每行一个字节）。可以使用 `xxd` 等工具转换其他格式。

## 相关文件

- 实现: `chisel/src/main/scala/DataManage.scala`
- 测试: `chisel/src/test/scala/InitializedCacheTest.scala`
- 示例初始化文件: `init_data/test_program.hex`
- Verilog BlackBox: `rtl/shell/bram_8_4096_ins_shell.v`
