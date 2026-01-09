package scpu

import chisel3._
import chisel3.util._

class ALU_Ctrl extends Module{
  var io = IO(new Bundle() {
    var aluop = Input(UInt(3.W))
    var funct7 = Input(UInt(7.W))
    var funct3 = Input(UInt(3.W))
    var alu_ctrl = Output(UInt(5.W))
  })

  when (io.aluop === "b000".U){
    io.alu_ctrl := "b00000".U  // load/store ADD
  }.elsewhen(io.aluop === "b001".U){
    when (io.funct3 === "b000".U){
      io.alu_ctrl := "b00111".U  // BEQ
    }.elsewhen(io.funct3 === "b001".U){
      io.alu_ctrl := "b01110".U  // BNE
    }.elsewhen(io.funct3 === "b100".U){
      io.alu_ctrl := "b00110".U  // BLT
    }.elsewhen(io.funct3 === "b101".U){
      io.alu_ctrl := "b01111".U  // BGE
    }.elsewhen(io.funct3 === "b110".U){
      io.alu_ctrl := "b01001".U
    }.elsewhen(io.funct3 === "b111".U){
      io.alu_ctrl := "b10000".U
    }.otherwise{
      io.alu_ctrl := "b00000".U
    }
  }.elsewhen(io.aluop === "b010".U) {
    when(Cat(io.funct7(5), io.funct3) === "b0000".U) {
      io.alu_ctrl := "b00000".U // ADD
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b1000".U){
      io.alu_ctrl := "b00001".U // SUB
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0111".U){
      io.alu_ctrl := "b00011".U // AND
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0110".U){
      io.alu_ctrl := "b00100".U // OR
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0100".U){
      io.alu_ctrl := "b00101".U // XOR
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0010".U){
      io.alu_ctrl := "b00110".U // SLT
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0001".U){
      io.alu_ctrl := "b01000".U // SLL
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0011".U){
      io.alu_ctrl := "b01001".U // SLTU
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b0101".U) {
      io.alu_ctrl := "b01010".U // SRL
    }.elsewhen(Cat(io.funct7(5), io.funct3) === "b1101".U) {
      io.alu_ctrl := "b01011".U // SRA
    }.otherwise{
      io.alu_ctrl := "b00000".U
    }
  }.elsewhen(io.aluop === "b011".U){
    when (io.funct3 === "b000".U){
      io.alu_ctrl := "b00000".U  // ADDI
    }.elsewhen(io.funct3 === "b111".U){
      io.alu_ctrl := "b00011".U  // ANDI
    }.elsewhen(io.funct3 === "b110".U){
      io.alu_ctrl := "b00100".U  // ORI
    }.elsewhen(io.funct3 === "b100".U){
      io.alu_ctrl := "b00101".U  // XORI
    }.elsewhen(io.funct3 === "b010".U){
      io.alu_ctrl := "b00110".U  // SLTI
    }.elsewhen(io.funct3 === "b001".U){
      io.alu_ctrl := "b01000".U  // SLLI
    }.elsewhen(io.funct3 === "b011".U){
      io.alu_ctrl := "b01001".U  // SLTIU
    }.elsewhen(io.funct3 === "b101".U){
      when (io.funct7(5) === "b0".U){
        io.alu_ctrl := "b01010".U  // SRLI
      }.otherwise{
        io.alu_ctrl := "b01011".U
      }
    }.otherwise{
      io.alu_ctrl := "b00000".U
    }
  }.elsewhen(io.aluop === "b100".U){
    io.alu_ctrl := "b01100".U  // LUI
  }.elsewhen(io.aluop === "b101".U){
    io.alu_ctrl := "b01101".U  // AUIPC
  }.elsewhen(io.aluop === "b110".U){
    io.alu_ctrl := "b10001".U  // JALR
  }.elsewhen(io.aluop === "b111".U){
    io.alu_ctrl := "b10010".U  // JAL
  }.otherwise{
    io.alu_ctrl := "b00000".U
  }
}

class ImmGenerator(Width: Int = 32) extends Module {
  val io = IO(new Bundle {
    val instruction = Input(UInt(32.W))
    val imm_out = Output(UInt(Width.W))
  })
  var imm_out_reg = RegInit(0.U(Width.W))
  io.imm_out := imm_out_reg

