# Elaborate 文件创建教程

## 什么是Elaborate文件？

Elaborate文件是Chisel项目中的**Verilog生成器**，它的作用是：
1. 实例化你的Chisel模块
2. 调用ChiselStage将其转换为Verilog代码
3. 指定输出目录和文件名

## Elaborate文件的基本结构

### 完整模板

```scala
package your_package_name

import chisel3._
import chisel3.stage.ChiselStage

/**
 * 生成Verilog文件的主程序
 */
object Elaborate extends App {
  println("正在生成 XXX 模块的 Verilog 文件...")
  
  // 使用ChiselStage生成Verilog
  (new ChiselStage).emitVerilog(
    new YourModule(),              // 要生成的模块实例
    Array(
      "--target-dir", "output/dir",    // 输出目录
      "--output-file", "OutputName"    // 输出文件名（不含.v扩展名）
    )
  )
  
  println("Verilog 文件已生成到: output/dir/OutputName.v")
  println("生成完成！")
}
```

## 详细说明

### 1. Package声明
```scala
package your_package_name
```
- 必须与模块所在的package一致
- 例如：decoder3to8、decoder2to4、test等

### 2. 导入必要的库
```scala
import chisel3._
import chisel3.stage.ChiselStage
```
- `chisel3._`：Chisel核心功能
- `chisel3.stage.ChiselStage`：Verilog生成器

### 3. 定义object Elaborate
```scala
object Elaborate extends App {
  // ...
}
```
- `object`：Scala的单例对象
- `extends App`：使其可以作为主程序运行
- 名字必须是`Elaborate`或其他有意义的名字

### 4. 调用emitVerilog
```scala
(new ChiselStage).emitVerilog(
  new YourModule(),              // 第一个参数：模块实例
  Array(                          // 第二个参数：配置选项
    "--target-dir", "output/dir",
    "--output-file", "OutputName"
  )
)
```

#### 常用参数说明

| 参数 | 说明 | 示例 |
|------|------|------|
| `--target-dir` | 输出目录 | `"decoder3to8/generated"` |
| `--output-file` | 文件名（不含.v） | `"Decoder3to8"` |
| `--strip-debug-info` | 去除调试信息 | 无值参数 |
| `--disable-all-randomization` | 禁用随机化 | 无值参数 |

## 创建步骤

### Step 1: 确定项目结构
```
your_project/
├── src/main/scala/
│   └── mymodule/
│       ├── MyModule.scala      # 硬件模块
│       └── Elaborate.scala     # 生成器（创建这个）
└── mymodule/
    └── generated/              # 输出目录
```

### Step 2: 创建Elaborate.scala文件

在对应的package目录下创建文件：
```bash
touch src/main/scala/mymodule/Elaborate.scala
```

### Step 3: 编写代码

```scala
package mymodule

import chisel3._
import chisel3.stage.ChiselStage

object Elaborate extends App {
  println("正在生成模块的 Verilog 文件...")
  
  (new ChiselStage).emitVerilog(
    new MyModule(),
    Array(
      "--target-dir", "mymodule/generated",
      "--output-file", "MyModule"
    )
  )
  
  println("生成完成！")
}
```

### Step 4: 运行生成器

```bash
# 方式1：使用sbt
sbt "runMain mymodule.Elaborate"

# 方式2：使用Makefile
make mymodule

# 方式3：在sbt shell中
sbt
> runMain mymodule.Elaborate
```

## 实际示例

### 示例1：简单的加法器

**MyAdder.scala**
```scala
package test

import chisel3._

class MyAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val sum = Output(UInt(8.W))
  })
  
  io.sum := io.a + io.b
}
```

**Elaborate.scala**
```scala
package test

import chisel3._
import chisel3.stage.ChiselStage

object Elaborate extends App {
  println("正在生成加法器的 Verilog 文件...")
  
  (new ChiselStage).emitVerilog(
    new MyAdder(),
    Array(
      "--target-dir", "test/generated",
      "--output-file", "MyAdder"
    )
  )
  
  println("✓ Verilog 文件已生成到: test/generated/MyAdder.v")
}
```

