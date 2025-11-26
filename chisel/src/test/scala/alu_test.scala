package scpu
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class alu_test extends AnyFlatSpec with ChiselScalatestTester {
  "ALU" should "correctly perform addition" in {
    test(new ALU) { c =>
      // Test addition: 5 + 3 = 8
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00000".U) // ADD operation
      c.io.pc.poke(0.U)

      // 第1步：tick_idex=1，锁存输入数据
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)

      // 第2步：tick_idex=0，执行运算
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)

      // 第3步：读取结果
      c.io.alu_result.expect(8.U)
      c.io.zero.expect(false.B)
      c.io.branch_taken.expect(0.U)
    }
  }

  it should "detect overflow in addition" in {
    test(new ALU) { c =>
      // Test overflow: 0x7FFFFFFF + 1 = overflow
      c.io.a_in.poke("h7FFFFFFF".U)
      c.io.b_in.poke(1.U)
      c.io.alu_ctrl_in.poke("b00000".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.overflow.expect(true.B)
    }
  }

  it should "correctly perform subtraction" in {
    test(new ALU) { c =>
      // Test subtraction: 5 - 3 = 2
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00001".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(2.U)
      c.io.zero.expect(false.B)
    }
  }

  it should "correctly identify zero result" in {
    test(new ALU) { c =>
      // Test subtraction: 3 - 3 = 0
      c.io.a_in.poke(3.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00001".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(0.U)
      c.io.zero.expect(true.B)
    }
  }

  it should "correctly perform NOT operation" in {
    test(new ALU) { c =>
      // Test NOT operation: ~5 = 0xFFFFFFFA
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(0.U)
      c.io.alu_ctrl_in.poke("b00010".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("hFFFFFFFA".U)
    }
  }

  it should "correctly perform AND operation" in {
    test(new ALU) { c =>
      // Test AND operation: 5 & 3 = 1
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00011".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
    }
  }

  it should "correctly perform OR operation" in {
    test(new ALU) { c =>
      // Test OR operation: 5 | 3 = 7
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00100".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(7.U)
    }
  }

  it should "correctly perform XOR operation" in {
    test(new ALU) { c =>
      // Test XOR operation: 5 ^ 3 = 6
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00101".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(6.U)
    }
  }

  it should "correctly perform BLT (signed less than) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke("hFFFFFFFB".U) // -5 in two's complement
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00110".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform BLT (signed less than) - false case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00110".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(0.U)
      c.io.branch_taken.expect(0.U)
    }
  }

  it should "correctly perform BEQ (branch equal) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(5.U)
      c.io.alu_ctrl_in.poke("b00111".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform BEQ (branch equal) - false case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b00111".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(0.U)
      c.io.branch_taken.expect(0.U)
    }
  }

  it should "correctly perform SLL (shift left logical)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(2.U)
      c.io.alu_ctrl_in.poke("b01000".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(20.U)
    }
  }

  it should "correctly perform BLTU (unsigned less than) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(3.U)
      c.io.b_in.poke(5.U)
      c.io.alu_ctrl_in.poke("b01001".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform SRL (shift right logical)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(20.U)
      c.io.b_in.poke(2.U)
      c.io.alu_ctrl_in.poke("b01010".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(5.U)
    }
  }

  it should "correctly perform SRA (shift right arithmetic)" in {
    test(new ALU) { c =>
      c.io.a_in.poke("hFFFFFFF8".U)
      c.io.b_in.poke(1.U)
      c.io.alu_ctrl_in.poke("b01011".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("hFFFFFFFC".U)
    }
  }

  it should "correctly perform LUI (load upper immediate)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(0.U)
      c.io.b_in.poke("h12345000".U)
      c.io.alu_ctrl_in.poke("b01100".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("h12345000".U)
    }
  }

  it should "correctly perform AUIPC (add upper immediate to PC)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(0.U)
      c.io.b_in.poke("h1000".U)
      c.io.alu_ctrl_in.poke("b01101".U)
      c.io.pc.poke("h100".U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("h1100".U)
    }
  }

  it should "correctly perform BNE (branch not equal) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b01110".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform BNE (branch not equal) - false case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(5.U)
      c.io.alu_ctrl_in.poke("b01110".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(0.U)
      c.io.branch_taken.expect(0.U)
    }
  }

  it should "correctly perform BGE (signed greater or equal) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b01111".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform BGE (signed greater or equal) - false case" in {
    test(new ALU) { c =>
      c.io.a_in.poke("hFFFFFFFB".U) // -5
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b01111".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(0.U)
      c.io.branch_taken.expect(0.U)
    }
  }

  it should "correctly perform BGEU (unsigned greater or equal) - true case" in {
    test(new ALU) { c =>
      c.io.a_in.poke(5.U)
      c.io.b_in.poke(3.U)
      c.io.alu_ctrl_in.poke("b10000".U)
      c.io.pc.poke(0.U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect(1.U)
      c.io.branch_taken.expect("b001".U)
    }
  }

  it should "correctly perform JALR (jump and link register)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(0.U)
      c.io.b_in.poke(0.U)
      c.io.alu_ctrl_in.poke("b10001".U)
      c.io.pc.poke("h100".U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("h104".U)
      c.io.branch_taken.expect("b011".U)
    }
  }

  it should "correctly perform JAL (jump and link)" in {
    test(new ALU) { c =>
      c.io.a_in.poke(0.U)
      c.io.b_in.poke(0.U)
      c.io.alu_ctrl_in.poke("b10010".U)
      c.io.pc.poke("h100".U)
      c.io.tick_idex.poke(true.B)
      c.clock.step(1)
      c.io.tick_idex.poke(false.B)
      c.clock.step(1)
      c.io.alu_result.expect("h104".U)
      c.io.branch_taken.expect("b010".U)
    }
  }
}
