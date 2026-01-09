package scpu
import chisel3._
import chisel3.util._

class CPU(Width:Int = 64, Debug:Boolean = false) extends Module {
  val io = IO(new Bundle{
    // Debug 端口：输出所有32个寄存器的值
    val regs_debug = if (Debug) Some(Output(Vec(32, UInt(Width.W)))) else None
    val tick_pc_debug = if(Debug) Some(Output(Bool())) else None
    val tick_ifid_debug = if(Debug) Some(Output(Bool())) else None
    val tick_idex_debug = if(Debug) Some(Output(Bool())) else None
    val tick_exmem_debug = if(Debug) Some(Output(Bool())) else None
    val tick_memwb_debug = if(Debug) Some(Output(Bool())) else None
    val pc = if(Debug) Some(Output(UInt(Width.W))) else None
    val index = if (Debug) Some(Output(UInt(log2Ceil(10).W))) else None
    val access_cnt = if (Debug) Some(Output(UInt((log2Ceil(10)+1).W))) else None
    val waitcycles = if (Debug) Some(Output(UInt(32.W))) else None
    val valid = if(Debug) Some(Output(Bool())) else None
    val instruction = if(Debug) Some(Output(UInt(32.W))) else None
    val imm = if(Debug) Some(Output(UInt(Width.W))) else None
  })

  val Metronome_inst = Module(new Metronome(Width = Width))
  val PC_Ctrl_inst = Module(new PC_Ctrl(Width = Width))
  val Decoder_inst = Module(new Decoder())
  val InsBuffer_inst = Module(new InsBuffer(Width = Width, BufferSize = 10, Debug = Debug))
  val InsCacheL1_inst = Module(new insCacheL1(initFile = Some("init_data/program.hex")))
  val OpcodeCtrl_inst = Module(new OpcodeCtrl())
  val ImmGenerator_inst = Module(new ImmGenerator(Width = Width))
  val RegisterFile_inst = Module(new RegisterFile(Width = Width, Debug = Debug))
  val ALU_inst = Module(new ALU(Width = Width))
  val ALU_Ctrl_inst = Module(new ALU_Ctrl())
  val DataMemory_inst = Module(new DataMemory(Width = Width))
  val DataCacheL1_inst = Module(new dataCacheL1())
  val mux8_3_inst = Module(new Mux8_3())  // use for branch target selection
  val and_gate_inst = Module(new AndGate(Width = 3)) // for branch taken decision
  val mux2_1_WriteBack = Module(new Mux2_1(Width = Width)) // for alu result and data memory read data selection
  val mux2_1_Rs2 = Module(new Mux2_1(Width = Width)) // for rs2 and immediate selection
  val adder2_1_forJALR = Module(new Adder(Width = Width)) // for jalr target calculation
  val adder2_1_ImmBranch = Module(new Adder(Width = Width)) // for Imm branch calculation
  val leftShifter_ImmFix = Module(new LeftShifter(Width = Width, count = 1)) // imm for branch target calculation
  val PC_Align_inst = Module(new PC_Align(Width = Width)) // align pc for instruction fetch

  Metronome_inst.io.stuck := InsBuffer_inst.io.busy

  PC_Ctrl_inst.io.next_pc := mux8_3_inst.io.out
  PC_Ctrl_inst.io.pc_write_en := Metronome_inst.io.tick_pc

  InsCacheL1_inst.io.addra := InsBuffer_inst.io.addr_low
  InsCacheL1_inst.io.ena := true.B
  InsCacheL1_inst.io.wea := false.B
  InsCacheL1_inst.io.dina := 0.U
  InsCacheL1_inst.io.addrb := InsBuffer_inst.io.addr_high
  InsCacheL1_inst.io.enb := true.B
  InsCacheL1_inst.io.web := false.B
  InsCacheL1_inst.io.dinb := 0.U

  InsBuffer_inst.io.pc_in := PC_Ctrl_inst.io.pc_out
  InsBuffer_inst.io.ins_low := InsCacheL1_inst.io.douta
  InsBuffer_inst.io.ins_high := InsCacheL1_inst.io.doutb

  Decoder_inst.io.instruction := InsBuffer_inst.io.ins_out
  Decoder_inst.io.busy := InsBuffer_inst.io.busy
  Decoder_inst.io.tick_ifid := Metronome_inst.io.tick_ifid

  OpcodeCtrl_inst.io.opcode := Decoder_inst.io.opcode

  RegisterFile_inst.io.rs1 := Decoder_inst.io.rs1
  RegisterFile_inst.io.rs2 := Decoder_inst.io.rs2
  RegisterFile_inst.io.write_reg := Decoder_inst.io.rd
  RegisterFile_inst.io.rd_write_din := mux2_1_WriteBack.io.out
  RegisterFile_inst.io.rd_write_en := OpcodeCtrl_inst.io.regWrite
  RegisterFile_inst.io.tick_memwb := Metronome_inst.io.tick_memwb

