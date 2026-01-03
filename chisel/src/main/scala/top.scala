package scpu
import chisel3._
import chisel3.util._

class top extends Module {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
  })

  // Simple pass-through logic for demonstration
  val Metronome_inst = Module(new Metronome())
  Metronome_inst.clock := io.clk
  Metronome_inst.reset := io.rst

  val PC_Ctrl_inst = Module(new PC_Ctrl(32))
  PC_Ctrl_inst.clock := io.clk
  PC_Ctrl_inst.reset := io.rst

  val Decoder_inst = Module(new Decoder())
  Decoder_inst.clock := io.clk
  Decoder_inst.reset := io.rst

}