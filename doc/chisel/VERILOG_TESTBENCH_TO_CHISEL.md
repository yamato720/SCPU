# Verilog Testbench 到 Chisel Test 映射指南

本文档提供了从 Verilog testbench 到 Chisel 测试的语法映射对照，帮助您快速编写 Chisel 测试代码。

## 目录
- [基本测试框架](#基本测试框架)
- [测试环境设置](#测试环境设置)
- [信号赋值](#信号赋值)
- [时钟和延迟](#时钟和延迟)
- [断言和检查](#断言和检查)
- [测试用例组织](#测试用例组织)
- [显示和打印](#显示和打印)
- [常用测试模式](#常用测试模式)
- [波形生成与查看](#波形生成与查看)
  - [基本波形生成](#基本波形生成)
  - [波形文件位置](#波形文件位置)
  - [查看波形文件](#查看波形文件)
  - [选择记录特定信号](#选择记录特定信号)
  - [高级波形配置](#高级波形配置)
  - [波形生成最佳实践](#波形生成最佳实践)
  - [波形调试技巧](#波形调试技巧)
- [循环测试详解](#循环测试详解)
- [随机数测试](#随机数测试)
  - [基本随机数生成](#基本随机数生成)
  - [固定种子](#固定种子可复现测试)
  - [指定范围的随机数](#指定范围的随机数)
  - [随机测试常用模式](#随机测试常用模式)
  - [随机数最佳实践](#随机数最佳实践)

---

## 基本测试框架

### Verilog Testbench
```verilog
`timescale 1ns/1ps

module tb_MyModule;
    reg clk;
    reg rst;
    reg [7:0] dataIn;
    wire [7:0] dataOut;
    
    // 实例化待测模块
    MyModule dut (
        .clk(clk),
        .rst(rst),
        .dataIn(dataIn),
        .dataOut(dataOut)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // 测试序列
    initial begin
        rst = 1;
        dataIn = 0;
        #10 rst = 0;
        #10 dataIn = 8'h55;
        #10 dataIn = 8'hAA;
        #10 $finish;
    end
endmodule
```

### Chisel Test
```scala
package mypackage

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MyModuleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MyModule"
  
  it should "test basic functionality" in {
    test(new MyModule) { dut =>
      // 复位
      dut.reset.poke(true.B)
      dut.clock.step(1)
      dut.reset.poke(false.B)
      
      // 测试序列
      dut.io.dataIn.poke(0x55.U)
      dut.clock.step(1)
      
      dut.io.dataIn.poke(0xAA.U)
      dut.clock.step(1)
    }
  }
}
```

---

## 测试环境设置

### 依赖配置

需要在 `build.sbt` 中添加测试依赖：
```scala
libraryDependencies ++= Seq(
  "edu.berkeley.cs" %% "chisel3" % "3.6.0",
  "edu.berkeley.cs" %% "chiseltest" % "0.6.2" % "test"
)
```

### 导入语句

```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
```

---

## 信号赋值

### Verilog
```verilog
// 赋值
dataIn = 8'h55;
enable = 1'b1;
addr = 4'd10;

// 读取
$display("Output = %h", dataOut);
if (dataOut == 8'h55) begin
    $display("PASS");
end
```

### Chisel
```scala
// 赋值（poke）
dut.io.dataIn.poke(0x55.U)
dut.io.enable.poke(true.B)
dut.io.addr.poke(10.U)

// 读取（peek）
val output = dut.io.dataOut.peek()
println(f"Output = 0x${output.litValue}%02x")

// 期望值检查（expect）
dut.io.dataOut.expect(0x55.U)
```

### 主要函数对比

| Verilog | Chisel | 说明 |
|---------|--------|------|
| `signal = value;` | `dut.io.signal.poke(value)` | 设置输入信号 |
| `out_value = signal;` | `dut.io.signal.peek()` | 读取信号值 |
| - | `dut.io.signal.expect(value)` | 检查信号值是否匹配 |

---

## 时钟和延迟

### Verilog
```verilog
// 时钟生成
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns周期
end

// 延迟
#10;              // 延迟10个时间单位
#(2*CLK_PERIOD);  // 延迟2个时钟周期
@(posedge clk);   // 等待时钟上升沿
repeat(5) @(posedge clk);  // 等待5个时钟周期
```

### Chisel
```scala
// 时钟由测试框架自动生成

// 前进1个时钟周期
dut.clock.step(1)

// 前进多个时钟周期
dut.clock.step(5)

// 前进半个时钟周期（不常用）
dut.clock.step()

// 不推进时钟，只等待组合逻辑稳定
// （通常不需要，poke后会自动等待）
```

**重要区别**:
- Chisel 的 `clock.step()` 会推进时钟并等待时序逻辑更新
- 不需要显式生成时钟信号
- 组合逻辑在 `poke` 后会立即生效

---

## 断言和检查

### Verilog
```verilog
// 简单检查
if (dataOut != 8'h55) begin
    $display("ERROR: Expected 0x55, got 0x%h", dataOut);
    $finish;
end

// SystemVerilog断言
assert (dataOut == 8'h55) else $error("Mismatch!");

// 检查范围
if (counter >= 0 && counter <= 10) begin
    $display("PASS: Counter in range");
end
```

### Chisel
```scala
// 使用 expect（推荐）
dut.io.dataOut.expect(0x55.U)
dut.io.dataOut.expect(0x55.U, "Expected 0x55")

// 使用 peek + assert
val output = dut.io.dataOut.peek()
assert(output.litValue == 0x55, s"Expected 0x55, got 0x${output.litValue.toHexString}")

// 使用 ScalaTest matchers
output.litValue should be (0x55)
output.litValue should be >= 0
output.litValue should be <= 10

// 布尔检查
dut.io.valid.expect(true.B)
dut.io.ready.expect(false.B)
```

---

## 测试用例组织

### Verilog
```verilog
module tb;
    // 测试1：基本功能
    initial begin
        test_basic();
    end
    
    // 测试2：边界条件
    initial begin
        #100;
        test_edge_cases();
    end
    
    task test_basic;
        begin
            dataIn = 0;
            #10;
            // ...
        end
    endtask
    
    task test_edge_cases;
        begin
            dataIn = 8'hFF;
            #10;
            // ...
        end
    endtask
endmodule
```

### Chisel
```scala
class MyModuleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MyModule"
  
  // 测试1：基本功能
  it should "handle basic operations" in {
    test(new MyModule) { dut =>
      testBasic(dut)
    }
  }
  
  // 测试2：边界条件
  it should "handle edge cases" in {
    test(new MyModule) { dut =>
      testEdgeCases(dut)
    }
  }
  
  // 辅助函数
  def testBasic(dut: MyModule): Unit = {
    dut.io.dataIn.poke(0.U)
    dut.clock.step(1)
    // ...
  }
  
  def testEdgeCases(dut: MyModule): Unit = {
    dut.io.dataIn.poke(0xFF.U)
    dut.clock.step(1)
    // ...
  }
}
```

---

## 显示和打印

### Verilog
```verilog
// 简单打印
$display("Test started");
$display("Value = %d", value);
$display("Hex = 0x%h, Binary = %b", hex_val, bin_val);

// 格式化输出
$write("Counter: %d ", counter);
$monitor("Time=%0t clk=%b data=%h", $time, clk, data);

// 时间戳
$display("Time=%0t: Data=%h", $time, data);
```

### Chisel
```scala
// 简单打印
println("Test started")
println(s"Value = ${value}")

// 格式化输出
val hexVal = dut.io.data.peek()
println(f"Hex = 0x${hexVal.litValue}%02x")
println(f"Binary = ${hexVal.litValue.toBinaryString}")

// 使用 ScalaTest
info("Test started")
info(s"Counter: ${counter}")

// 时间戳（使用步数）
var step = 0
dut.clock.step(1)
step += 1
println(s"Step $step: Data = ${dut.io.data.peek()}")
```

---

## 常用测试模式

### 1. 复位测试

#### Verilog
```verilog
initial begin
    rst = 1;
    #20;
    rst = 0;
    #10;
    // 检查复位后的状态
    if (counter != 0) $error("Reset failed");
end
```

#### Chisel
```scala
test(new MyModule) { dut =>
  // 复位
  dut.reset.poke(true.B)
  dut.clock.step(2)
  dut.reset.poke(false.B)
  dut.clock.step(1)
  
  // 检查复位后的状态
  dut.io.counter.expect(0.U)
}
```

---

### 2. 遍历所有输入组合

#### Verilog
```verilog
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        dataIn = i[7:0];
        #10;
        $display("Input=%d, Output=%d", dataIn, dataOut);
    end
end
```

#### Chisel
```scala
test(new MyModule) { dut =>
  for (i <- 0 until 256) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
    println(s"Input=$i, Output=${dut.io.dataOut.peek()}")
  }
}
```

---

## 循环测试详解

Chisel测试**完全支持Scala的循环语法**，可以进行非常灵活的测试。

### 1. for循环的多种形式

#### 基本for循环
```scala
test(new MyModule) { dut =>
  // 方式1：标准范围循环
  for (i <- 0 until 10) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  // 方式2：包含上界（0到10，包括10）
  for (i <- 0 to 10) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  // 方式3：指定步长
  for (i <- 0 until 100 by 5) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  // 方式4：倒序循环
  for (i <- 10 to 0 by -1) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
}
```

#### 嵌套循环（多维输入测试）
```scala
test(new TwoDimensionalModule) { dut =>
  // 测试所有输入组合
  for (x <- 0 until 16) {
    for (y <- 0 until 16) {
      dut.io.inputX.poke(x.U)
      dut.io.inputY.poke(y.U)
      dut.clock.step(1)
      
      val result = dut.io.output.peek()
      println(s"X=$x, Y=$y, Output=$result")
    }
  }
}
```

#### 遍历集合
```scala
test(new MyModule) { dut =>
  // 遍历序列
  val testValues = Seq(0, 1, 5, 10, 100, 255)
  for (value <- testValues) {
    dut.io.dataIn.poke(value.U)
    dut.clock.step(1)
    println(s"Testing value: $value")
  }
  
  // 遍历元组（输入-期望输出对）
  val testCases = Seq(
    (0, 0),
    (1, 2),
    (2, 4),
    (3, 6)
  )
  for ((input, expected) <- testCases) {
    dut.io.dataIn.poke(input.U)
    dut.clock.step(1)
    dut.io.dataOut.expect(expected.U)
  }
  
  // 带索引的遍历
  for ((value, index) <- testValues.zipWithIndex) {
    dut.io.dataIn.poke(value.U)
    dut.clock.step(1)
    println(s"Test $index: value=$value")
  }
}
```

---

### 2. while循环（条件循环）

```scala
test(new MyModule) { dut =>
  // 等待ready信号
  var timeout = 0
  while (!dut.io.ready.peek().litToBoolean && timeout < 100) {
    dut.clock.step(1)
    timeout += 1
  }
  assert(timeout < 100, "Timeout waiting for ready")
  
  // 持续发送数据直到done
  var counter = 0
  dut.io.start.poke(true.B)
  while (!dut.io.done.peek().litToBoolean) {
    dut.io.dataIn.poke(counter.U)
    dut.clock.step(1)
    counter += 1
    assert(counter < 1000, "Too many iterations")
  }
}
```

---

### 3. foreach循环（函数式风格）

```scala
test(new MyModule) { dut =>
  // 对每个元素执行操作
  (0 until 10).foreach { i =>
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  // 复杂测试用例
  val testData = Seq(
    ("Test 1", 0x12, 0x34),
    ("Test 2", 0x56, 0x78),
    ("Test 3", 0xAB, 0xCD)
  )
  
  testData.foreach { case (name, input, expected) =>
    println(s"Running $name")
    dut.io.dataIn.poke(input.U)
    dut.clock.step(1)
    dut.io.dataOut.expect(expected.U)
  }
}
```

---

### 4. 高级循环模式

#### 带条件过滤的循环
```scala
test(new MyModule) { dut =>
  // 只测试偶数
  for (i <- 0 until 100 if i % 2 == 0) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  // 多个条件
  for {
    i <- 0 until 10
    j <- 0 until 10
    if i + j < 15  // 过滤条件
  } {
    dut.io.inputX.poke(i.U)
    dut.io.inputY.poke(j.U)
    dut.clock.step(1)
  }
}
```

#### 使用map和filter
```scala
test(new MyModule) { dut =>
  // 生成测试数据
  val testInputs = (0 until 100)
    .filter(_ % 3 == 0)  // 只保留3的倍数
    .map(_ * 2)          // 每个值乘以2
  
  testInputs.foreach { value =>
    dut.io.dataIn.poke(value.U)
    dut.clock.step(1)
  }
}
```

---

### 5. 实用循环测试示例

#### 示例1：穷举测试（适用于小位宽输入）
```scala
class ExhaustiveTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU"
  
  it should "test all possible 3-bit input combinations" in {
    test(new ALU(3)) { dut =>
      // 测试所有可能的a, b, op组合
      for (a <- 0 until 8) {
        for (b <- 0 until 8) {
          for (op <- 0 until 4) {
            dut.io.a.poke(a.U)
            dut.io.b.poke(b.U)
            dut.io.op.poke(op.U)
            dut.clock.step(1)
            
            // 计算期望值
            val expected = op match {
              case 0 => a + b
              case 1 => a - b
              case 2 => a & b
              case 3 => a | b
            }
            
            dut.io.result.expect((expected & 0x7).U)
          }
        }
      }
      println("Exhaustive test completed: 8×8×4 = 256 cases tested")
    }
  }
}
```

#### 示例2：边界值测试
```scala
class BoundaryTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Multiplier"
  
  it should "handle boundary values correctly" in {
    test(new Multiplier(8)) { dut =>
      val boundaryValues = Seq(
        0,      // 最小值
        1,      // 最小正数
        127,    // 最大正数（8位有符号）
        128,    // 中点
        255     // 最大值（8位无符号）
      )
      
      for (a <- boundaryValues) {
        for (b <- boundaryValues) {
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step(1)
          
          val expected = (a * b) & 0xFFFF  // 16位结果
          dut.io.result.expect(expected.U)
          println(s"$a × $b = $expected ✓")
        }
      }
    }
  }
}
```

#### 示例3：压力测试（大量随机数据）
```scala
import scala.util.Random

class StressTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "DataPath"
  
  it should "handle 10000 random inputs" in {
    test(new DataPath) { dut =>
      val rand = new Random(42)
      val iterations = 10000
      
      for (i <- 0 until iterations) {
        val input = rand.nextInt(256)
        dut.io.dataIn.poke(input.U)
        dut.clock.step(1)
        
        // 每1000次打印进度
        if (i % 1000 == 0) {
          println(s"Progress: $i/$iterations")
        }
      }
      
      println(s"Stress test completed: $iterations iterations")
    }
  }
}
```

#### 示例4：波形测试（预定义序列）
```scala
class WaveformTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Filter"
  
  it should "process input waveform correctly" in {
    test(new Filter) { dut =>
      // 定义输入波形和期望输出
      val waveform = Seq(
        (0, 0),     // (input, expected_output)
        (10, 2),
        (20, 8),
        (30, 18),
        (40, 32),
        (30, 38),
        (20, 40),
        (10, 38),
        (0, 32)
      )
      
      waveform.zipWithIndex.foreach { case ((input, expected), cycle) =>
        dut.io.dataIn.poke(input.U)
        dut.clock.step(1)
        dut.io.dataOut.expect(expected.U, s"Cycle $cycle failed")
        println(f"Cycle $cycle%2d: in=$input%3d, out=$expected%3d ✓")
      }
    }
  }
}
```

#### 示例5：多阶段流水线测试
```scala
class PipelineTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Pipeline"
  
  it should "correctly process data through 3-stage pipeline" in {
    test(new Pipeline(stages = 3)) { dut =>
      val testData = (0 until 10).toSeq
      
      // 填充流水线
      for (i <- testData) {
        dut.io.dataIn.poke(i.U)
        dut.clock.step(1)
      }
      
      // 等待流水线完成（stages个周期）
      dut.io.dataIn.poke(0.U)
      for (_ <- 0 until 3) {
        dut.clock.step(1)
      }
      
      // 验证输出（需要根据流水线逻辑）
      println("Pipeline test completed")
    }
  }
  
  it should "handle continuous data stream" in {
    test(new Pipeline(stages = 3)) { dut =>
      val inputData = (0 until 100).toSeq
      val outputData = scala.collection.mutable.ArrayBuffer[BigInt]()
      
      // 持续发送和接收数据
      for (i <- 0 until 100 + 3) {  // +3 for pipeline latency
        // 发送数据
        if (i < 100) {
          dut.io.dataIn.poke(inputData(i).U)
        } else {
          dut.io.dataIn.poke(0.U)
        }
        
        dut.clock.step(1)
        
        // 接收数据（从第3个周期开始有效）
        if (i >= 3) {
          outputData += dut.io.dataOut.peek().litValue
        }
      }
      
      // 验证结果
      assert(outputData.length == 100, "Output count mismatch")
      println(s"Processed ${outputData.length} items through pipeline")
    }
  }
}
```

#### 示例6：超时保护循环
```scala
class TimeoutTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "StateMachine"
  
  it should "complete within timeout" in {
    test(new StateMachine) { dut =>
      dut.io.start.poke(true.B)
      dut.clock.step(1)
      dut.io.start.poke(false.B)
      
      var cycles = 0
      val maxCycles = 1000
      var done = false
      
      while (!done && cycles < maxCycles) {
        dut.clock.step(1)
        cycles += 1
        done = dut.io.done.peek().litToBoolean
        
        // 每100个周期打印进度
        if (cycles % 100 == 0) {
          println(s"Waiting... $cycles cycles")
        }
      }
      
      assert(done, s"State machine did not complete in $maxCycles cycles")
      println(s"State machine completed in $cycles cycles")
    }
  }
}
```

---

### 6. 循环测试的最佳实践

#### ✅ 推荐做法

1. **使用范围循环而非while**（更安全）
```scala
// 推荐
for (i <- 0 until maxIterations) {
  // test code
}

// 不推荐（可能死循环）
var i = 0
while (i < maxIterations) {
  // test code
  i += 1
}
```

2. **添加超时保护**
```scala
var timeout = 0
while (condition && timeout < MAX_TIMEOUT) {
  dut.clock.step(1)
  timeout += 1
}
assert(timeout < MAX_TIMEOUT, "Test timeout")
```

3. **使用有意义的测试数据**
```scala
val testCases = Seq(
  ("zero", 0, 0),
  ("max", 255, 255),
  ("middle", 128, 128)
)

testCases.foreach { case (name, input, expected) =>
  println(s"Testing: $name")
  // test code
}
```

4. **打印进度信息**
```scala
for (i <- 0 until largeNumber) {
  if (i % 100 == 0) println(s"Progress: $i/$largeNumber")
  // test code
}
```

5. **使用函数封装重复逻辑**
```scala
def testValue(dut: MyModule, input: Int, expected: Int): Unit = {
  dut.io.dataIn.poke(input.U)
  dut.clock.step(1)
  dut.io.dataOut.expect(expected.U)
}

for (i <- 0 until 100) {
  testValue(dut, i, i * 2)
}
```

#### ❌ 避免做法

1. **避免无限循环**
```scala
// 危险！
while (true) {
  dut.clock.step(1)
  if (someCondition) break  // break在Scala中不推荐
}
```

2. **避免过度嵌套**
```scala
// 不好（难以阅读）
for (a <- 0 until 10) {
  for (b <- 0 until 10) {
    for (c <- 0 until 10) {
      for (d <- 0 until 10) {
        // 太深了！
      }
    }
  }
}
```

3. **避免循环内的大量打印**
```scala
// 不好（输出过多）
for (i <- 0 until 10000) {
  println(s"Testing $i")  // 会打印10000行！
}

// 好
for (i <- 0 until 10000) {
  if (i % 1000 == 0) println(s"Progress: $i/10000")
}
```

---

### 7. 循环性能优化

```scala
// 预计算测试数据（避免循环内重复计算）
val testData = (0 until 1000).map { i =>
  val input = someComplexCalculation(i)
  val expected = anotherComplexCalculation(i)
  (input, expected)
}

// 然后快速测试
testData.foreach { case (input, expected) =>
  dut.io.dataIn.poke(input.U)
  dut.clock.step(1)
  dut.io.dataOut.expect(expected.U)
}
```

---

## 总结：Chisel循环测试的优势

| 特性 | Verilog | Chisel |
|------|---------|--------|
| 循环语法 | `for (i=0; i<N; i++)` | `for (i <- 0 until N)` |
| 遍历集合 | 需要数组+索引 | `foreach`, `map`, `filter` |
| 条件循环 | `while` | `while` + 超时保护 |
| 嵌套循环 | 支持但语法繁琐 | 简洁的for表达式 |
| 函数式编程 | 不支持 | 完全支持 |
| 类型安全 | 弱类型 | 强类型检查 |
| 测试数据组织 | 困难 | Seq, Map等数据结构 |

**Chisel的优势**：
- ✅ 使用Scala完整的循环和集合功能
- ✅ 类型安全，编译期检查错误
- ✅ 可以使用函数式编程风格
- ✅ 更好的代码组织和可读性
- ✅ 强大的集合操作（map, filter, foreach等）

---

## 波形生成与查看

Chisel 测试可以生成 VCD (Value Change Dump) 波形文件，用于调试和波形查看。

### Verilog 波形生成
```verilog
module tb;
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
        // 测试代码...
        #1000;
        $finish;
    end
endmodule
```

### Chisel 波形生成

#### 方法1：使用 WriteVcdAnnotation（推荐）

```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MyModuleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MyModule"
  
  it should "generate waveform" in {
    test(new MyModule)
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // 测试代码
      dut.io.dataIn.poke(0x12.U)
      dut.clock.step(1)
      
      dut.io.dataIn.poke(0x34.U)
      dut.clock.step(1)
      
      dut.io.dataIn.poke(0x56.U)
      dut.clock.step(1)
    }
  }
}
```

#### 方法2：使用命令行参数

运行测试时添加参数：
```bash
sbt "testOnly mypackage.MyModuleTest -- -DwriteVcd=1"
```

#### 方法3：在 test() 中指定

```scala
test(new MyModule).withAnnotations(Seq(
  WriteVcdAnnotation,
  VerilatorBackendAnnotation  // 使用 Verilator 后端
)) { dut =>
  // 测试代码
}
```

---

### 波形文件位置

生成的 VCD 文件默认保存在：
```
test_run_dir/<测试类名>/<测试用例名>/
```

例如：
```
test_run_dir/MyModule_should_generate_waveform/MyModule.vcd
```

---

### 查看波形文件

#### 1. 使用 GTKWave（推荐）

**安装 GTKWave：**
```bash
# Ubuntu/Debian
sudo apt-get install gtkwave

# Arch Linux
sudo pacman -S gtkwave

# macOS
brew install gtkwave
```

**打开波形：**
```bash
gtkwave test_run_dir/MyModule_should_generate_waveform/MyModule.vcd
```

**快速查看最新生成的波形：**
```bash
# 查找最新的 vcd 文件
find test_run_dir -name "*.vcd" -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" " | xargs gtkwave
```

#### 2. 使用在线波形查看器

- [WaveTrace](https://wavetrace.io/) - 在线 VCD 查看器
- [WaveJSON Editor](https://wavedrom.com/editor.html) - 需要转换格式

#### 3. 使用 VSCode 插件

安装 "WaveTrace" 或 "Digital Timing Diagram" 插件，直接在 VSCode 中查看。

---

### 选择记录特定信号

默认情况下，Chisel 会记录模块的**所有信号**到 VCD 文件中。但在大型设计中，你可能只想记录特定的信号以减小文件大小和提高性能。

#### 方法1：在 Chisel 代码中使用 printf 调试（不生成波形）

如果你只想观察某些信号的值变化，可以使用 `printf`：

```scala
class MyModule extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(32.W))
    val dataOut = Output(UInt(32.W))
  })
  
  val reg = RegInit(0.U(32.W))
  reg := io.dataIn
  io.dataOut := reg
  
  // 打印特定信号（仅在仿真时）
  when(io.dataIn > 100.U) {
    printf(p"[Cycle ${chisel3.util.log2Up(100)}] dataIn=${io.dataIn}, reg=${reg}\n")
  }
}
```

#### 方法2：使用 chisel3.experimental.annotate（高级）

可以使用注解来标记想要记录的信号：

```scala
import chisel3._
import chisel3.experimental.{annotate, ChiselAnnotation}
import firrtl.annotations.Annotation

class MyModule extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(32.W))
    val result = Output(UInt(32.W))
    val debug = Output(UInt(32.W))
  })
  
  val internalReg = RegInit(0.U(32.W))
  
  // 标记想要在波形中观察的信号
  // 注意：这是高级用法，不是所有后端都支持
  internalReg.suggestName("my_important_reg")
}
```

#### 方法3：在 GTKWave 中过滤显示信号（推荐）

**最实用的方法**是生成完整的 VCD 文件，然后在 GTKWave 中选择性查看信号。

##### GTKWave 使用技巧：

**1. 添加信号到波形窗口**
```
1. 打开 VCD 文件：gtkwave your_file.vcd
2. 左侧 SST (Signal Search Tree) 窗口显示所有信号
3. 选择你想查看的信号
4. 点击 "Append" 或直接拖拽到 Signals 窗口
```

**2. 搜索特定信号**
```
- 在 GTKWave 菜单：Search -> Signal Search
- 输入信号名（支持通配符）
- 例如：io_* 查找所有 io 端口
```

**3. 使用信号过滤器**
```
- Edit -> Data Format -> 选择显示格式（Hex, Binary, Decimal）
- View -> Show/Hide -> 显示/隐藏特定类型的信号
```

**4. 保存信号配置**
```
- File -> Write Save File -> 保存 .gtkw 文件
- 下次打开时自动加载相同的信号配置
```

**示例 GTKWave 配置流程：**
```bash
# 1. 打开波形
gtkwave test_run_dir/ALU_should_correctly_perform_addition/ALU.vcd

# 2. 在 GTKWave 中选择信号（GUI 操作）：
#    - 展开 TOP.ALU 层级
#    - 选择关心的信号：
#      ✓ clock
#      ✓ reset
#      ✓ io_a_in
#      ✓ io_b_in
#      ✓ io_alu_result
#      ✓ io_zero
#      ✗ 不选择内部寄存器（如果不关心）
#
# 3. 保存配置
#    File -> Write Save File (As) -> ALU_debug.gtkw

# 4. 下次直接打开配置
gtkwave test_run_dir/ALU_should_correctly_perform_addition/ALU.vcd ALU_debug.gtkw
```

#### 方法4：创建 GTKWave 配置文件（.gtkw）

你可以手动创建 `.gtkw` 文件来预定义要查看的信号：

**示例 `alu_signals.gtkw`：**
```gtkw
[*]
[*] GTKWave Analyzer v3.3.104 (w)1999-2020 BSI
[*]
[dumpfile] "/path/to/test_run_dir/ALU.vcd"
[savefile] "/path/to/alu_signals.gtkw"
[timestart] 0
[size] 1920 1080
[pos] -1 -1

*-9.000000 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
[sst_width] 250
[signals_width] 200
[sst_expanded] 1
[sst_vpaned] 300

@28
TOP.ALU.clock
TOP.ALU.reset
@22
TOP.ALU.io_a_in[31:0]
TOP.ALU.io_b_in[31:0]
TOP.ALU.io_alu_ctrl_in[4:0]
TOP.ALU.io_alu_result[31:0]
@28
TOP.ALU.io_zero
TOP.ALU.io_cout
TOP.ALU.io_overflow
@22
TOP.ALU.io_branch_taken[2:0]
@28
TOP.ALU.io_tick_idex
[pattern_trace] 1
[pattern_trace] 0
```

**使用配置文件：**
```bash
gtkwave test_run_dir/ALU_should_correctly_perform_addition/ALU.vcd alu_signals.gtkw
```

#### 方法5：编程方式筛选 VCD 文件（Python）

如果你想自动化处理，可以使用 Python 脚本筛选 VCD 信号：

```python
#!/usr/bin/env python3
# filter_vcd.py - 筛选 VCD 文件中的特定信号

import sys
import re

def filter_vcd(input_file, output_file, signals_to_keep):
    """
    从 VCD 文件中只保留指定的信号
    
    Args:
        input_file: 输入 VCD 文件路径
        output_file: 输出 VCD 文件路径
        signals_to_keep: 要保留的信号名列表（支持正则表达式）
    """
    with open(input_file, 'r') as fin, open(output_file, 'w') as fout:
        in_var_section = False
        var_symbols = {}  # {symbol: signal_name}
        keep_symbols = set()
        
        for line in fin:
            # 解析变量定义部分
            if line.startswith('$var'):
                in_var_section = True
                parts = line.split()
                if len(parts) >= 5:
                    symbol = parts[3]
                    signal_name = parts[4]
                    var_symbols[symbol] = signal_name
                    
                    # 检查是否匹配要保留的信号
                    for pattern in signals_to_keep:
                        if re.search(pattern, signal_name):
                            keep_symbols.add(symbol)
                            fout.write(line)
                            break
            elif line.startswith('$enddefinitions'):
                in_var_section = False
                fout.write(line)
            elif in_var_section:
                fout.write(line)
            else:
                # 数据部分：只保留选定信号的变化
                if line.startswith('#'):
                    # 时间戳，总是保留
                    fout.write(line)
                elif len(line.strip()) > 0:
                    # 信号值变化
                    symbol = line.strip()[-1] if len(line.strip()) > 1 else None
                    if symbol in keep_symbols or line.startswith('$'):
                        fout.write(line)

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python3 filter_vcd.py input.vcd output.vcd [signal_patterns...]")
        print("Example: python3 filter_vcd.py ALU.vcd ALU_filtered.vcd 'io_.*' 'clock' 'reset'")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    signals = sys.argv[3:] if len(sys.argv) > 3 else ['io_.*', 'clock', 'reset']
    
    print(f"Filtering {input_file} -> {output_file}")
    print(f"Keeping signals matching: {signals}")
    
    filter_vcd(input_file, output_file, signals)
    print("Done!")
```

**使用示例：**
```bash
# 只保留 io 端口和时钟信号
python3 filter_vcd.py \
    test_run_dir/ALU_should_correctly_perform_addition/ALU.vcd \
    ALU_filtered.vcd \
    'io_.*' 'clock' 'reset'

# 查看筛选后的波形（文件更小，加载更快）
gtkwave ALU_filtered.vcd
```

#### 信号命名技巧

为了方便在波形中识别信号，给重要的内部信号命名：

```scala
class ALU extends Module {
  val io = IO(new Bundle {
    val a_in = Input(UInt(32.W))
    val b_in = Input(UInt(32.W))
    val result = Output(UInt(32.W))
  })
  
  // 使用 suggestName 给信号命名
  val internalSum = Wire(UInt(33.W))
  internalSum.suggestName("internal_sum")
  
  val carryBit = Wire(Bool())
  carryBit.suggestName("carry_bit")
  
  // 这些名字会在 VCD 文件中显示
  internalSum := io.a_in +& io.b_in
  carryBit := internalSum(32)
  io.result := internalSum(31, 0)
}
```

#### 最佳实践总结

| 需求 | 推荐方法 | 优点 |
|------|---------|------|
| 快速调试几个值 | `printf` | 简单快速，不需要波形查看器 |
| 调试复杂时序 | 完整 VCD + GTKWave 过滤 | 可以看到所有信号，事后筛选 |
| 减小 VCD 文件 | Python 脚本筛选 | 自动化，可复用 |
| 团队协作 | 保存 .gtkw 配置 | 统一的信号查看配置 |
| 性能测试 | 不生成波形 | 最快的测试速度 |

**推荐工作流程：**
```bash
# 1. 开发阶段：生成完整波形
make test-only TEST=scpu.alu_test

# 2. 用 GTKWave 查看并选择关心的信号

# 3. 保存配置文件 (File -> Write Save File)
# 保存为: debug_configs/alu_debug.gtkw

# 4. 下次快速打开
gtkwave test_run_dir/ALU_should_correctly_perform_addition/ALU.vcd \
         debug_configs/alu_debug.gtkw

# 5. 或者创建 Makefile 快捷方式
make view-alu  # 自动加载配置
```

---

### 完整的波形生成示例

```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUWaveformTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU with Waveform"
  
  it should "generate comprehensive waveform" in {
    test(new ALU)
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      println("Generating waveform...")
      
      // 复位阶段
      dut.reset.poke(true.B)
      dut.clock.step(2)
      dut.reset.poke(false.B)
      dut.clock.step(1)
      
      // 测试各种操作
      val testCases = Seq(
        ("ADD", "b00000".U, 10, 20, 30),
        ("SUB", "b00001".U, 30, 10, 20),
        ("AND", "b00011".U, 0xFF, 0x0F, 0x0F),
        ("OR",  "b00100".U, 0xF0, 0x0F, 0xFF),
        ("XOR", "b00101".U, 0xFF, 0xAA, 0x55)
      )
      
      testCases.foreach { case (name, op, a, b, expected) =>
        println(s"Testing $name: $a op $b = $expected")
        
        dut.io.alu_ctrl_in.poke(op)
        dut.io.a_in.poke(a.U)
        dut.io.b_in.poke(b.U)
        dut.io.tick_idex.poke(true.B)
        dut.clock.step(1)
        
        dut.io.tick_idex.poke(false.B)
        dut.clock.step(1)
        
        dut.io.alu_result.expect(expected.U, s"$name failed")
        dut.clock.step(1)
      }
      
      println("Waveform generation complete!")
      println("VCD file location: test_run_dir/ALU_with_Waveform_should_generate_comprehensive_waveform/")
    }
  }
}
```

---

### 高级波形配置

#### 1. 指定波形深度

```scala
import chiseltest.simulator.WriteVcdAnnotation

test(new MyModule).withAnnotations(Seq(
  WriteVcdAnnotation
)) { dut =>
  // 只记录前100个周期
  for (i <- 0 until 100) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
}
```

#### 2. 条件生成波形

```scala
class ConditionalWaveformTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MyModule"
  
  it should "generate waveform only when needed" in {
    val generateWaveform = true  // 通过变量控制
    
    val annotations = if (generateWaveform) {
      Seq(WriteVcdAnnotation)
    } else {
      Seq.empty
    }
    
    test(new MyModule).withAnnotations(annotations) { dut =>
      // 测试代码
    }
  }
}
```

#### 3. 自定义波形文件名

通过环境变量或系统属性：
```scala
// 在测试前设置
System.setProperty("writeVcd", "1")
```

---

### 波形生成最佳实践

#### ✅ 推荐做法

1. **开发阶段生成波形**
```scala
it should "debug with waveform" in {
  test(new MyModule)
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
    // 调试时生成波形
  }
}
```

2. **使用有意义的测试名称**
```scala
it should "test_ALU_addition_with_overflow" in {
  // 测试名会成为文件夹名，方便识别
}
```

3. **添加打印信息**
```scala
test(new MyModule)
  .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  println("=" * 50)
  println("波形文件将保存到: test_run_dir/...")
  println("=" * 50)
  
  // 测试代码
  
  println("波形生成完成！使用以下命令查看：")
  println("gtkwave test_run_dir/<path>/MyModule.vcd")
}
```

4. **限制波形时长**
```scala
// 只记录关键部分
test(new MyModule)
  .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  
  // 初始化（不重要，快速跳过）
  for (_ <- 0 until 100) {
    dut.clock.step(1)
  }
  
  // 关键测试部分（这里会在波形中显示）
  dut.io.start.poke(true.B)
  for (i <- 0 until 50) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
}
```

#### ❌ 避免的做法

1. **不要在性能测试中生成波形**
```scala
// ❌ 错误：生成波形会严重拖慢大量循环测试
it should "performance test" in {
  test(new MyModule)
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
    for (i <- 0 until 1000000) {  // 100万次迭代 + 波形 = 很慢
      dut.clock.step(1)
    }
  }
}

// ✅ 正确：性能测试不生成波形
it should "performance test" in {
  test(new MyModule) { dut =>
    for (i <- 0 until 1000000) {
      dut.clock.step(1)
    }
  }
}
```

2. **不要在 CI/CD 中默认生成波形**
```scala
// 使用环境变量控制
val shouldGenerateWaveform = System.getenv("GENERATE_VCD") == "1"

val annotations = if (shouldGenerateWaveform) {
  Seq(WriteVcdAnnotation)
} else {
  Seq.empty
}
```

---

### 波形调试技巧

#### 1. 标记关键时刻

```scala
test(new MyModule)
  .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  
  println(">>> PHASE 1: Initialization")
  dut.reset.poke(true.B)
  dut.clock.step(2)
  
  println(">>> PHASE 2: Normal Operation")
  dut.reset.poke(false.B)
  for (i <- 0 until 10) {
    dut.io.dataIn.poke(i.U)
    dut.clock.step(1)
  }
  
  println(">>> PHASE 3: Edge Cases")
  dut.io.dataIn.poke(0xFF.U)
  dut.clock.step(1)
}
```

#### 2. 对比测试

```scala
it should "compare two implementations" in {
  test(new MyModuleV1)
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
    // 测试版本1
  }
  
  test(new MyModuleV2)
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
    // 测试版本2，使用相同的激励
  }
  
  // 然后在 GTKWave 中同时打开两个 VCD 文件对比
}
```

#### 3. 快速查找波形脚本

创建 `view_wave.sh`：
```bash
#!/bin/bash
# 查找并打开最新的波形文件