  when(reset.asBool){
    io.imm_out := 0.U
  }.otherwise{
    when(io.instruction(6, 0) === "b0010011".U || io.instruction(6, 0) === "b0000011".U || io.instruction(6, 0) === "b1100111".U){ // I-type
      imm_out_reg := Cat(Fill(Width - 12, io.instruction(31)), io.instruction(31,20))
    }.elsewhen(io.instruction(6, 0) === "b0100011".U){ // S-type
      imm_out_reg := Cat(Fill(Width - 12, io.instruction(31)), io.instruction(31,25), io.instruction(11,7))
    }.elsewhen(io.instruction(6, 0) === "b1100011".U){ // B-type
      imm_out_reg := Cat(Fill(Width - 13, io.instruction(31)), io.instruction(31), io.instruction(7), io.instruction(30,25), io.instruction(11,8), 0.U(1.W))
    }.elsewhen(io.instruction(6, 0) === "b0110111".U || io.instruction(6, 0) === "b0010111".U){ // U-type
      if(Width > 32){
        imm_out_reg := Cat(Fill(Width - 32, 0.U), io.instruction(31,12), Fill(12, 0.U))
      }else{
        imm_out_reg := Cat(io.instruction(31,12), Fill(12, 0.U))
      }
    }.elsewhen(io.instruction(6, 0) === "b1101111".U){ // J-type
      imm_out_reg := Cat(Fill(Width - 21, io.instruction(31)), io.instruction(31), io.instruction(19,12), io.instruction(20), io.instruction(30,21), 0.U(1.W))
    }
  }

}

class Metronome(Width:Int = 32, Debug:Boolean = false) extends Module {
  val io = IO(new Bundle {
    val stuck = Input(Bool())
    val tick_pc = Output(Bool())
    val tick_ifid = Output(Bool())
    val tick_idex = Output(Bool())
    val tick_exmem = Output(Bool())
    val tick_memwb = Output(Bool())

    val debug_cycleCNT = if (Debug) Some(Output(UInt(5.W))) else None
  })
  /*
  PC: 5周期
  ID: 5周期
  EX: 5周期
  MEM:5/9周期 32-bit/64-bit
  WB: 5周期

  */

  var cycleMax = if (Width == 32) 25 else 29
  var tick_pc_reg = RegInit(false.B)
  var tick_ifid_reg = RegInit(false.B)
  var tick_idex_reg = RegInit(false.B)
  var tick_exmem_reg = RegInit(false.B)
  var tick_memwb_reg = RegInit(false.B)
  io.tick_pc := tick_pc_reg
  io.tick_ifid := tick_ifid_reg
  io.tick_idex := tick_idex_reg
  io.tick_exmem := tick_exmem_reg
  io.tick_memwb := tick_memwb_reg

  var cycleCNT = RegInit(1.U(5.W))
  var pc_flag = RegInit(false.B)
  var pc_flag_latch = RegInit(false.B)
  var ifid_flag = RegInit(false.B)
  var ifid_flag_latch = RegInit(false.B)
  var idex_flag = RegInit(false.B)
  var idex_flag_latch = RegInit(false.B)
  var exmem_flag = RegInit(false.B)
  var exmem_flag_latch = RegInit(false.B)
  var memwb_flag = RegInit(false.B)
  var memwb_flag_latch = RegInit(false.B)

  when(io.stuck =/= true.B){
    pc_flag := (cycleCNT === 0.U)
    pc_flag_latch := pc_flag
    ifid_flag := (cycleCNT === 5.U)
    ifid_flag_latch := ifid_flag
    idex_flag := (cycleCNT === 10.U)
    idex_flag_latch := idex_flag
    exmem_flag := (cycleCNT === (if(Width == 32) 15.U else 19.U))
    exmem_flag_latch := exmem_flag
    memwb_flag := (cycleCNT === (if(Width == 32) 20.U else 24.U))
    memwb_flag_latch := memwb_flag
    cycleCNT := Mux(cycleCNT === (cycleMax - 1).U, 0.U, cycleCNT + 1.U)
  }

  when(reset.asBool){
    tick_pc_reg := false.B
  }.elsewhen(pc_flag_latch === false.B && pc_flag === true.B){
    tick_pc_reg := true.B
  }.otherwise{
    tick_pc_reg := false.B
  }