### 示例2：带参数的模块

**ParameterizedModule.scala**
```scala
package test

import chisel3._

class ParameterizedModule(width: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })
  
  io.out := io.in
}
```

**Elaborate.scala**
```scala
package test

import chisel3._
import chisel3.stage.ChiselStage

object Elaborate extends App {
  println("生成16位模块...")
  
  // 可以生成不同参数的版本
  (new ChiselStage).emitVerilog(
    new ParameterizedModule(16),  // 传入参数
    Array(
      "--target-dir", "test/generated",
      "--output-file", "ParameterizedModule16"
    )
  )
  
  println("生成32位模块...")
  
  (new ChiselStage).emitVerilog(
    new ParameterizedModule(32),
    Array(
      "--target-dir", "test/generated",
      "--output-file", "ParameterizedModule32"
    )
  )
  
  println("✓ 生成完成！")
}
```

### 示例3：生成多个模块

```scala
package test

import chisel3._
import chisel3.stage.ChiselStage

object ElaborateAll extends App {
  val stage = new ChiselStage
  
  // 生成模块1
  println("==> 生成 Module1...")
  stage.emitVerilog(
    new Module1(),
    Array("--target-dir", "test/generated")
  )
  
  // 生成模块2
  println("==> 生成 Module2...")
  stage.emitVerilog(
    new Module2(),
    Array("--target-dir", "test/generated")
  )
  
  println("✓ 所有模块生成完成！")
}
```

## 高级选项

### 生成FIRRTL中间表示

```scala
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

object Elaborate extends App {
  // 生成FIRRTL
  (new ChiselStage).execute(
    Array("--target-dir", "generated"),
    Seq(ChiselGeneratorAnnotation(() => new MyModule()))
  )
}
```

### 添加更多编译选项

```scala
(new ChiselStage).emitVerilog(
  new MyModule(),
  Array(
    "--target-dir", "generated",
    "--output-file", "MyModule",
    "--strip-debug-info",              // 去除调试信息
    "--disable-all-randomization",     // 禁用随机化
    "--split-verilog",                 // 分割为多个Verilog文件
    "--full-stacktrace"                // 显示完整错误栈
  )
)
```

## 常见错误和解决方案

### 错误1：找不到模块类
```
error: not found: type MyModule
```
**解决：** 确保package名称一致，且模块文件在同一package下

### 错误2：输出目录不存在
```
java.nio.file.NoSuchFileException: test/generated
```
**解决：** 先创建输出目录
```bash
mkdir -p test/generated
```

### 错误3：ChiselStage已弃用警告
```
warning: class ChiselStage in package stage is deprecated
```
**说明：** 这是正常的弃用警告，不影响功能。未来可能需要切换到`circt.stage.ChiselStage`

## 运行方式对比

| 方式 | 命令 | 优点 | 缺点 |
|------|------|------|------|
| SBT直接运行 | `sbt "runMain pkg.Elaborate"` | 简单直接 | 每次都启动SBT |
| SBT Shell | `sbt` → `runMain pkg.Elaborate` | 保持SBT会话 | 需要进入shell |
| Makefile | `make target` | 最方便 | 需要配置Makefile |
| IDE | 右键运行 | 图形化 | 依赖IDE |

## 最佳实践

1. ✅ **每个模块一个Elaborate文件**：便于单独生成
2. ✅ **使用有意义的输出目录**：如`module_name/generated`
3. ✅ **添加打印信息**：让用户知道生成进度
4. ✅ **输出文件名与模块名一致**：便于识别
5. ✅ **创建ElaborateAll**：需要批量生成时使用

## 总结

Elaborate文件的本质：
- **输入**：Chisel模块类
- **处理**：ChiselStage编译器
- **输出**：Verilog硬件描述文件

创建公式：
```
Elaborate = object + extends App + ChiselStage.emitVerilog
```

---

现在你应该完全理解如何创建Elaborate文件了！

