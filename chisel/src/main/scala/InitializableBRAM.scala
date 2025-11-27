package scpu

import chisel3._
import chisel3.util._

// 用于在测试中方便地初始化 BRAM 的辅助类
class InitializableBRAM extends Module {
  val io = IO(new Bundle {
    val ena  = Input(Bool())
    val wea  = Input(Bool())
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    val enb  = Input(Bool())
    val web  = Input(Bool())
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })

  val bram = SyncReadMem(4096, UInt(8.W))

  // 端口 A
  when(io.ena) {
    when(io.wea) {
      bram.write(io.addra, io.dina)
    }
  }
  io.douta := Mux(io.ena, bram.read(io.addra, io.ena), 0.U)

  // 端口 B
  when(io.enb) {
    when(io.web) {
      bram.write(io.addrb, io.dinb)
    }
  }
  io.doutb := Mux(io.enb, bram.read(io.addrb, io.enb), 0.U)
}

// 用于程序化初始化的扩展类
class InitializableBRAMWithData(initData: Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val ena  = Input(Bool())
    val wea  = Input(Bool())
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    val enb  = Input(Bool())
    val web  = Input(Bool())
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })

  val bram = SyncReadMem(4096, UInt(8.W))

  // 使用 Chisel 的 loadMemoryFromFileInline 在仿真时初始化
  // 注意：这需要在测试环境中，实际硬件会忽略这个
  
  // 端口 A
  when(io.ena) {
    when(io.wea) {
      bram.write(io.addra, io.dina)
    }
  }
  io.douta := Mux(io.ena, bram.read(io.addra, io.ena), 0.U)

  // 端口 B
  when(io.enb) {
    when(io.web) {
      bram.write(io.addrb, io.dinb)
    }
  }
  io.doutb := Mux(io.enb, bram.read(io.addrb, io.enb), 0.U)
}