  when(reset.asBool){
    tick_ifid_reg := false.B
  }.elsewhen(ifid_flag_latch === false.B && ifid_flag === true.B){
    tick_ifid_reg := true.B
  }.otherwise {
    tick_ifid_reg := false.B
  }
  when(reset.asBool){
    tick_idex_reg := false.B
  }.elsewhen(idex_flag_latch === false.B && idex_flag === true.B){
    tick_idex_reg := true.B
  }.otherwise {
    tick_idex_reg := false.B
  }

  var mem_accessCNT = RegInit(0.U(4.W))
  when(reset.asBool){
    tick_exmem_reg := false.B
    mem_accessCNT := 0.U
  }.elsewhen(exmem_flag_latch === false.B && exmem_flag === true.B){
    mem_accessCNT := 0.U
    tick_exmem_reg := true.B
  }.elsewhen(mem_accessCNT === (if(Width == 32) 4.U else 8.U)){
    tick_exmem_reg := false.B
    mem_accessCNT := 0.U
  }.otherwise {
    mem_accessCNT := mem_accessCNT + 1.U
  }

  when(reset.asBool){
    tick_memwb_reg := false.B
  }.elsewhen(memwb_flag_latch === false.B && memwb_flag === true.B){
    tick_memwb_reg := true.B
  }.otherwise {
    tick_memwb_reg := false.B
  }

}

class PC_Ctrl(Width:Int = 32) extends Module {
  val io = IO(new Bundle {
    var next_pc = Input(UInt(Width.W))
    var pc_write_en = Input(Bool())
    var pc_out = Output(UInt(Width.W))
    var pc_plus4 = Output(UInt(Width.W))
  })

  var pc_current = RegInit(0.U(Width.W))
  io.pc_out := pc_current
  io.pc_plus4 := pc_current + 4.U

  when(io.pc_write_en){
    pc_current := io.next_pc
  }.elsewhen(io.pc_write_en === true.B){
    pc_current := io.next_pc
  }

}

class OpcodeCtrl() extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val branch = Output(Bool())
    val memRead = Output(Bool())
    val memtoReg = Output(Bool())
    val aluop = Output(UInt(3.W))
    val memWrite = Output(Bool())
    val aluSrc = Output(Bool())
    val regWrite = Output(Bool())
  })
  val branch = RegInit(false.B)
  val memRead = RegInit(false.B)
  val memtoReg = RegInit(false.B)
  val aluop = RegInit(0.U(3.W))
  val memWrite = RegInit(false.B)
  val aluSrc = RegInit(false.B)
  val regWrite = RegInit(false.B)
  io.branch := branch
  io.memRead := memRead
  io.memtoReg := memtoReg
  io.aluop := aluop
  io.memWrite := memWrite
  io.aluSrc := aluSrc
  io.regWrite := regWrite

  when(io.opcode === "b0110011".U){
    // R-type
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b010".U
    memWrite := false.B
    aluSrc := false.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b0000011".U){
    // LD-type
    branch := false.B
    memRead := true.B
    memtoReg := true.B
    aluop := "b000".U
    memWrite := false.B
    aluSrc := true.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b0100011".U){
    // S-type
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b000".U
    memWrite := true.B
    aluSrc := true.B
    regWrite := false.B
  }.elsewhen(io.opcode === "b1100011".U){
    // SB-type
    branch := true.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b001".U
    memWrite := false.B
    aluSrc := false.B
    regWrite := false.B
  }.elsewhen(io.opcode === "b0010011".U){
    // I-type ALU operations
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b011".U
    memWrite := false.B
    aluSrc := true.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b0110111".U){
    // LUI
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b100".U
    memWrite := false.B
    aluSrc := true.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b0010111".U){
    // AUIPC
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b101".U
    memWrite := false.B
    aluSrc := true.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b1100111".U){
    // JALR
    branch := true.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b110".U
    memWrite := false.B
    aluSrc := false.B
    regWrite := true.B
  }.elsewhen(io.opcode === "b1101111".U){
    // JAL
    branch := true.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b111".U
    memWrite := false.B
    aluSrc := false.B
    regWrite := true.B

  }.otherwise{
    branch := false.B
    memRead := false.B
    memtoReg := false.B
    aluop := "b000".U
    memWrite := false.B
    aluSrc := false.B
    regWrite := false.B
  }

}


