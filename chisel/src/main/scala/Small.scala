package scpu

import chisel3._

class Adder(width: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val sum = Output(UInt(width.W))
  })

  io.sum := io.a + io.b
}

class AndGate(width: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })

  io.out := io.a & io.b
}

class LeftShifter(width: Int, count: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(width.W))
    val shift = Input(UInt(count.W)) // assuming shift amount is 5 bits
    val out = Output(UInt(width.W))
  })

  io.out := io.in << io.shift
}

class Muxer2_1(width: Int) extends Module {
  val io = IO(new Bundle {
    val in0 = Input(UInt(width.W))
    val in1 = Input(UInt(width.W))
    val sel = Input(Bool())
    val out = Output(UInt(width.W))
  })

  io.out := Mux(io.sel, io.in1, io.in0)
}

class Muxer8_3(width: Int) extends Module {
  val io = IO(new Bundle {
    val in0 = Input(UInt(width.W))
    val in1 = Input(UInt(width.W))
    val in2 = Input(UInt(width.W))
    val in3 = Input(UInt(width.W))
    val in4 = Input(UInt(width.W))
    val in5 = Input(UInt(width.W))
    val in6 = Input(UInt(width.W))
    val in7 = Input(UInt(width.W))
    val sel = Input(UInt(3.W))
    val out = Output(UInt(width.W))
  })

  when(io.sel === 0.U) {
    io.out := io.in0
  } .elsewhen(io.sel === 1.U) {
    io.out := io.in1
  } .elsewhen(io.sel === 2.U) {
    io.out := io.in2
  } .elsewhen(io.sel === 3.U) {
    io.out := io.in3
  } .elsewhen(io.sel === 4.U) {
    io.out := io.in4
  } .elsewhen(io.sel === 5.U) {
    io.out := io.in5
  } .elsewhen(io.sel === 6.U) {
    io.out := io.in6
  } .otherwise {
    io.out := io.in7
  }
}

