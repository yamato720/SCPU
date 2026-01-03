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
  addResource("rtl/shell/bram_8_4096_ins_shell.v")
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

class InsBuffer(width:Int = 32, bufferSize:Int = 128) extends Module{
  val io = IO(new Bundle{
    val pc_in = Input(UInt(width.W))
    val ins_low = Input(UInt(8.W))
    val ins_high = Input(UInt(8.W))
    val addr_low = Output(UInt(32.W))
    val addr_high = Output(UInt(32.W))
    val ins_out = Output(UInt(32.W))
    val valid = Output(Bool())
    val busy = Output(Bool())
  })

  var index_range = log2Floor(bufferSize).W

  val addr_low = RegInit(0.U(32.W))
  val addr_high = RegInit(0.U(32.W))
  val ins_out = RegInit(0.U(32.W))
  val valid = RegInit(false.B)
  val busy = RegInit(true.B)


  io.valid := valid
  io.busy := busy
  io.addr_low := addr_low
  io.addr_high := addr_high
  io.ins_out := ins_out



  val ins_reg = RegInit(VecInit(Seq.fill(bufferSize)("h00000013".U(32.W))))
  val finished = RegInit(false.B)
  val pc_base = RegInit(0.U(32.W))
  val index = RegInit(0.U(index_range)) // 需要多1位以检测溢出
  val access_cnt = RegInit(0.U(index_range)) // 当前已读取的指令数

  index := (io.pc_in-pc_base) >> 2
  val ins_temp = RegInit("h00000013".U(32.W))

  when(reset.asBool){
    for(i <- 0 until bufferSize){
      ins_reg(i) := "h00000013".U(32.W)
    }
    ins_out := "h00000013".U(32.W)
    valid := false.B
    ins_temp := "h00000013".U(32.W)
    pc_base := 0.U
  }.elsewhen(index < access_cnt && valid){
    ins_out := ins_reg(index)
    ins_temp:= ins_reg(index)
  }.otherwise{
    ins_out := ins_temp
    valid := false.B
    pc_base := io.pc_in
  }

  val valid_latch = RegInit(false.B)
  valid_latch := valid



  when(reset.asBool){
    busy := true.B
  }.elsewhen(!(index < access_cnt && valid)){
    busy := true.B
  }.elsewhen(valid === true.B && valid_latch === false.B){
    busy := false.B
  }

  val wait_cycle = RegInit(0.U(2.W))
  val low_high_toggle = RegInit(false.B)
  when(reset.asBool){
    finished := false.B
    low_high_toggle := false.B
    addr_low := 0.U
    addr_high := 0.U
    access_cnt := 0.U
    wait_cycle := 0.U
  }.elsewhen(access_cnt === bufferSize.U){
    finished := true.B
    addr_low := pc_base
    addr_high := pc_base + 1.U
    wait_cycle := 0.U
    access_cnt := 0.U
  }.elsewhen(!finished && wait_cycle(0) === false.B){
    addr_low := addr_low + 2.U
    addr_high := addr_high + 2.U
    wait_cycle := wait_cycle + 1.U
  }.elsewhen(!finished && wait_cycle(0) === true.B){
    when(low_high_toggle === false.B){
      ins_reg(access_cnt) := Cat(ins_reg(access_cnt)(31, 16), io.ins_high, io.ins_low)
    }.otherwise{
      ins_reg(access_cnt) := Cat(io.ins_high, io.ins_low, ins_reg(access_cnt)(15, 0))
      access_cnt := access_cnt + 1.U
    }
    low_high_toggle := ~low_high_toggle
    when(wait_cycle === 3.U && access_cnt === 0.U){
      valid := true.B
    }
    wait_cycle := wait_cycle + 1.U
  }.elsewhen(!valid){
    finished := false.B
    low_high_toggle := false.B
    addr_low := io.pc_in
    addr_high := io.pc_in + 1.U
    wait_cycle := 0.U
  }




}