LATEST_VCD=$(find test_run_dir -name "*.vcd" -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")

if [ -z "$LATEST_VCD" ]; then
    echo "No VCD file found!"
    exit 1
fi

echo "Opening: $LATEST_VCD"
gtkwave "$LATEST_VCD" &
```

使用：
```bash
chmod +x view_wave.sh
./view_wave.sh
```

---

### Makefile 集成

```makefile
# 在你的 Makefile 中添加

.PHONY: test test-wave view-wave clean-wave

# 普通测试（不生成波形）
test:
	sbt test

# 生成波形的测试
test-wave:
	sbt "testOnly $(TEST) -- -DwriteVcd=1"

# 查看最新波形
view-wave:
	@LATEST=$$(find test_run_dir -name "*.vcd" -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "); \
	if [ -z "$$LATEST" ]; then \
		echo "No VCD file found!"; \
	else \
		echo "Opening: $$LATEST"; \
		gtkwave "$$LATEST" & \
	fi

# 清理波形文件
clean-wave:
	rm -rf test_run_dir

# 运行特定测试并查看波形
test-and-view:
	sbt "testOnly $(TEST)" && $(MAKE) view-wave
```

使用示例：
```bash
# 运行测试并生成波形
make test-wave TEST=scpu.alu_test

# 查看最新波形
make view-wave

# 运行测试并自动打开波形
make test-and-view TEST=scpu.alu_test

# 清理所有波形
make clean-wave
```

---

### 3. 随机测试

#### Verilog
```verilog
integer i;
reg [7:0] random_val;
initial begin
    for (i = 0; i < 100; i = i + 1) begin
        random_val = $random;
        dataIn = random_val;
        #10;
    end
end
```

#### Chisel
```scala
import scala.util.Random

test(new MyModule) { dut =>
  val rand = new Random(42)  // 固定种子以便复现
  for (_ <- 0 until 100) {
    val randomVal = rand.nextInt(256)
    dut.io.dataIn.poke(randomVal.U)
    dut.clock.step(1)
  }
}
```

---

### Chisel 随机数详解

#### 基本随机数生成
```scala
import scala.util.Random

test(new MyModule) { dut =>
  val rand = new Random()  // 使用系统时间作为种子
  
  // 生成 0 到 255 的随机整数
  val randomByte = rand.nextInt(256)
  dut.io.data8.poke(randomByte.U(8.W))
  
  // 生成 0 到 2^32-1 的随机整数
  val random32 = rand.nextLong() & 0xFFFFFFFFL
  dut.io.data32.poke(random32.U(32.W))
  
  // 生成随机布尔值
  val randomBool = rand.nextBoolean()
  dut.io.enable.poke(randomBool.B)
}
```

#### 固定种子（可复现测试）
```scala
test(new MyModule) { dut =>
  val rand = new Random(42)  // 固定种子，每次运行结果相同
  
  for (i <- 0 until 100) {
    val randomVal = rand.nextInt(1024)
    dut.io.dataIn.poke(randomVal.U)
    dut.clock.step(1)
  }
}
```

#### 指定范围的随机数
```scala
test(new MyModule) { dut =>
  val rand = new Random()
  
  // 生成 10 到 50 之间的随机数
  val randomInRange = 10 + rand.nextInt(41)  // 41 = 50 - 10 + 1
  dut.io.value.poke(randomInRange.U)
  
  // 生成 -100 到 100 之间的随机数
  val randomSigned = -100 + rand.nextInt(201)
  dut.io.signedValue.poke(randomSigned.S(16.W))
}
```

#### 随机数组/序列
```scala
test(new MyModule) { dut =>
  val rand = new Random(123)
  
  // 生成100个随机数
  val randomData = Seq.fill(100)(rand.nextInt(256))
  
  // 测试每个随机数
  randomData.zipWithIndex.foreach { case (value, index) =>
    dut.io.dataIn.poke(value.U)
    dut.clock.step(1)
    println(s"Test $index: input=$value")
  }
}
```

#### 随机测试常用模式

**1. 穷举 vs 随机测试**
```scala
class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU"
  
  // 小位宽：穷举测试
  it should "test all 8-bit combinations" in {
    test(new ALU(8)) { dut =>
      for (a <- 0 until 256; b <- 0 until 256) {
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.clock.step(1)
        // 验证
      }
    }
  }
  
  // 大位宽：随机测试
  it should "test 32-bit with random values" in {
    test(new ALU(32)) { dut =>
      val rand = new Random(42)
      
      for (_ <- 0 until 10000) {
        val a = rand.nextLong() & 0xFFFFFFFFL
        val b = rand.nextLong() & 0xFFFFFFFFL
        
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.clock.step(1)
        
        // 验证
        val expected = (a + b) & 0xFFFFFFFFL
        dut.io.result.expect(expected.U)
      }
    }
  }
}
```

**2. 边界值 + 随机测试**
```scala
test(new MyModule) { dut =>
  val rand = new Random(42)
  
  // 测试边界值
  val boundaryValues = Seq(0, 1, 127, 128, 255)
  boundaryValues.foreach { value =>
    dut.io.dataIn.poke(value.U)
    dut.clock.step(1)
  }
  
  // 然后随机测试
  for (_ <- 0 until 1000) {
    val randomVal = rand.nextInt(256)
    dut.io.dataIn.poke(randomVal.U)
    dut.clock.step(1)
  }
}
```

**3. 随机操作序列测试**
```scala
test(new StateMachine) { dut =>
  val rand = new Random(42)
  
  for (_ <- 0 until 100) {
    // 随机选择操作
    val operation = rand.nextInt(4) match {
      case 0 => "b00".U  // ADD
      case 1 => "b01".U  // SUB
      case 2 => "b10".U  // MUL
      case 3 => "b11".U  // DIV
    }
    
    val a = rand.nextInt(256)
    val b = rand.nextInt(256) + 1  // 避免除以0
    
    dut.io.op.poke(operation)
    dut.io.a.poke(a.U)
    dut.io.b.poke(b.U)
    dut.clock.step(1)
    
    println(s"Op=$operation, a=$a, b=$b")
  }
}
```

**4. 完整的随机测试示例**
```scala
import scala.util.Random

class RandomALUTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU Random Test"
  
  it should "handle 10000 random operations correctly" in {
    test(new ALU) { dut =>
      val rand = new Random(42)
      var passCount = 0
      var failCount = 0
      
      for (testNum <- 0 until 10000) {
        // 生成随机输入
        val a = rand.nextLong() & 0xFFFFFFFFL
        val b = rand.nextLong() & 0xFFFFFFFFL
        val op = rand.nextInt(5)  // 5种操作
        
        // 应用到DUT
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.io.alu_ctrl.poke(op.U)
        dut.clock.step(1)
        
        // 计算期望值
        val expected = op match {
          case 0 => (a + b) & 0xFFFFFFFFL  // ADD
          case 1 => (a - b) & 0xFFFFFFFFL  // SUB
          case 2 => a & b                   // AND
          case 3 => a | b                   // OR
          case 4 => a ^ b                   // XOR
        }
        
        // 验证
        val result = dut.io.result.peek().litValue
        if (result == expected) {
          passCount += 1
        } else {
          failCount += 1
          println(f"FAIL #$testNum: op=$op, a=0x$a%08x, b=0x$b%08x")
          println(f"  Expected: 0x$expected%08x, Got: 0x$result%08x")
        }
        
        // 每1000次打印进度
        if ((testNum + 1) % 1000 == 0) {
          println(s"Progress: ${testNum + 1}/10000 (Pass: $passCount, Fail: $failCount)")
        }
      }
      
      println(s"Final: Pass=$passCount, Fail=$failCount")
      assert(failCount == 0, s"$failCount tests failed")
    }
  }
}
```

#### 随机数最佳实践

| 场景 | 推荐方式 |
|------|---------|
| 小位宽输入（<8位） | 穷举测试 |
| 中等位宽（8-16位） | 边界值 + 部分随机 |
| 大位宽（>16位） | 随机测试为主 |
| 回归测试 | 固定种子的随机测试 |
| 探索性测试 | 无种子的随机测试 |

**✅ 推荐**：
- 使用固定种子 `new Random(42)` 以便测试可复现
- 结合边界值测试和随机测试
- 添加进度打印和统计信息
- 保存失败的测试用例

**❌ 避免**：
- 不要只用随机测试，忽略边界值
- 避免生成无效的输入（如除数为0）
- 不要忽略随机测试中的失败用例

---

### 4. 等待条件满足

#### Verilog
```verilog
// 等待信号变为高
wait(ready == 1);

