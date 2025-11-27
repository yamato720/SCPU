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
      io.alu_ctrl := "b01100".U  // ADDI
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

class ImmGenerator(width: Int = 32) extends Module {
  val io = IO(new Bundle {
    val instr = Input(UInt(32.W))
    val imm_out = Output(UInt(width.W))
  })
  var imm_out_reg = RegInit(0.U(width.W))
  io.imm_out := imm_out_reg

  when(reset.asBool){
    io.imm_out := 0.U
  }.otherwise{
    when(io.instr === "b0010011".U || io.instr === "b0000011".U || io.instr === "b1100111".U){ // I-type
      imm_out_reg := Cat(Fill(width - 12, io.instr(31)), io.instr(31,20))
    }.elsewhen(io.instr === "b0100011".U){ // S-type
      imm_out_reg := Cat(Fill(width - 12, io.instr(31)), io.instr(31,25), io.instr(11,7))
    }.elsewhen(io.instr === "b1100011".U){ // B-type
      imm_out_reg := Cat(Fill(width - 13, io.instr(31)), io.instr(31), io.instr(7), io.instr(30,25), io.instr(11,8), 0.U(1.W))
    }.elsewhen(io.instr === "b0110111".U || io.instr === "b0010111".U){ // U-type
      if(width > 32){
        imm_out_reg := Cat(Fill(width - 32, 0.U), io.instr(31,12), Fill(12, 0.U))
      }else{
        imm_out_reg := Cat(io.instr(31,12), Fill(12, 0.U))
      }
    }.elsewhen(io.instr === "b1101111".U){ // J-type
      imm_out_reg := Cat(Fill(width - 21, io.instr(31)), io.instr(31), io.instr(19,12), io.instr(20), io.instr(30,21), 0.U(1.W))
    }
  }

}

class Metronome extends Module {
  val io = IO(new Bundle {
    val stuck = Input(Bool())
    val tick_pc = Output(Bool())
    val tick_ifid = Output(Bool())
    val tick_idex = Output(Bool())
    val tick_exmem = Output(Bool())
    val tick_memwb = Output(Bool())
  })
  /*
  PC: 5周期
  ID: 5周期
  EX: 5周期
  MEM:5周期
  WB: 5周期
  */
  val cycleMax = 25
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

  var cycleCNT = RegInit(0.U(5.W))
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

  when (reset.asBool) {
    cycleCNT := 1.U
    pc_flag := false.B
    pc_flag_latch := false.B
    ifid_flag := false.B
    ifid_flag_latch := false.B
    idex_flag := false.B
    idex_flag_latch := false.B
    exmem_flag := false.B
    exmem_flag_latch := false.B
    memwb_flag := false.B
    memwb_flag_latch := false.B
  }.elsewhen(io.stuck =/= true.B){
    pc_flag := (cycleCNT === 0.U)
    pc_flag_latch := pc_flag
    ifid_flag := (cycleCNT === 5.U)
    ifid_flag_latch := ifid_flag
    idex_flag := (cycleCNT === 10.U)
    idex_flag_latch := idex_flag
    exmem_flag := (cycleCNT === 15.U)
    exmem_flag_latch := exmem_flag
    memwb_flag := (cycleCNT === 20.U)
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
  }.elsewhen(mem_accessCNT === 4.U){
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

class PC_Ctrl extends Module {
  val io = IO(new Bundle {
    var next_pc = Input(UInt(32.W))
    var pc_write_en = Input(Bool())
    var pc_out = Output(UInt(32.W))
    var pc_plus4 = Output(UInt(32.W))
  })

  var pc_current = RegInit(0.U(32.W))
  io.pc_out := pc_current
  io.pc_plus4 := pc_current + 4.U

  when(reset.asBool){
    pc_current := 0.U
  }.elsewhen(io.pc_write_en){
    pc_current := io.next_pc
  }.elsewhen(io.pc_write_en === true.B){
    pc_current := io.next_pc
  }

}



