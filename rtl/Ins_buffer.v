module Ins_buffer(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pc_in,
    input  wire [31:0] base_in,
    output reg  [31:0] ins_out
);

reg [31:0] ins [0:127];

// reg        valid;
reg [31:0] pc_base;
reg [7:0]  index;

always @(*) begin
    index = pc_in - pc_base;
end

initial begin
    // ==================== RISC-V 测试指令序列 ====================
    // 预期初始状态: 所有寄存器 = 0
    // 为了测试有意义，需要先初始化一些非零值到寄存器
    
    // --- 使用伪指令初始化寄存器（实际需要根据你的 CPU 是否支持 I-type） ---
    // 如果只支持 R-type，则需要预先在 Registers.v 中设置初始值
    // 这里假设 x1=15, x2=10, x3=5 已通过其他方式初始化
    
    // 1. ADD: x4 = x1 + x2 (假设 x1=15, x2=10, 结果=25)
    // R-type: opcode=0110011, rd=x4, funct3=000, rs1=x1, rs2=x2, funct7=0000000
    // 格式: funct7[31:25] | rs2[24:20] | rs1[19:15] | funct3[14:12] | rd[11:7] | opcode[6:0]
    ins[0] = 32'h00208233; // ADD x4, x1, x2
    
    // 2. SUB: x5 = x1 - x3 (15 - 5 = 10)
    // R-type: funct7=0100000, rs2=x3, rs1=x1, funct3=000, rd=x5
    ins[1] = 32'h403082B3; // SUB x5, x1, x3
    
    // 3. AND: x6 = x1 & x2 (15 & 10 = 10, 二进制: 1111 & 1010 = 1010)
    // R-type: funct7=0000000, rs2=x2, rs1=x1, funct3=111, rd=x6
    ins[2] = 32'h0020F333; // AND x6, x1, x2
    
    // 4. OR: x7 = x1 | x3 (15 | 5 = 15, 二进制: 1111 | 0101 = 1111)
    // R-type: funct7=0000000, rs2=x3, rs1=x1, funct3=110, rd=x7
    ins[3] = 32'h0030E3B3; // OR x7, x1, x3
    
    // 5. XOR: x8 = x1 ^ x3 (15 ^ 5 = 10, 二进制: 1111 ^ 0101 = 1010)
    // R-type: funct7=0000000, rs2=x3, rs1=x1, funct3=100, rd=x8
    ins[4] = 32'h0030C433; // XOR x8, x1, x3
    
    // 6. SLT: x9 = (x3 < x1) ? 1 : 0 (5 < 15 = 1)
    // R-type: funct7=0000000, rs2=x1, rs1=x3, funct3=010, rd=x9
    ins[5] = 32'h0011A4B3; // SLT x9, x3, x1
    
    // 7. SLT: x10 = (x1 < x3) ? 1 : 0 (15 < 5 = 0)
    // R-type: funct7=0000000, rs2=x3, rs1=x1, funct3=010, rd=x10
    ins[6] = 32'h0030A533; // SLT x10, x1, x3
    
    // 8. ADD: x11 = x4 + x5 (25 + 10 = 35)
    ins[7] = 32'h005205B3; // ADD x11, x4, x5
    
    // 9. SUB: x12 = x4 - x3 (25 - 5 = 20)
    ins[8] = 32'h40320633; // SUB x12, x4, x3
    
    // 10. NOP (用于结束或占位)
    ins[9] = 32'h00000013; // NOP (ADDI x0, x0, 0)
    
    // 填充剩余指令为 NOP
    for (index = 10; index < 128; index = index + 1) begin
        ins[index] = 32'h00000013; // NOP
    end
    
    // ==================== 测试说明 ====================
    // 注意: 由于 Registers.v 初始值全为 0，这些指令执行结果都会是 0
    // 建议在 Registers.v 的 initial 块中设置:
    //   reg_file[1] = 32'd15;  // x1 = 15
    //   reg_file[2] = 32'd10;  // x2 = 10
    //   reg_file[3] = 32'd5;   // x3 = 5
    // 或者添加 I-type (ADDI) 支持来动态初始化
end



always @(posedge clk) begin
    if (rst) begin
        ins_out <= 32'b0;
        // valid <= 1'b1;
        pc_base <= 32'b0;
    end else begin
        if (index <= 8'd11) begin
            ins_out <= ins[index];
            // valid <= 1'b1;
        end else begin
            ins_out <= 32'h00000013; // NOP
            // valid <= 1'b0;
        end
    end
end

endmodule

