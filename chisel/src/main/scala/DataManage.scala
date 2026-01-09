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
class insCacheL1(useBlackBox: Boolean = false, initFile: Option[String] = None, Width:Int = 32) extends Module {
  val io = IO(new Bundle {
    val ena  = Input(Bool())
    val wea  = Input(Bool())
    val addra = Input(UInt(Width.W))
    val dina  = Input(UInt(8.W))
    val douta = Output(UInt(8.W))

    val enb  = Input(Bool())
    val web  = Input(Bool())
    val addrb = Input(UInt(Width.W))
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

class InsBuffer(Width:Int = 32, BufferSize:Int = 128, Debug:Boolean = false) extends Module{
  // 定义IO Bundle - 始终包含所有端口，Debug模式下暴露额外的调试信号
  val io = IO(new Bundle{
    val pc_in = Input(UInt(Width.W))
    val ins_low = Input(UInt(8.W))
    val ins_high = Input(UInt(8.W))
    val addr_low = Output(UInt(Width.W))
    val addr_high = Output(UInt(Width.W))
    val ins_out = Output(UInt(32.W))
    val valid = Output(Bool())
    val busy = Output(Bool())
    // 调试端口 - 始终存在，但只在Debug模式下使用
    val index = if (Debug) Some(Output(UInt(log2Ceil(BufferSize).W))) else None
    val access_cnt = if (Debug) Some(Output(UInt((log2Ceil(BufferSize)+1).W))) else None
    val wait_cycle = if (Debug) Some(Output(UInt(2.W))) else None
  })


  val index_range = log2Ceil(BufferSize + 1).W

  val addr_low = RegInit(0.U(32.W))
  val addr_high = RegInit(1.U(32.W))
  val ins_out = RegInit(0.U(32.W))
  val valid = RegInit(false.B)
  val busy = RegInit(true.B)


  io.valid := valid
  io.busy := busy
  io.addr_low := addr_low
  io.addr_high := addr_high
  io.ins_out := ins_out



  val ins_reg = RegInit(VecInit(Seq.fill(BufferSize)("h00000013".U(32.W))))
  val finished = RegInit(false.B)
  val pc_base = RegInit(0.U(32.W))
  val index = RegInit(0.U(index_range)) // 需要多1位以检测溢出
  val access_cnt = RegInit(0.U(index_range)) // 当前已读取的指令数


  val wait_cycle = RegInit(0.U(2.W))

  // 连接调试端口（如果启用）
  if (Debug) {
    io.access_cnt.get := access_cnt
    io.index.get := index
    io.wait_cycle.get := wait_cycle
  }

  index := (io.pc_in-pc_base) >> 2
  val ins_temp = RegInit("h00000013".U(32.W))

  when(reset.asBool){
//    for(i <- 0 until bufferSize){
//      ins_reg(i) := "h00000013".U(32.W)
//    }
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
    access_cnt := 0.U
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

  val low_high_toggle = RegInit(false.B)

  when(reset.asBool){
    finished := false.B
    low_high_toggle := false.B
    addr_low := 0.U
    addr_high := 1.U
    access_cnt := 0.U
    wait_cycle := 0.U
  }.elsewhen(access_cnt === BufferSize.U){
    finished := true.B
    addr_low := pc_base
    addr_high := pc_base + 1.U
    wait_cycle := 0.U
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

class RegisterFile(numRegs:Int = 32, Width:Int = 32, Debug:Boolean = false) extends Module{
  val io = IO(new Bundle{
    val rs1 = Input(UInt(log2Ceil(numRegs).W))
    val rs2 = Input(UInt(log2Ceil(numRegs).W))
    val write_reg = Input(UInt(log2Ceil(numRegs).W))
    val rd_write_en = Input(Bool())
    val rd_write_din = Input(UInt(Width.W))
    val tick_memwb = Input(Bool())
    val rs1_dout = Output(UInt(Width.W))
    val rs2_dout = Output(UInt(Width.W))
    // 调试端口 - 始终存在，但只在Debug模式下使用
    val regs_out = if (Debug) Some(Output(Vec(numRegs, UInt(Width.W)))) else None
  })

  val regs = RegInit(VecInit(Seq.fill(numRegs)(0.U(Width.W))))

  // 读取寄存器
  io.rs1_dout := Mux(io.rs1 === 0.U, 0.U, regs(io.rs1))
  io.rs2_dout := Mux(io.rs2 === 0.U, 0.U, regs(io.rs2))

  regs(0) := 0.U  // x0寄存器始终为0

  // 连接调试端口（如果启用）
  if (Debug) {
    io.regs_out.get := regs
  }

  // 写入寄存器
  when(io.rd_write_en && (io.write_reg =/= 0.U) && io.tick_memwb){
    regs(io.write_reg) := io.rd_write_din
  }


}

class DataMemory32 extends Module{
  val io = IO(new Bundle{
    val mem_write_en = Input(Bool())
    val mem_read_en = Input(Bool())
    val addr = Input(UInt(32.W))
    val rs2_dout = Input(UInt(32.W))
    val recv_data_a = Input(UInt(8.W))
    val recv_data_b = Input(UInt(8.W))
    val access_type = Input(UInt(3.W))
    /* access_type decoding (funct3)
    000: byte (LB, SB)
    001: halfword (LH, SH)
    010: word (LW, SW)
    011: doubleword (LD, SD)
    100: byte unsigned (LBU)
    101: halfword unsigned (LHU)
    110: word unsigned (LWU)
    */
    val tick_exmem = Input(Bool())
    val result = Output(UInt(32.W))
    val enab = Output(Bool())
    val wea = Output(Bool())
    val web = Output(Bool())
    val addra = Output(UInt(32.W))
    val addrb = Output(UInt(32.W))
    val dina = Output(UInt(8.W))
    val dinb = Output(UInt(8.W))
  })

  val result = RegInit(0.U(32.W))
  val enab = RegInit(false.B)
  val wea = RegInit(false.B)
  val web = RegInit(false.B)
  val addra = RegInit(0.U(32.W))
  val addrb = RegInit(0.U(32.W))
  val dina = RegInit(0.U(8.W))
  val dinb = RegInit(0.U(8.W))

  io.result := result
  io.enab := enab
  io.wea := wea
  io.web := web
  io.addra := addra
  io.addrb := addrb
  io.dina := dina
  io.dinb := dinb

  enab := (io.mem_read_en | io.mem_write_en) & io.tick_exmem

  val state = RegInit(0.U(3.W))
  val wait_state = RegInit(1.U)

  when((io.mem_read_en | io.mem_write_en) && io.tick_exmem){
    when(Cat(state, io.access_type)==="b000000".U){ // signed byte
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := Fill(8, io.rs2_dout(7))  // 将第7位（符号位）扩展8次
      wea := io.mem_write_en
      web := false.B
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise{
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001000".U){
      result := Cat(Fill(24,io.recv_data_a(7)), io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010000".U){
      dina := Fill(8, io.rs2_dout(7))
      dinb := Fill(8, io.rs2_dout(7))
      wea := false.B
      web := false.B
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011000".U){
      result := Cat(Fill(16,result(7)), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000100".U){  // unsigned byte
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := 0.U
      wea := io.mem_write_en
      web := false.B
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise{
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001100".U){
      result := Cat(Fill(24,0.U), io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010100".U){
      dina := 0.U
      dinb := 0.U
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011100".U){
      result := Cat(0.U(16.W), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000001".U){// signed halfword
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001001".U){
      result := Cat(Fill(16,io.recv_data_b(7)), io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010001".U){
      dina := Fill(8, io.rs2_dout(15))
      dinb := Fill(8, io.rs2_dout(15))
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011001".U){
      result := Cat(Fill(16,result(15)), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000101".U){ // unsigned halfword
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001101".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010101".U){
      dina := 0.U
      dinb := 0.U
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011101".U){
      result := Cat(0.U(16.W), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000010".U){   // signed word
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001010".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
    }.elsewhen(Cat(state, io.access_type)==="b010010".U){
      dina := io.rs2_dout(23,16)
      dinb := io.rs2_dout(31,24)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011010".U){
      result := Cat(io.recv_data_b, io.recv_data_a, result(15,0))
      state := 0.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b000110".U){   // unsigned word
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001110".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
    }.elsewhen(Cat(state, io.access_type)==="b010110".U){
      dina := io.rs2_dout(23,16)
      dinb := io.rs2_dout(31,24)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011110".U){
      result := Cat(0.U(0.W), result(31,0))
      state := 0.U
    }.otherwise{
      state := 0.U
      wait_state := 1.U
      wea := false.B
      web := false.B
    }
  }.otherwise{
    state := 0.U
    wait_state := 1.U
    wea := false.B
    web := false.B
  }
}

class DataMemory64 extends Module{
  val io = IO(new Bundle{
    val mem_write_en = Input(Bool())
    val mem_read_en = Input(Bool())
    val addr = Input(UInt(64.W))
    val rs2_dout = Input(UInt(64.W))
    val recv_data_a = Input(UInt(8.W))
    val recv_data_b = Input(UInt(8.W))
    val access_type = Input(UInt(3.W))
    /* access_type decoding (funct3)
    000: byte (LB, SB)
    001: halfword (LH, SH)
    010: word (LW, SW)
    011: doubleword (LD, SD)
    100: byte unsigned (LBU)
    101: halfword unsigned (LHU)
    110: word unsigned (LWU)
    */
    val tick_exmem = Input(Bool())
    val result = Output(UInt(64.W))
    val enab = Output(Bool())
    val wea = Output(Bool())
    val web = Output(Bool())
    val addra = Output(UInt(64.W))
    val addrb = Output(UInt(64.W))
    val dina = Output(UInt(8.W))
    val dinb = Output(UInt(8.W))
  })

  val result = RegInit(0.U(64.W))
  val enab = RegInit(false.B)
  val wea = RegInit(false.B)
  val web = RegInit(false.B)
  val addra = RegInit(0.U(64.W))
  val addrb = RegInit(0.U(64.W))
  val dina = RegInit(0.U(8.W))
  val dinb = RegInit(0.U(8.W))

  io.result := result
  io.enab := enab
  io.wea := wea
  io.web := web
  io.addra := addra
  io.addrb := addrb
  io.dina := dina
  io.dinb := dinb

  enab := (io.mem_read_en | io.mem_write_en) & io.tick_exmem

  val state = RegInit(0.U(3.W))
  val wait_state = RegInit(1.U)

  when((io.mem_read_en | io.mem_write_en) && io.tick_exmem){
    when(Cat(state, io.access_type)==="b000000".U){ // signed byte
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := Fill(8, io.rs2_dout(7))  // 将第7位（符号位）扩展8次
      wea := io.mem_write_en
      web := false.B
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise{
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001000".U){
      result := Cat(Fill(56,io.recv_data_a(7)), io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010000".U){
      dina := Fill(8, io.rs2_dout(7))
      dinb := Fill(8, io.rs2_dout(7))
      wea := false.B
      web := false.B
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011000".U){
      result := Cat(Fill(48,result(7)), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000100".U){  // unsigned byte
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := 0.U
      wea := io.mem_write_en
      web := false.B
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise{
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001100".U){
      result := Cat(Fill(56,0.U), io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010100".U){
      dina := 0.U
      dinb := 0.U
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011100".U){
      result := Cat(0.U(48.W), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000001".U){// signed halfword
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001001".U){
      result := Cat(Fill(48,io.recv_data_b(7)), io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010001".U){
      dina := Fill(8, io.rs2_dout(15))
      dinb := Fill(8, io.rs2_dout(15))
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011001".U){
      result := Cat(Fill(48,result(15)), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000101".U){ // unsigned halfword
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001101".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b010101".U){
      dina := 0.U
      dinb := 0.U
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011101".U){
      result := Cat(0.U(48.W), result(15,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000010".U){   // signed word
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001010".U){
      result := Cat(Fill(32,io.recv_data_b(7)), io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
    }.elsewhen(Cat(state, io.access_type)==="b010010".U){
      dina := io.rs2_dout(23,16)
      dinb := io.rs2_dout(31,24)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011010".U){
      result := Cat(Fill(32, io.recv_data_b(7)) ,io.recv_data_b, io.recv_data_a, result(15,0))
      state := 0.U
      wea := false.B
      web := false.B
    }.elsewhen(Cat(state, io.access_type)==="b000110".U){   // unsigned word
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001110".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
    }.elsewhen(Cat(state, io.access_type)==="b010110".U){
      dina := io.rs2_dout(23,16)
      dinb := io.rs2_dout(31,24)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011110".U){
      result := Cat(0.U(32.W), result(31,0))
      state := 0.U
    }.elsewhen(Cat(state, io.access_type)==="b000011".U){ // double
      addra := io.addr
      addrb := io.addr + 1.U
      dina := io.rs2_dout(7,0)
      dinb := io.rs2_dout(15,8)
      wea := io.mem_write_en
      web := io.mem_write_en
      when(wait_state === 1.U){
        wait_state := 0.U
      }.otherwise {
        state := state + 1.U
      }
    }.elsewhen(Cat(state, io.access_type)==="b001011".U){
      result := Cat(io.recv_data_b, io.recv_data_a)
      state := state + 1.U
      addra := io.addr + 2.U
      addrb := io.addr + 3.U
    }.elsewhen(Cat(state, io.access_type)==="b010011".U){
      dina := io.rs2_dout(23,16)
      dinb := io.rs2_dout(31,24)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b011011".U){
      result := Cat(io.recv_data_b, io.recv_data_a, result(15,0))
      state := state + 1.U
      addra := io.addr + 4.U
      addrb := io.addr + 5.U
    }.elsewhen(Cat(state, io.access_type)==="b100011".U){
      dina := io.rs2_dout(39,32)
      dinb := io.rs2_dout(47,40)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b101011".U){
      result := Cat(io.recv_data_b, io.recv_data_a, result(31,0))
      state := state + 1.U
      addra := io.addr + 6.U
      addrb := io.addr + 7.U
    }.elsewhen(Cat(state, io.access_type)==="b110011".U){
      dina := io.rs2_dout(55,48)
      dinb := io.rs2_dout(63,56)
      state := state + 1.U
    }.elsewhen(Cat(state, io.access_type)==="b111011".U){
      result := Cat(io.recv_data_b, io.recv_data_a, result(47,0))
      state := 0.U
      wea := false.B
      web := false.B
    }
  }.otherwise{
    state := 0.U
    wait_state := 1.U
    wea := false.B
    web := false.B
  }
}

class DataMemory(Width:Int = 32) extends Module{
  val io = IO(new Bundle{
    val mem_write_en = Input(Bool())
    val mem_read_en = Input(Bool())
    val addr = Input(UInt(Width.W))
    val rs2_dout = Input(UInt(Width.W))
    val recv_data_a = Input(UInt(8.W))
    val recv_data_b = Input(UInt(8.W))
    val access_type = Input(UInt(3.W))
    /* access_type decoding (funct3)
    000: byte (LB, SB)
    001: halfword (LH, SH)
    010: word (LW, SW)
    011: doubleword (LD, SD)
    100: byte unsigned (LBU)
    101: halfword unsigned (LHU)
    110: word unsigned (LWU)
    */
    val tick_exmem = Input(Bool())
    val result = Output(UInt(Width.W))
    val enab = Output(Bool())
    val wea = Output(Bool())
    val web = Output(Bool())
    val addra = Output(UInt(Width.W))
    val addrb = Output(UInt(Width.W))
    val dina = Output(UInt(8.W))
    val dinb = Output(UInt(8.W))
  })

  if(Width == 32){
    val dataMemory32 = Module(new DataMemory32)
    dataMemory32.io.mem_write_en := io.mem_write_en
    dataMemory32.io.mem_read_en := io.mem_read_en
    dataMemory32.io.addr := io.addr
    dataMemory32.io.rs2_dout := io.rs2_dout
    dataMemory32.io.recv_data_a := io.recv_data_a
    dataMemory32.io.recv_data_b := io.recv_data_b
    dataMemory32.io.access_type := io.access_type
    dataMemory32.io.tick_exmem := io.tick_exmem

    io.result := dataMemory32.io.result
    io.enab := dataMemory32.io.enab
    io.wea := dataMemory32.io.wea
    io.web := dataMemory32.io.web
    io.addra := dataMemory32.io.addra
    io.addrb := dataMemory32.io.addrb
    io.dina := dataMemory32.io.dina
    io.dinb := dataMemory32.io.dinb
  }else{
    val dataMemory64 = Module(new DataMemory64)
    dataMemory64.io.mem_write_en := io.mem_write_en
    dataMemory64.io.mem_read_en := io.mem_read_en
    dataMemory64.io.addr := io.addr
    dataMemory64.io.rs2_dout := io.rs2_dout
    dataMemory64.io.recv_data_a := io.recv_data_a
    dataMemory64.io.recv_data_b := io.recv_data_b
    dataMemory64.io.access_type := io.access_type
    dataMemory64.io.tick_exmem := io.tick_exmem

    io.result := dataMemory64.io.result
    io.enab := dataMemory64.io.enab
    io.wea := dataMemory64.io.wea
    io.web := dataMemory64.io.web
    io.addra := dataMemory64.io.addra
    io.addrb := dataMemory64.io.addrb
    io.dina := dataMemory64.io.dina
    io.dinb := dataMemory64.io.dinb
  }
}