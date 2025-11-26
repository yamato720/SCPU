package scpu

import chisel3._
import chisel3.util._

class ALU extends Module{
  var io = IO(new Bundle{
    val a_in = Input(UInt(32.W))
    val b_in = Input(UInt(32.W))
    var alu_ctrl_in = Input(UInt(5.W))
    var tick_idex   = Input(Bool())
    var pc          = Input(UInt(32.W))
    var zero       = Output(Bool())
    var cout      = Output(Bool())
    var overflow  = Output(Bool())
    val alu_result = Output(UInt(32.W))
    val branch_taken = Output(UInt(3.W))
  })

  /*
  branch_taken:
  000: not taken
  001: taken pc + imm
  010: taken rs1 + imm
  */
  var a = RegInit(0.U(32.W))
  var b = RegInit(0.U(32.W))
  var alu_ctrl = RegInit(0.U(5.W))
  var pc_reg = RegInit(0.U(32.W))

  // 创建内部寄存器来保存输出值
  val alu_result_reg = RegInit(0.U(32.W))
  val zero_reg = RegInit(0.U(1.W))
  val cout_reg = RegInit(0.U(1.W))
  val overflow_reg = RegInit(0.U(1.W))
  val branch_taken_reg = RegInit(0.U(3.W))

  // 将内部寄存器连接到output端口
  io.alu_result := alu_result_reg
  io.zero := zero_reg
  io.cout := cout_reg
  io.overflow := overflow_reg
  io.branch_taken := branch_taken_reg

  when(reset.asBool){
    alu_result_reg := 0.U
    zero_reg := 0.U
    cout_reg := 0.U
    overflow_reg := 0.U
    branch_taken_reg := 0.U
    a := 0.U
    b := 0.U
    alu_ctrl := 0.U
    pc_reg := 0.U
  }.elsewhen(io.tick_idex) {
    a := io.a_in
    b := io.b_in
    alu_ctrl := io.alu_ctrl_in
    pc_reg := io.pc
    // tick_idex时不更新输出寄存器，自动维持上一个值
  }.otherwise{
    when(alu_ctrl === "b00000".U) { // ADD
      val add_result = a +& b  // 使用 +& 进行33位加法
      alu_result_reg := add_result(31, 0)
      zero_reg := (add_result(31, 0) === 0.U)
      cout_reg := add_result(32)  // 第32位是进位
      overflow_reg := (a(31) === b(31)) && (add_result(31) =/= a(31))
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00001".U) { // SUB
      val sub_result = a -& b  // 使用 -& 进行33位减法
      alu_result_reg := sub_result(31, 0)
      zero_reg := (sub_result(31, 0) === 0.U)
      cout_reg := sub_result(32)  // 第32位是借位
      overflow_reg := (a(31) =/= b(31)) && (sub_result(31) =/= a(31))
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00010".U) { // NOT A
      alu_result_reg := ~a
      zero_reg := (~a === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00011".U) { // AND
      alu_result_reg := a & b
      zero_reg := ((a & b) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00100".U) { // A OR B
      alu_result_reg := a | b
      zero_reg := ((a | b) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00101".U) { // A XOR B
      alu_result_reg := a ^ b
      zero_reg := ((a ^ b) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b00110".U) { // BLT
      val blt_result = a.asSInt < b.asSInt
      alu_result_reg := blt_result
      zero_reg := (blt_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(blt_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b00111".U) { // BEQ
      val beq_result = a === b
      alu_result_reg := beq_result
      zero_reg := (beq_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(beq_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b01000".U) { // SLL
      alu_result_reg := a << b(4, 0)
      zero_reg := ((a << b(4, 0)) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b01001".U) { // BLTU
      val bltu_result = a < b
      alu_result_reg := bltu_result
      zero_reg := (bltu_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(bltu_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b01010".U) { // SRL
      alu_result_reg := a >> b(4, 0)
      zero_reg := ((a >> b(4, 0)) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b01011".U) { // SRA
      alu_result_reg := (a.asSInt >> b(4, 0)).asUInt
      zero_reg := ((a.asSInt >> b(4, 0)).asUInt === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b01100".U) { // LUI
      alu_result_reg := b
      zero_reg := (b === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b01101".U) { // AUIPC
      alu_result_reg := pc_reg + b
      zero_reg := ((pc_reg + b) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := 0.U
    }.elsewhen(alu_ctrl === "b01110".U) { // BNE
      val bne_result = a =/= b
      alu_result_reg := bne_result
      zero_reg := (bne_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(bne_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b01111".U) { // BGE
      val bge_result = a.asSInt >= b.asSInt
      alu_result_reg := bge_result
      zero_reg := (bge_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(bge_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b10000".U) { // BGEU
      val bgeu_result = a >= b
      alu_result_reg := bgeu_result
      zero_reg := (bgeu_result === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := Mux(bgeu_result === 1.U, "b001".U, 0.U)
    }.elsewhen(alu_ctrl === "b10001".U) { // JALR
      alu_result_reg := pc_reg + 4.U
      zero_reg := ((pc_reg + 4.U) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := "b011".U
    }.elsewhen(alu_ctrl === "b10010".U) { // JAL
      alu_result_reg := pc_reg + 4.U
      zero_reg := ((pc_reg + 4.U) === 0.U)
      cout_reg := 0.U
      overflow_reg := 0.U
      branch_taken_reg := "b010".U
    }
    // otherwise分支不需要了，寄存器会自动保持值
  }


}


