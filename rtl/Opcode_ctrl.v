module Opcode_ctrl (
    input  wire [6:0] opcode,
    output reg        branch,
    output reg        mem_read,
    output reg        mem2reg,
    output reg [2:0]  aluop,
    output reg        mem_write,
    output reg        alu_src,
    output reg        reg_write
);

always @(*) begin
    case (opcode)
    7'b0110011: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b010; // R-type
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b1;
    end
    7'b0110111: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b100; // LUI
        mem_write = 1'b0;
        alu_src   = 1'b1;
        reg_write = 1'b1;
    end
    7'b0010111: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b101; // AUIPC
        mem_write = 1'b0;
        alu_src   = 1'b1;
        reg_write = 1'b1;
    end
    7'b0000011: begin
        branch    = 1'b0;
        mem_read  = 1'b1;
        mem2reg   = 1'b1;
        aluop     = 3'b000; // LD-type
        mem_write = 1'b0;
        alu_src   = 1'b1;
        reg_write = 1'b1;
    end
    7'b0010011: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b011; // I-type
        mem_write = 1'b0;
        alu_src   = 1'b1;
        reg_write = 1'b1;
    end
    7'b0100011: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b000; // S-type
        mem_write = 1'b1;
        alu_src   = 1'b1;
        reg_write = 1'b0;
    end
    7'b1100011: begin
        branch    = 1'b1;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b001; // SB-type
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b0;
    end
    7'b1100111: begin
        branch    = 1'b1;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b110; // jalr
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b1;
    end
    7'b1101111: begin
        branch    = 1'b1;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b111; // jal
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b1;
    end
    default: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 3'b000; // Default
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b0;
    end
    endcase
end





endmodule