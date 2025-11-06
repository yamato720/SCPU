module ALU_ctrl (
    input  wire [1:0] aluop,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_control
);

always @(*) begin
    case ({aluop, funct7[5], funct3})
        6'b00xxxx:alu_control = 4'b0000; // ADD
        6'bx1xxxx:alu_control = 4'b0001; // SUB for branch
        6'b1x0000:alu_control = 4'b0000; // R-type ADD
        6'b1x1000:alu_control = 4'b0001; // R-type SUB
        6'b1xx111:alu_control = 4'b0011; // R-type AND
        6'b1xx110:alu_control = 4'b0100; // R-type OR
        6'b1xx100:alu_control = 4'b0101; // R-type XOR
        6'b1xx010:alu_control = 4'b0110; // R-type SLT
        // 6'b1xx001:alu_control = 4'b0111; // R-type EQU
        default:   alu_control = 4'b0000; // Default to ADD

    endcase
end

    
endmodule