// 等待特定条件，带超时
fork
    begin
        wait(done == 1);
        $display("Done signal received");
    end
    begin
        #1000;
        $error("Timeout!");
    end
join_any
```

#### Chisel
```scala
// 等待信号变为高
var timeout = 0
while (dut.io.ready.peek().litToBoolean == false && timeout < 100) {
  dut.clock.step(1)
  timeout += 1
}
assert(timeout < 100, "Timeout waiting for ready")

// 或使用 timescope
dut.io.ready.expect(true.B)  // 会立即检查
```

---

### 5. 测试时序逻辑

#### Verilog
```verilog
initial begin
    // 写入
    dataIn = 8'h12;
    @(posedge clk);
    
    // 下一个周期检查
    @(posedge clk);
    if (dataOut != 8'h12) $error("Timing error");
end
```

#### Chisel
```scala
test(new MyModule) { dut =>
  // 写入
  dut.io.dataIn.poke(0x12.U)
  dut.clock.step(1)
  
  // 下一个周期检查
  dut.clock.step(1)
  dut.io.dataOut.expect(0x12.U)
}
```

---

## 完整示例

### 示例1：3-8译码器测试

#### Verilog Testbench
```verilog
module tb_Decoder3to8;
    reg [2:0] sel;
    reg en;
    wire [7:0] out;
    
    Decoder3to8 dut (
        .sel(sel),
        .en(en),
        .out(out)
    );
    
    integer i;
    initial begin
        // 测试使能为0
        en = 0;
        sel = 3'b000;
        #10;
        if (out != 8'b0) $error("Enable test failed");
        
        // 测试所有输入
        en = 1;
        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            #10;
            if (out != (1 << i)) begin
                $error("Decode error at input %d", i);
            end else begin
                $display("PASS: sel=%d, out=%b", sel, out);
            end
        end
        
        $display("All tests passed!");
        $finish;
    end
endmodule
```

#### Chisel Test
```scala
package decoder3to8

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class Decoder3to8Test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Decoder3to8"
  
  it should "output 0 when disabled" in {
    test(new Decoder3to8) { dut =>
      dut.io.en.poke(false.B)
      dut.io.sel.poke(0.U)
      dut.io.out.expect(0.U)
    }
  }
  
  it should "correctly decode all 8 inputs when enabled" in {
    test(new Decoder3to8) { dut =>
      dut.io.en.poke(true.B)
      
      for (i <- 0 until 8) {
        dut.io.sel.poke(i.U)
        val expected = 1 << i
        dut.io.out.expect(expected.U)
        println(s"PASS: sel=$i, out=${expected.toBinaryString}")
      }
    }
  }
  
  it should "correctly handle edge cases" in {
    test(new Decoder3to8) { dut =>
      // 测试最大输入
      dut.io.en.poke(true.B)
      dut.io.sel.poke(7.U)
      dut.io.out.expect("b10000000".U)
      
      // 测试最小输入
      dut.io.sel.poke(0.U)
      dut.io.out.expect("b00000001".U)
    }
  }
}
```

---

### 示例2：8-3优先编码器测试

#### Verilog Testbench
```verilog
module tb_PriorityEncoder;
    reg [7:0] in;
    reg en;
    wire [2:0] out;
    wire valid;
    
    PriorityEncoder8_3 dut (
        .In(in),
        .En(en),
        .Out(out),
        .Val(valid)
    );
    
    initial begin
        // 测试禁用状态
        en = 0;
        in = 8'b11111111;
        #10;
        if (valid != 0) $error("Enable test failed");
        
        // 测试优先级
        en = 1;
        
        // 最高位优先
        in = 8'b10000000; #10;
        if (out != 7 || valid != 1) $error("Priority test 7 failed");
        
        in = 8'b11111111; #10;
        if (out != 7 || valid != 1) $error("Priority test all failed");
        
        in = 8'b00000001; #10;
        if (out != 0 || valid != 1) $error("Priority test 0 failed");
        
        // 测试无输入
        in = 8'b00000000; #10;
        if (valid != 0) $error("No input test failed");
        
        $display("All tests passed!");
        $finish;
    end
endmodule
```

#### Chisel Test
```scala
package PriorityEncoder8_3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PriorityEncoderTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "PriorityEncoder8_3"
  
  it should "output invalid when disabled" in {
    test(new top) { dut =>
      dut.io.En.poke(false.B)
      dut.io.In.poke(0xFF.U)
      dut.io.Val.expect(false.B)
    }
  }
  
  it should "correctly encode highest priority bit" in {
    test(new top) { dut =>
      dut.io.En.poke(true.B)
      
      // 测试每一位单独为1
      for (i <- 0 until 8) {
        val input = 1 << i
        dut.io.In.poke(input.U)
        dut.io.Out.expect(i.U)
        dut.io.Val.expect(true.B)
      }
    }
  }
  
  it should "prioritize higher bits" in {
    test(new top) { dut =>
      dut.io.En.poke(true.B)
      
      // 所有位都是1，应该输出最高位
      dut.io.In.poke(0xFF.U)
      dut.io.Out.expect(7.U)
      dut.io.Val.expect(true.B)
      
      // 最高位有效
      dut.io.In.poke("b10000000".U)
      dut.io.Out.expect(7.U)
      
      // 次高位有效
      dut.io.In.poke("b01000000".U)
      dut.io.Out.expect(6.U)
    }
  }
  
  it should "output invalid when no input" in {
    test(new top) { dut =>
      dut.io.En.poke(true.B)
      dut.io.In.poke(0.U)
      dut.io.Val.expect(false.B)
    }
  }
  
  it should "handle random patterns correctly" in {
    test(new top) { dut =>
      dut.io.En.poke(true.B)
      
      val testCases = Seq(
        (0b10101010, 7),
        (0b01010101, 6),
        (0b00001111, 3),
        (0b00000111, 2),
        (0b00000011, 1),
        (0b00000001, 0)
      )
      
      for ((input, expected) <- testCases) {
        dut.io.In.poke(input.U)
        dut.io.Out.expect(expected.U)
        dut.io.Val.expect(true.B)
        println(s"PASS: input=0b${input.toBinaryString}, output=$expected")
      }
    }
  }
}
```

---

### 示例3：计数器测试

#### Verilog Testbench
```verilog
module tb_Counter;
    reg clk, rst, en;
    wire [7:0] count;
    
    Counter dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .count(count)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        en = 0;
        #20 rst = 0;
        
        // 测试使能
        en = 1;
        repeat(10) @(posedge clk);
        if (count != 10) $error("Count error");
        
        // 测试复位
        rst = 1;
        @(posedge clk);
        if (count != 0) $error("Reset error");
        
        $finish;
    end
