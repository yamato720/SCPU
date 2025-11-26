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
- [完整示例](#完整示例)

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

