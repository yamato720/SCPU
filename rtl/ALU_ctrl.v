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
                4'b0001: alu_control = 4'b1000; // SLL
                4'b0011: alu_control = 4'b1001; // SLTU
                4'b0101: alu_control = 4'b1010; // SRL
                4'b1101: alu_control = 4'b1011; // SRA
                default: alu_control = 4'b0000;
            endcase
        end
        2'b11: begin // I-type
            case (funct3)
                3'b000: alu_control = 4'b0000; // ADDI
                3'b111: alu_control = 4'b0011; // ANDI
                3'b110: alu_control = 4'b0100; // ORI
                3'b100: alu_control = 4'b0101; // XORI
                3'b010: alu_control = 4'b0110; // SLTI
                3'b001: alu_control = 4'b1000; // SLLI
                3'b011: alu_control = 4'b1001; // SLTIU
                3'b101: begin
                    if (funct7[5] == 1'b0) begin
                        alu_control = 4'b1010; // SRLI
                    end else begin
                        alu_control = 4'b1011; // SRAI
                    end
                end
                default: alu_control = 4'b0000;
            endcase
        end
        default: alu_control = 4'b0000;
    endcase
end

    
endmodule