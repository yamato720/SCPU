module ALU_ctrl (
    input  wire [1:0] aluop,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_control
);

wire [5:0] check;
assign check = {aluop, funct7[5], funct3};
always @(*) begin
    case (aluop)
        2'b00: alu_control = 4'b0000; // load/store ADD
        2'b01: alu_control = 4'b0001; // branch SUB
        2'b10: begin // R-type
            case ({funct7[5], funct3})
                4'b0000: alu_control = 4'b0000; // ADD
                4'b1000: alu_control = 4'b0001; // SUB
                4'b0111: alu_control = 4'b0011; // AND
                4'b0110: alu_control = 4'b0100; // OR
                4'b0100: alu_control = 4'b0101; // XOR
                4'b0010: alu_control = 4'b0110; // SLT
                4'b0011: alu_control = 4'b0111; // equ
                default: alu_control = 4'b0000;
            endcase
        end
        2'b11: begin // I-type
            alu_control = 4'b0000; // temp
        end
        default: alu_control = 4'b0000;
    endcase
end

    
endmodule