endmodule
```

#### Chisel Test
```scala
class CounterTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Counter"
  
  it should "count when enabled" in {
    test(new Counter(8)) { dut =>
      // 复位
      dut.reset.poke(true.B)
      dut.clock.step(1)
      dut.reset.poke(false.B)
      
      // 使能计数
      dut.io.en.poke(true.B)
      for (i <- 0 until 10) {
        dut.clock.step(1)
        dut.io.count.expect((i + 1).U)
      }
    }
  }
  
  it should "hold value when disabled" in {
    test(new Counter(8)) { dut =>
      dut.reset.poke(false.B)
      dut.io.en.poke(true.B)
      dut.clock.step(5)
      
      // 禁用计数
      dut.io.en.poke(false.B)
      val value = dut.io.count.peek()
      dut.clock.step(5)
      dut.io.count.expect(value)
    }
  }
  
  it should "reset to zero" in {
    test(new Counter(8)) { dut =>
      dut.io.en.poke(true.B)
      dut.clock.step(10)
      
      // 复位
      dut.reset.poke(true.B)
      dut.clock.step(1)
      dut.reset.poke(false.B)
      
      dut.io.count.expect(0.U)
    }
  }
}
```

---

## 运行测试

### Verilog
```bash
# 使用 iverilog
iverilog -o tb tb_MyModule.v MyModule.v
vvp tb

