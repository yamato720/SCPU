module ALU_ctrl (
    input  wire [2:0] aluop,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [4:0] alu_control
);





wire [5:0] check;
assign check = {aluop, funct7[5], funct3};
always @(*) begin
    case (aluop)
        3'b000: alu_control = 5'b00000; // load/store ADD
        3'b001: begin
            case(funct3)
                3'b000: alu_control = 5'b00111; // BEQ
                3'b001: alu_control = 5'b01110; // BNE
                3'b100: alu_control = 5'b00110; // BLT
                3'b101: alu_control = 5'b01111; // BGE
                3'b110: alu_control = 5'b01001; // BLTU
                3'b111: alu_control = 5'b10000; // BGEU
                default: alu_control = 5'b00000;
            endcase
        end
        3'b010: begin // R-type
            case ({funct7[5], funct3})
                4'b0000: alu_control = 5'b00000; // ADD
                4'b1000: alu_control = 5'b00001; // SUB
                4'b0111: alu_control = 5'b00011; // AND
                4'b0110: alu_control = 5'b00100; // OR
                4'b0100: alu_control = 5'b00101; // XOR
                4'b0010: alu_control = 5'b00110; // SLT
                4'b0001: alu_control = 5'b01000; // SLL
                4'b0011: alu_control = 5'b01001; // SLTU
                4'b0101: alu_control = 5'b01010; // SRL
                4'b1101: alu_control = 5'b01011; // SRA
                default: alu_control = 5'b00000;
            endcase
        end
        3'b011: begin // I-type
            case (funct3)
                3'b000: alu_control = 5'b00000; // ADDI
                3'b111: alu_control = 5'b00011; // ANDI
                3'b110: alu_control = 5'b00100; // ORI
                3'b100: alu_control = 5'b00101; // XORI
                3'b010: alu_control = 5'b00110; // SLTI
                3'b001: alu_control = 5'b01000; // SLLI
                3'b011: alu_control = 5'b01001; // SLTIU
                3'b101: begin
                    if (funct7[5] == 1'b0) begin
                        alu_control = 5'b01010; // SRLI
                    end else begin
                        alu_control = 5'b01011; // SRAI
                    end
                end
                default: alu_control = 5'b00000;
            endcase
        end
        3'b100: alu_control = 5'b01100; // LUI
        3'b101: alu_control = 5'b01101; // AUIPC
        3'b110: alu_control = 5'b10001; // JALR 
        3'b111: alu_control = 5'b10010; // JAL 
        default: alu_control = 5'b00000;
    endcase
end

    
endmodule