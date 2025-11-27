package scpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline

class Clock_Generator(num: Int) extends Module {
  val io = IO(new Bundle {
    val clk_out = Output(Vec(num, Clock()))
  })

  // 将输入时钟分发到所有输出引脚
  for (i <- 0 until num) {
    io.clk_out(i) := clock
  }
}

class bram_8_4096_L1Cache extends RawModule {
  val io = IO(new Bundle {
    // 端口 A - 独立时钟
    val clka = Input(Clock())
    val ena  = Input(Bool())
    val wea  = Input(Bool())
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    // 端口 B - 独立时钟
    val clkb = Input(Clock())
    val enb  = Input(Bool())
    val web  = Input(Bool())
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })

  // 使用 SyncReadMem 实现双端口 BRAM（4096 x 8bit）
  val bram = SyncReadMem(4096, UInt(8.W))

  // 端口 A 的逻辑
  val douta_reg = withClockAndReset(io.clka, false.B) { RegInit(0.U(8.W)) }
  io.douta := douta_reg

  withClock(io.clka) {
    when(io.ena) {
      when(io.wea) {
        bram.write(io.addra, io.dina)
      }
      douta_reg := bram.read(io.addra)
    }
  }

  // 端口 B 的逻辑
  val doutb_reg = withClockAndReset(io.clkb, false.B) { RegInit(0.U(8.W)) }
  io.doutb := doutb_reg

  withClock(io.clkb) {
    when(io.enb) {
      when(io.web) {
        bram.write(io.addrb, io.dinb)
      }
      doutb_reg := bram.read(io.addrb)
    }
  }
}

// BlackBox for instruction cache Verilog module
class bram_8_4096_ins_shell extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val clka = Input(Clock())
    val ena  = Input(Bool())
    val wea  = Input(UInt(1.W))
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    val clkb = Input(Clock())
    val enb  = Input(Bool())
    val web  = Input(UInt(1.W))
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })
  addResource("/rtl/shell/bram_8_4096_ins_shell.v")
}

// BlackBox for data cache Verilog module
class bram_8_4096_mem_shell extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val clka = Input(Clock())
    val ena  = Input(Bool())
    val wea  = Input(UInt(1.W))
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    val clkb = Input(Clock())
    val enb  = Input(Bool())
    val web  = Input(UInt(1.W))
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })
  addResource("/rtl/shell/bram_8_4096_mem_shell.v")
}

// Instruction cache wrapper using BlackBox
// For synthesis, can switch to BlackBox by changing useBlackBox parameter
// initFile: 可选的初始化文件路径 (相对于 resources 目录)
class insCacheL1(useBlackBox: Boolean = false, initFile: Option[String] = None) extends Module {
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

  if (useBlackBox) {
    // Use BlackBox for synthesis
    val blackbox = Module(new bram_8_4096_ins_shell)
    blackbox.io.clka := clock
    blackbox.io.ena := io.ena
    blackbox.io.wea := io.wea.asUInt
    blackbox.io.addra := io.addra
    blackbox.io.dina := io.dina
    io.douta := blackbox.io.douta

    blackbox.io.clkb := clock
    blackbox.io.enb := io.enb
    blackbox.io.web := io.web.asUInt
    blackbox.io.addrb := io.addrb
    blackbox.io.dinb := io.dinb
    io.doutb := blackbox.io.doutb
  } else {
    // Use Chisel implementation for simulation/testing
    // 使用 SyncReadMem 实现双端口 BRAM（4096 x 8bit）
    val bram = SyncReadMem(4096, UInt(8.W))
    
    // 如果提供了初始化文件，则加载数据
    initFile.foreach { file =>
      loadMemoryFromFileInline(bram, file)
    }

    // 端口 A 的逻辑
    // SyncReadMem.read() 已经是同步的，不需要额外的寄存器
    when(io.ena) {
      when(io.wea) {
        bram.write(io.addra, io.dina)
      }
    }
    io.douta := Mux(io.ena, bram.read(io.addra, io.ena), 0.U)

    // 端口 B 的逻辑
    when(io.enb) {
      when(io.web) {
        bram.write(io.addrb, io.dinb)
      }
    }
    io.doutb := Mux(io.enb, bram.read(io.addrb, io.enb), 0.U)
  }
}

// Data cache wrapper using BlackBox
// For synthesis, can switch to BlackBox by changing useBlackBox parameter
// initFile: 可选的初始化文件路径 (相对于 resources 目录)
class dataCacheL1(useBlackBox: Boolean = false, initFile: Option[String] = None) extends Module {
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

  if (useBlackBox) {
    // Use BlackBox for synthesis
    val blackbox = Module(new bram_8_4096_mem_shell)
    blackbox.io.clka := clock
    blackbox.io.ena := io.ena
    blackbox.io.wea := io.wea.asUInt
    blackbox.io.addra := io.addra
    blackbox.io.dina := io.dina
    io.douta := blackbox.io.douta

    blackbox.io.clkb := clock
    blackbox.io.enb := io.enb
    blackbox.io.web := io.web.asUInt
    blackbox.io.addrb := io.addrb
    blackbox.io.dinb := io.dinb
    io.doutb := blackbox.io.doutb
  } else {
    // Use Chisel implementation for simulation/testing
    // 使用 SyncReadMem 实现双端口 BRAM（4096 x 8bit）
    val bram = SyncReadMem(4096, UInt(8.W))
    
    // 如果提供了初始化文件，则加载数据
    initFile.foreach { file =>
      loadMemoryFromFileInline(bram, file)
    }

    // 端口 A 的逻辑
    // SyncReadMem.read() 已经是同步的，不需要额外的寄存器
    when(io.ena) {
      when(io.wea) {
        bram.write(io.addra, io.dina)
      }
    }
    io.douta := Mux(io.ena, bram.read(io.addra, io.ena), 0.U)

    // 端口 B 的逻辑
    when(io.enb) {
      when(io.web) {
        bram.write(io.addrb, io.dinb)
      }
    }
    io.doutb := Mux(io.enb, bram.read(io.addrb, io.enb), 0.U)
  }
}

class ClockDistributionExample extends Module {
  val io = IO(new Bundle {
    // BRAM 端口 A 的信号
    val ena   = Input(Bool())
    val wea   = Input(Bool())
    val addra = Input(UInt(12.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    // BRAM 端口 B 的信号
    val enb   = Input(Bool())
    val web   = Input(Bool())
    val addrb = Input(UInt(12.W))
    val dinb  = Input(UInt(8.W))
    val doutb = Output(UInt(8.W))
  })

  // 创建时钟生成器，生成 2 个时钟输出
  val clockGen = Module(new Clock_Generator(2))

  // 创建双端口 BRAM
  val bram = Module(new bram_8_4096_L1Cache)
//  val bram = Module(new bram_8_4096())

  // 将时钟生成器的输出连接到 BRAM 的两个时钟输入
  bram.io.clka := clockGen.io.clk_out(0)
  bram.io.clkb := clockGen.io.clk_out(1)

  // 连接端口 A 的信号
  bram.io.ena   := io.ena
  bram.io.wea   := io.wea
  bram.io.addra := io.addra
  bram.io.dina  := io.dina
  io.douta      := bram.io.douta

  // 连接端口 B 的信号
  bram.io.enb   := io.enb
  bram.io.web   := io.web
  bram.io.addrb := io.addrb
  bram.io.dinb  := io.dinb
  io.doutb      := bram.io.doutb
}



