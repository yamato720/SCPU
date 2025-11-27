package scpu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class bram_8_4096_test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Clock Distribution Example with Dual Port BRAM"

  it should "write and read from port A" in {
    test(new ClockDistributionExample)
    { c =>

      println("测试端口 A 的读写操作（使用 Clock_Generator 分发时钟）")

      // 写入数据到端口 A
      c.io.ena.poke(true.B)
      c.io.wea.poke(true.B)
      c.io.addra.poke(10.U)
      c.io.dina.poke(0xAB.U)
      c.clock.step(1)

      // 读取数据从端口 A
      c.io.wea.poke(false.B)
      c.io.addra.poke(10.U)
      c.clock.step(1)

      // 验证读取的数据
      c.io.douta.expect(0xAB.U, "端口 A 读取失败")
      println("✓ 端口 A 读写测试通过")
    }
  }

  it should "write and read from port B" in {
    test(new ClockDistributionExample)
    { c =>

      println("测试端口 B 的读写操作（使用 Clock_Generator 分发时钟）")

      // 写入数据到端口 B
      c.io.enb.poke(true.B)
      c.io.web.poke(true.B)
      c.io.addrb.poke(20.U)
      c.io.dinb.poke(0xCD.U)
      c.clock.step(1)

      // 读取数据从端口 B
      c.io.web.poke(false.B)
      c.io.addrb.poke(20.U)
      c.clock.step(1)

      c.io.doutb.expect(0xCD.U, "端口 B 读取失败")
      println("✓ 端口 B 读写测试通过")
    }
  }

  it should "support simultaneous access from both ports" in {
    test(new ClockDistributionExample)
    { c =>

      println("测试双端口同时访问（使用 Clock_Generator 分发时钟）")

      // 端口 A 写入地址 100
      c.io.ena.poke(true.B)
      c.io.wea.poke(true.B)
      c.io.addra.poke(100.U)
      c.io.dina.poke(0x12.U)

      // 端口 B 同时写入地址 200
      c.io.enb.poke(true.B)
      c.io.web.poke(true.B)
      c.io.addrb.poke(200.U)
      c.io.dinb.poke(0x34.U)

      c.clock.step(1)

      // 端口 A 读取地址 100
      c.io.wea.poke(false.B)
      c.io.addra.poke(100.U)

      // 端口 B 读取地址 200
      c.io.web.poke(false.B)
      c.io.addrb.poke(200.U)

      c.clock.step(1)

      c.io.douta.expect(0x12.U, "端口 A 同时访问失败")
      c.io.doutb.expect(0x34.U, "端口 B 同时访问失败")
      println("✓ 双端口同时访问测试通过")
    }
  }

  it should "handle cross-port read (write A, read B)" in {
    test(new ClockDistributionExample)
    { c =>

      println("测试交叉端口访问（A写B读，使用 Clock_Generator 分发时钟）")

      val testAddr = 50
      val testData = 0x88

      // 端口 A 写入
      c.io.ena.poke(true.B)
      c.io.wea.poke(true.B)
      c.io.addra.poke(testAddr.U)
      c.io.dina.poke(testData.U)
      c.clock.step(1)

      // 停止写入，等待写入完成
      c.io.wea.poke(false.B)
      c.clock.step(1)

      // 端口 B 读取同一地址
      c.io.enb.poke(true.B)
      c.io.web.poke(false.B)
      c.io.addrb.poke(testAddr.U)
      c.clock.step(1)

      // 再等一个周期，读取数据
      c.clock.step(1)

      c.io.doutb.expect(testData.U, "端口 B 读取端口 A 写入的数据失败")
      println(s"✓ 交叉端口访问测试通过：A写入0x${testData.toHexString}，B成功读取")
    }
  }

  it should "test random read/write operations" in {
    test(new ClockDistributionExample)
    { c =>

      println("执行 100 次随机读写测试（使用 Clock_Generator 分发时钟）")

      val rand = new Random(42)
      val memoryModel = scala.collection.mutable.Map[Int, Int]()

      for (i <- 0 until 100) {
        // 随机选择端口和操作
        val usePortA = rand.nextBoolean()
        val isWrite = rand.nextBoolean()
        val addr = rand.nextInt(4096)
        val data = rand.nextInt(256)

        if (usePortA) {
          c.io.ena.poke(true.B)
          c.io.addra.poke(addr.U)

          if (isWrite) {
            c.io.wea.poke(true.B)
            c.io.dina.poke(data.U)
            memoryModel(addr) = data
          } else {
            c.io.wea.poke(false.B)
          }
        } else {
          c.io.enb.poke(true.B)
          c.io.addrb.poke(addr.U)

          if (isWrite) {
            c.io.web.poke(true.B)
            c.io.dinb.poke(data.U)
            memoryModel(addr) = data
          } else {
            c.io.web.poke(false.B)
          }
        }

        c.clock.step(1)

        // 验证读操作
        if (!isWrite && memoryModel.contains(addr)) {
          if (usePortA) {
            c.io.douta.expect(memoryModel(addr).U, s"随机测试 #$i: 端口A读取地址$addr: 失败")
          } else {
            c.io.doutb.expect(memoryModel(addr).U, s"随机测试 #$i: 端口B读取地址$addr: 失败")
          }
        }

        if ((i + 1) % 20 == 0) {
          println(s"  完成 ${i + 1}/100 次测试")
        }
      }

      println("✓ 100 次随机读写测试全部通过")
    }
  }

  it should "test full address range" in {
    test(new ClockDistributionExample) { c =>

      println("测试完整地址空间（0-4095，使用 Clock_Generator 分发时钟）")

      // 写入测试模式：地址的低8位作为数据
      println("  阶段1：写入所有地址")
      c.io.ena.poke(true.B)
      c.io.wea.poke(true.B)

      for (addr <- 0 until 4096) {
        val data = addr & 0xFF
        c.io.addra.poke(addr.U)
        c.io.dina.poke(data.U)
        c.clock.step(1)

        if ((addr + 1) % 1024 == 0) {
          println(s"    已写入 ${addr + 1}/4096 个地址")
        }
      }

      // 读取验证
      println("  阶段2：验证所有地址")
      c.io.wea.poke(false.B)

      for (addr <- 0 until 4096) {
        val expected = addr & 0xFF

        // 发起读请求
        c.io.addra.poke(addr.U)
        c.clock.step(1)

        // 下一个周期验证读取结果
        c.clock.step(1)
        c.io.douta.expect(expected.U, s"地址 $addr 验证失败")

        if ((addr + 1) % 1024 == 0) {
          println(s"    已验证 ${addr + 1}/4096 个地址")
        }
      }

      println("✓ 完整地址空间测试通过（4096个地址）")
    }
  }
}