  ImmGenerator_inst.io.instruction := InsBuffer_inst.io.ins_out

  leftShifter_ImmFix.io.in := ImmGenerator_inst.io.imm_out

  adder2_1_forJALR.io.a := RegisterFile_inst.io.rs1_dout
  adder2_1_forJALR.io.b := ImmGenerator_inst.io.imm_out

  mux2_1_Rs2.io.sel := OpcodeCtrl_inst.io.aluSrc
  mux2_1_Rs2.io.in0 := RegisterFile_inst.io.rs2_dout
  mux2_1_Rs2.io.in1 := ImmGenerator_inst.io.imm_out

  adder2_1_ImmBranch.io.a := PC_Ctrl_inst.io.pc_out
  adder2_1_ImmBranch.io.b := leftShifter_ImmFix.io.out

  PC_Align_inst.io.pc_in := adder2_1_forJALR.io.sum

  ALU_inst.io.a_in := RegisterFile_inst.io.rs1_dout
  ALU_inst.io.b_in := mux2_1_Rs2.io.out
  ALU_inst.io.alu_ctrl_in := ALU_Ctrl_inst.io.alu_ctrl
  ALU_inst.io.tick_idex := Metronome_inst.io.tick_idex
  ALU_inst.io.pc := PC_Ctrl_inst.io.pc_out

  ALU_Ctrl_inst.io.aluop := OpcodeCtrl_inst.io.aluop
  ALU_Ctrl_inst.io.funct3 := Decoder_inst.io.funct3
  ALU_Ctrl_inst.io.funct7 := Decoder_inst.io.funct7

  and_gate_inst.io.a := OpcodeCtrl_inst.io.branch
  and_gate_inst.io.b := ALU_inst.io.branch_taken

  DataMemory_inst.io.mem_write_en := OpcodeCtrl_inst.io.memWrite
  DataMemory_inst.io.mem_read_en := OpcodeCtrl_inst.io.memRead
  DataMemory_inst.io.addr := ALU_inst.io.alu_result
  DataMemory_inst.io.rs2_dout := RegisterFile_inst.io.rs2_dout
  DataMemory_inst.io.recv_data_a := DataCacheL1_inst.io.douta
  DataMemory_inst.io.recv_data_b := DataCacheL1_inst.io.doutb
  DataMemory_inst.io.access_type := Decoder_inst.io.funct3
  DataMemory_inst.io.tick_exmem := Metronome_inst.io.tick_exmem

  DataCacheL1_inst.io.wea := DataMemory_inst.io.wea
  DataCacheL1_inst.io.addra := DataMemory_inst.io.addra
  DataCacheL1_inst.io.dina := DataMemory_inst.io.dina
  DataCacheL1_inst.io.ena := DataMemory_inst.io.enab
  DataCacheL1_inst.io.web := DataMemory_inst.io.web
  DataCacheL1_inst.io.addrb := DataMemory_inst.io.addrb
  DataCacheL1_inst.io.dinb := DataMemory_inst.io.dinb
  DataCacheL1_inst.io.enb := DataMemory_inst.io.enab

  mux8_3_inst.io.sel := and_gate_inst.io.out
  mux8_3_inst.io.in0 := PC_Ctrl_inst.io.pc_plus4
  mux8_3_inst.io.in1 := adder2_1_ImmBranch.io.sum
  mux8_3_inst.io.in2 := adder2_1_forJALR.io.sum
  mux8_3_inst.io.in3 := 0.U
  mux8_3_inst.io.in4 := 0.U
  mux8_3_inst.io.in5 := 0.U
  mux8_3_inst.io.in6 := 0.U
  mux8_3_inst.io.in7 := 0.U

  mux2_1_WriteBack.io.sel := OpcodeCtrl_inst.io.memtoReg
  mux2_1_WriteBack.io.in0 := ALU_inst.io.alu_result
  mux2_1_WriteBack.io.in1 := DataMemory_inst.io.result
 
  // 连接 Debug 端口：输出所有 32 个寄存器的值
  if (Debug) {
    io.regs_debug.get := RegisterFile_inst.io.regs_out.get
    io.tick_pc_debug.get := Metronome_inst.io.tick_pc
    io.tick_ifid_debug.get := Metronome_inst.io.tick_ifid
    io.tick_idex_debug.get := Metronome_inst.io.tick_idex
    io.tick_exmem_debug.get := Metronome_inst.io.tick_exmem
    io.tick_memwb_debug.get := Metronome_inst.io.tick_memwb
    io.pc.get := PC_Ctrl_inst.io.pc_out
    io.index.get := InsBuffer_inst.io.index.get
    io.access_cnt.get := InsBuffer_inst.io.access_cnt.get
    io.waitcycles.get := InsBuffer_inst.io.wait_cycle.get
    io.valid.get := InsBuffer_inst.io.valid
    io.instruction.get := InsBuffer_inst.io.ins_out
    io.imm.get := ImmGenerator_inst.io.imm_out
  }

}