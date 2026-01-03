package scpu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class top extends Module{
  var io = IO(new Bundle{
    val next_pc = Input(UInt(32.W))
    val instruction = Output(UInt(32.W))
    val opcode = Output(UInt(7.W))
    val funct3 = Output(UInt(3.W))
    val funct7 = Output(UInt(7.W))
    val rd = Output(UInt(5.W))
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })
  val metronome_inst = Module(new Metronome())
  val pc_ctrl_inst = Module(new PC_Ctrl(32))
  val decoder_inst = Module(new Decoder())
  val insbuffer_inst = Module(new InsBuffer(bufferSize = 10))
  // 使用 BlackBox 模式，这样会使用 Verilog 中初始化的数据
  val inscacheL1_inst = Module(new insCacheL1(useBlackBox = true))
  metronome_inst.io.stuck := false.B

  pc_ctrl_inst.io.next_pc := io.next_pc
  pc_ctrl_inst.io.pc_write_en := metronome_inst.io.tick_pc

  decoder_inst.io.tick_ifid := metronome_inst.io.tick_ifid
  decoder_inst.io.busy := insbuffer_inst.io.busy
  decoder_inst.io.instruction := insbuffer_inst.io.ins_out

  insbuffer_inst.io.ins_low := inscacheL1_inst.io.douta
  insbuffer_inst.io.ins_high := inscacheL1_inst.io.doutb
  insbuffer_inst.io.pc_in := pc_ctrl_inst.io.pc_out

  inscacheL1_inst.io.addra := insbuffer_inst.io.addr_low(11,0)
  inscacheL1_inst.io.ena := true.B
  inscacheL1_inst.io.wea := false.B
  inscacheL1_inst.io.dina := 0.U
  inscacheL1_inst.io.addrb := insbuffer_inst.io.addr_high(11,0)
  inscacheL1_inst.io.enb := true.B
  inscacheL1_inst.io.web := false.B
  inscacheL1_inst.io.dinb := 0.U

  // 连接输出端口
  io.instruction := decoder_inst.io.instruction
  io.opcode := decoder_inst.io.opcode
  io.funct3 := decoder_inst.io.funct3
  io.funct7 := decoder_inst.io.funct7
  io.rd := decoder_inst.io.rd
  io.rs1 := decoder_inst.io.rs1
  io.rs2 := decoder_inst.io.rs2





}


class fetch_decoderTest extends AnyFlatSpec with ChiselScalatestTester {
  "top" should "correctly perform instruction fetch and decode" in {
    test(new top()).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      print("Start testing top module\n")



      // 复位阶段
      c.reset.poke(true.B)
      c.io.next_pc.poke(0.U)
      c.clock.step(5)
      c.reset.poke(false.B)

      // 测试循环：每个 PC 运行多个周期以观察流水线行为
      for(pc_idx <- 0 until 29){
        val pc_value = pc_idx * 4
        print(s"\n==== Testing PC = 0x${pc_value.toHexString} (byte address: $pc_value) ====\n")


        c.io.next_pc.poke(pc_value.U)

        // 每个 PC 运行 25 个周期
        for(cycle <- 0 until 25){
          c.clock.step(1)

          val instruction = c.io.instruction.peek().litValue
          val opcode = c.io.opcode.peek().litValue
          val funct3 = c.io.funct3.peek().litValue
          val funct7 = c.io.funct7.peek().litValue
          val rd = c.io.rd.peek().litValue
          val rs1 = c.io.rs1.peek().litValue
          val rs2 = c.io.rs2.peek().litValue

          if(cycle == 24) {
            println(f"  Actual:   0x$instruction%08X (Opcode=0x$opcode%02X, Funct3=0x$funct3%01X, Funct7=0x$funct7%02X, rd=$rd%2d, rs1=$rs1%2d, rs2=$rs2%2d)")
          }
        }
      }
    }
  }
}
