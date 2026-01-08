package scpu
import chisel3._
import chisel3.util._

class top(Width:Int = 32, Debug:Boolean = true) extends Module {

  val Metronome_inst = Module(new Metronome(Width = Width))
  val PC_Ctrl_inst = Module(new PC_Ctrl(Width = Width))
  val Decoder_inst = Module(new Decoder())
  val InsBuffer_inst = Module(new InsBuffer(Width = Width, BufferSize = 10, Debug = Debug))
  val InsCacheL1_inst = Module(new insCacheL1(initFile = Some("init_data/program.hex")))
  val OpcodeCtrl_inst = Module(new OpcodeCtrl())
  val ImmGenerator_inst = Module(new ImmGenerator(Width = Width))
  val RegisterFile_inst = Module(new RegisterFile(Width = Width))
  val ALU_inst = Module(new ALU(Width = Width))
  val ALU_Ctrl_inst = Module(new ALU_Ctrl())
  val DataMemory_inst = Module(new DataMemory(Width = Width))
  val DataCacheL1_inst = Module(new dataCacheL1())
  val mux8_3_inst = Module(new Mux8_3())  // use for branch target selection

  Metronome_inst.io.tick_pc := PC_Ctrl_inst.io.pc_write_en
  Metronome_inst.io.tick_ifid := Decoder_inst.io.tick_ifid
  Metronome_inst.io.tick_idex := ALU_inst.io.tick_idex
  Metronome_inst.io.tick_exmem := DataMemory_inst.io.tick_exmem
  Metronome_inst.io.tick_memwb := RegisterFile_inst.io.tick_memwb

  PC_Ctrl_inst.io.pc_out := InsBuffer_inst.io.pc_in
  PC_Ctrl_inst.io.next_pc := mux8_3_inst.io.in0

  InsCacheL1_inst.io.ena := true.B
  InsCacheL1_inst.io.wea := false.B
  InsCacheL1_inst.io.dina := 0.U
  InsCacheL1_inst.io.enb := true.B
  InsCacheL1_inst.io.web := false.B
  InsCacheL1_inst.io.dinb := 0.U

  InsCacheL1_inst.io.douta := InsBuffer_inst.io.ins_low
  InsCacheL1_inst.io.doutb := InsBuffer_inst.io.ins_high

  InsBuffer_inst.io.ins_high := InsCacheL1_inst.io.addra
  InsBuffer_inst.io.ins_low := InsCacheL1_inst.io.addrb
  InsBuffer_inst.io.ins_out := Decoder_inst.io.instruction
  InsBuffer_inst.io.valid := Metronome_inst.io.stuck
  InsBuffer_inst.io.busy := Decoder_inst.io.busy

  Decoder_inst.io.opcode := OpcodeCtrl_inst.io.opcode






}