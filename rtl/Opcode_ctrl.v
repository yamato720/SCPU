module Opcode_ctrl (
    input  wire [6:0] funct7,
    output reg        branch,
    output reg        mem_read,
    output reg        mem2reg,
    output reg [1:0]  aluop,
    output reg        mem_write,
    output reg        alu_src,
    output reg        reg_write
);

always @(*) begin
    case (funct7)
    7'b0110011: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 2'b10; // R-type
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b1;
    end
    7'b0000011: begin
        branch    = 1'b0;
        mem_read  = 1'b1;
        mem2reg   = 1'b1;
        aluop     = 2'b00; // LD-type
        mem_write = 1'b0;
        alu_src   = 1'b1;
        reg_write = 1'b1;
    end
    7'b0100011: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 2'b00; // S-type
        mem_write = 1'b1;
        alu_src   = 1'b1;
        reg_write = 1'b0;
    end
    7'b1100011: begin
        branch    = 1'b1;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 2'b01; // SB-type
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b0;
    end
    default: begin
        branch    = 1'b0;
        mem_read  = 1'b0;
        mem2reg   = 1'b0;
        aluop     = 2'b00; // Default
        mem_write = 1'b0;
        alu_src   = 1'b0;
        reg_write = 1'b0;
    end
    endcase
end





endmodule