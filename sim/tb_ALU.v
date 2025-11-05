`timescale 1ns/1ns

module tb_ALU;

    reg         rst;
    reg [31:0]  a;
    reg [31:0]  b;
    reg [2:0]   alu_control;
    wire [31:0] alu_result;
    wire        zero;
    wire        cout;
    wire        overflow;

    ALU uut (
        .rst(rst),
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero),
        .cout(cout),
        .overflow(overflow)
    );

    initial begin
        rst = 1;
        a = 32'd12;     // 00000 0000 0000 0000 0000 0000 0000 1100
        b = 32'd14;     // 00000 0000 0000 0000 0000 0000 0000 1110
        alu_control = 3'b000;
        #10;
        rst = 0;
        #20;
        alu_control = 3'b001; // SUB
        #20;
        alu_control = 3'b010; // NOT A answer should be -13
        #20;
        alu_control = 3'b011; // A AND B answer should be 12
        #20;
        alu_control = 3'b100; // A OR B answer should be 14
        #20;
        alu_control = 3'b101; // A XOR B answer should be 2
        #20;
        alu_control = 3'b110; // SLT answer should be 1
        #20;
        alu_control = 3'b111; // EQ answer should be 0
        #20;
        b=32'd12;     // 00000 0000 0000 0000 0000 0000 0000 1100
        #20;
        alu_control = 3'b110; // SLT answer should be 0
        #20;
        $stop;
    end

endmodule
