# Chisel 条件 IO 端口指南

## 问题
在 Chisel 中，**不能**使用 if-else 来定义完全不同的 IO Bundle。以下代码是**错误的**：

```scala
// ❌ 错误示例 - 不能这样做！
class MyModule(debug: Boolean) extends Module {
  if (debug) {
    val io = IO(new Bundle {
      val in = Input(UInt(8.W))
      val out = Output(UInt(8.W))
      val debug_signal = Output(UInt(8.W))  // 调试信号
    })
  } else {
    val io = IO(new Bundle {
      val in = Input(UInt(8.W))
      val out = Output(UInt(8.W))
      // 没有 debug_signal
    })
  }
}
```

**原因**：Chisel 的 IO 结构必须在编译时（elaboration time）确定，不能根据运行时参数动态改变。

## 解决方案：使用 Option 类型

正确的做法是使用 `Option` 类型来实现条件端口：

```scala
// ✅ 正确示例
class MyModule(debug: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(8.W))
    val out = Output(UInt(8.W))
    // 使用 Option 实现条件端口
    val debug_signal = if (debug) Some(Output(UInt(8.W))) else None
  })
  
  // 连接调试信号（如果启用）
  if (debug) {
    io.debug_signal.get := someInternalSignal
  }
}
```

## InsBuffer 实际例子

在 `InsBuffer` 中的实现：

```scala
class InsBuffer(width:Int = 32, bufferSize:Int = 128, Debug:Boolean = false) extends Module{
  val io = IO(new Bundle{
    // 基本端口 - 始终存在
    val pc_in = Input(UInt(width.W))
    val ins_low = Input(UInt(8.W))
    val ins_high = Input(UInt(8.W))
    val addr_low = Output(UInt(32.W))
    val addr_high = Output(UInt(32.W))
    val ins_out = Output(UInt(32.W))
    val valid = Output(Bool())
    val busy = Output(Bool())
    
    // 调试端口 - 只在 Debug=true 时存在
    val index = if (Debug) Some(Output(UInt(log2Ceil(bufferSize).W))) else None
    val access_cnt = if (Debug) Some(Output(UInt((log2Ceil(bufferSize)+1).W))) else None
  })

  // 内部信号
  val index = RegInit(0.U(index_range))
  val access_cnt = RegInit(0.U(index_range))
  
  // 连接调试端口（如果启用）
  if (Debug) {
    io.index.get := index
    io.access_cnt.get := access_cnt
  }
  
  // ... 其他逻辑
}
```

## 使用方式

```scala
// 普通模式 - 没有调试端口
val normalBuffer = Module(new InsBuffer(Debug = false))
normalBuffer.io.pc_in := somePC
val instruction = normalBuffer.io.ins_out

// 调试模式 - 包含调试端口
val debugBuffer = Module(new InsBuffer(Debug = true))
debugBuffer.io.pc_in := somePC
val instruction = debugBuffer.io.ins_out
val currentIndex = debugBuffer.io.index.get      // 使用 .get 访问 Option 内容
val accessCount = debugBuffer.io.access_cnt.get
```

## 关键要点

1. **IO Bundle 必须在编译时确定** - 不能在模块级别使用 if-else 定义不同的 IO
2. **使用 Option 类型** - `if (condition) Some(port) else None`
3. **访问 Option 端口** - 使用 `.get` 方法：`io.debug_signal.get := value`
4. **内部逻辑可以条件执行** - 可以用 if 判断是否连接调试信号

## 其他方案

如果需要更复杂的条件 IO，可以考虑：

1. **始终包含所有端口**，在不需要时忽略它们（最简单）
2. **使用继承和多态**创建不同版本的模块
3. **使用 BlackBox** 连接不同的 Verilog 实现

但对于简单的调试端口场景，Option 类型是最优雅的解决方案。

