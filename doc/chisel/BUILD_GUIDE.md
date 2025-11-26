# Chisel 构建文件说明

本文档详细说明了 Chisel 项目的 `build.sbt` 配置文件。

## 项目结构

```
ysyx/
├── build.sbt              # SBT 构建配置文件
├── project/
│   └── build.properties   # SBT 版本配置
└── src/
    ├── main/
    │   └── scala/         # 主要的 Chisel 代码
    └── test/
        └── scala/         # 测试代码
```

## build.sbt 详解

### 1. 基本配置

```scala
ThisBuild / version := "0.1.0-SNAPSHOT"
ThisBuild / scalaVersion := "2.13.12"
```

- **version**: 项目版本号，使用 SNAPSHOT 表示开发版本
- **scalaVersion**: Scala 版本，Chisel 3.6.0 推荐使用 Scala 2.13.x

### 2. 项目定义

```scala
lazy val root = (project in file("."))
  .settings(
    name := "ysyx",
    // ... 其他配置
  )
```

- **lazy val root**: 定义根项目
- **name**: 项目名称

### 3. 依赖库配置

```scala
libraryDependencies ++= Seq(
  "edu.berkeley.cs" %% "chisel3" % "3.6.0",
  "edu.berkeley.cs" %% "chiseltest" % "0.6.2" % "test"
)
```

#### 核心依赖

- **chisel3**: Chisel 核心库，用于硬件设计
  - 组织: `edu.berkeley.cs`
  - 版本: `3.6.0` (稳定版本)
  - `%%` 表示自动匹配 Scala 版本

- **chiseltest**: Chisel 测试框架
  - 版本: `0.6.2`
  - `% "test"` 表示仅在测试时使用

#### 版本选择建议

| Chisel 版本 | Scala 版本 | 说明 |
|------------|-----------|------|
| 3.6.x | 2.13.x | 推荐使用，稳定版本 |
| 5.x.x | 2.13.x | 新版本，API 有变化 |

### 4. 编译器选项

```scala
scalacOptions ++= Seq(
  "-language:reflectiveCalls",
  "-deprecation",
  "-feature",
  "-Xcheckinit",
  "-P:chiselplugin:genBundleElements"
)
```

#### 选项说明

- **-language:reflectiveCalls**: 启用反射调用（Chisel 需要）
- **-deprecation**: 显示弃用警告
- **-feature**: 显示需要明确启用的特性警告
- **-Xcheckinit**: 检查字段初始化
- **-P:chiselplugin:genBundleElements**: Chisel 插件选项，用于生成 Bundle 元素

### 5. 编译器插件

```scala
addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.6.0" cross CrossVersion.full)
```

- **chisel3-plugin**: Chisel 编译器插件，必需！
- **CrossVersion.full**: 完全匹配 Scala 版本（包括小版本号）

## 常用 SBT 命令

### 编译和运行

```bash
# 编译项目
sbt compile

# 运行主程序（需要有 main 方法）
sbt Elaborate

# 清理构建产物
sbt clean
```

### 测试

```bash
# 运行所有测试
sbt test

# 运行特定测试
sbt "testOnly YourTestClassName"

# 持续测试（文件变化时自动测试）
sbt ~test
```

### 交互式开发

```bash
# 进入 SBT shell
sbt

# 在 shell 中的命令：
> compile          # 编译
> test            # 测试
> console         # 启动 Scala REPL
> ~compile        # 监听模式，自动编译
> exit            # 退出
```

### 生成 Verilog

创建一个生成器文件（如 `src/main/scala/Elaborate.scala`）:

```scala
import chisel3._
import chisel3.stage.ChiselStage

object Elaborate extends App {
  (new ChiselStage).emitVerilog(
    new YourModule(),
    Array("--target-dir", "generated")
  )
}
```

然后运行：

```bash
sbt "runMain Elaborate"
```

## 项目示例

### 创建简单的 Chisel 模块

在 `src/main/scala/` 目录下创建 `Example.scala`:

```scala
package ysyx

import chisel3._

// 简单的加法器模块
class Adder extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val sum = Output(UInt(32.W))
  })
  
  io.sum := io.a + io.b
}
```

### 创建测试

在 `src/test/scala/` 目录下创建 `AdderTest.scala`:

```scala
package ysyx

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class AdderTest extends AnyFlatSpec with ChiselScalatestTester {
  "Adder" should "add two numbers" in {
    test(new Adder) { dut =>
      dut.io.a.poke(10.U)
      dut.io.b.poke(20.U)
      dut.io.sum.expect(30.U)
    }
  }
}
```

## 高级配置（可选）

### 添加更多依赖

```scala
libraryDependencies ++= Seq(
  // Chisel 核心
  "edu.berkeley.cs" %% "chisel3" % "3.6.0",
  
  // 测试框架
  "edu.berkeley.cs" %% "chiseltest" % "0.6.2" % "test",
  "org.scalatest" %% "scalatest" % "3.2.16" % "test",
  
  // FIRRTL（Chisel 的中间表示）
  "edu.berkeley.cs" %% "firrtl" % "1.6.0",
  
  // Treadle（FIRRTL 解释器）
  "edu.berkeley.cs" %% "treadle" % "1.6.0" % "test"
)
```

### 配置并行测试

```scala
Test / parallelExecution := false
```

### 配置 Java 选项

```scala
fork := true
javaOptions ++= Seq(
  "-Xmx2G",
  "-Xss256M"
)
```

## 故障排除

### 常见问题

1. **编译错误："object chisel3 is not a member of package"**
   - 解决：运行 `sbt update` 更新依赖

2. **内存不足**
   - 解决：在项目根目录创建 `.sbtopts` 文件：
     ```
     -Xmx2G
     -Xss256M
     ```

3. **依赖下载慢**
   - 解决：配置国内镜像，编辑 `~/.sbt/repositories`:
     ```
     [repositories]
     local
     aliyun: https://maven.aliyun.com/repository/public/
     maven-central
     ```

## 参考资源

- [Chisel 官方文档](https://www.chisel-lang.org/)
- [Chisel Bootcamp](https://github.com/freechipsproject/chisel-bootcamp)
- [Chisel API 文档](https://www.chisel-lang.org/api/latest/)
- [SBT 文档](https://www.scala-sbt.org/)

## 版本更新

如需使用最新版本的 Chisel，请访问：
- https://github.com/chipsalliance/chisel3/releases

更新时确保 chisel3、chisel3-plugin 和 chiseltest 的版本兼容。