# 使用 ModelSim
vlog MyModule.v tb_MyModule.v
vsim -c tb_MyModule -do "run -all; quit"
```

### Chisel
```bash
# 运行所有测试
sbt test

# 运行特定测试类
sbt "testOnly decoder3to8.Decoder3to8Test"

# 运行特定测试用例（匹配测试名称中包含的子串）
# 注意：-z 参数会匹配包含该字符串的所有测试
sbt 'testOnly decoder3to8.Decoder3to8Test -- -z "output 0"'
sbt 'testOnly decoder3to8.Decoder3to8Test -- -z "edge cases"'

# 或者使用通配符匹配测试类
sbt "testOnly *Decoder3to8Test"

# 生成波形文件
sbt "testOnly decoder3to8.Decoder3to8Test -- -DwriteVcd=1"
```

---

## 高级特性

### 1. Fork/Join（并发测试）

#### Chisel
```scala
test(new MyModule) { dut =>
  fork {
    // 线程1：发送数据
    for (i <- 0 until 10) {
      dut.io.dataIn.poke(i.U)
      dut.clock.step(1)
    }
  }.fork {
    // 线程2：接收数据
    for (i <- 0 until 10) {
      dut.io.dataOut.expect(i.U)
      dut.clock.step(1)
    }
  }.join()
}
```

### 2. 超时控制

#### Chisel
```scala
test(new MyModule) { dut =>
  dut.io.start.poke(true.B)
  
  var done = false
  var cycles = 0
  val maxCycles = 100
  
  while (!done && cycles < maxCycles) {
    dut.clock.step(1)
    done = dut.io.done.peek().litToBoolean
    cycles += 1
  }
  
  assert(cycles < maxCycles, "Timeout!")
}
```

### 3. 生成波形文件

在测试中添加：
```scala
test(new MyModule).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  // 测试代码
}
```

或在命令行中：
```bash
sbt "testOnly MyModuleTest -- -DwriteVcd=1"
```

---

## 主要区别总结

| 特性 | Verilog | Chisel |
|------|---------|--------|
| 时钟生成 | 手动生成 | 自动生成 |
| 延迟 | `#10` | `clock.step(1)` |
| 赋值 | `signal = value` | `signal.poke(value)` |
| 读取 | 直接读 | `signal.peek()` |
| 检查 | `if` + `$error` | `expect()` 或 `assert()` |
| 测试框架 | 无标准框架 | ScalaTest |
| 测试组织 | task/function | 函数和测试用例 |
| 断言 | SystemVerilog断言 | ScalaTest matchers |

---

## 最佳实践

1. **使用 expect() 而不是 peek() + assert()**
   ```scala
   // 推荐
   dut.io.out.expect(10.U)
   
   // 不推荐
   assert(dut.io.out.peek().litValue == 10)
   ```

2. **组织测试用例**
   - 每个功能一个测试用例
   - 使用描述性的测试名称
   - 测试边界条件和错误情况

3. **使用辅助函数**
   ```scala
   def setupDUT(dut: MyModule): Unit = {
     dut.reset.poke(true.B)
     dut.clock.step(1)
     dut.reset.poke(false.B)
   }
   ```

4. **添加调试信息**
   ```scala
   println(s"Step $i: input=$input, output=${dut.io.out.peek()}")
   ```

5. **使用有意义的错误消息**
   ```scala
   dut.io.out.expect(expected.U, s"Expected $expected at step $i")
   ```

---

## 更多资源

- [ChiselTest 官方文档](https://github.com/ucb-bar/chiseltest)
- [ScalaTest 文档](https://www.scalatest.org/)
- [Chisel Testing Tutorial](https://github.com/freechipsproject/chisel-bootcamp)

---

**最后更新**: 2025年11月

