package scpu
import chisel3._
import chisel3.stage.ChiselStage


object Elaborate extends App {
  println("正在生成Verilog 文件...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new ImmGenerator(),
    Array(
      "--target-dir", "./generated",
      "--output-file", "ALU"
    )
  )
  println("生成完成！")
}
