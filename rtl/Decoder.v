module Decoder(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] instruction,
    input  wire        busy,
    input  wire        tick_ifid,
    output wire [6:0]  opcode,
    output wire [4:0]  rd,
    output wire [4:0]  rs1,
    output wire [4:0]  rs2,
    output wire [2:0]  funct3,
    output wire [6:0]  funct7
);

reg [31:0] instruction_reg;

always @(posedge clk) begin
    if (rst) begin
        instruction_reg <= 32'h00000013;
    end else if(!busy && tick_ifid)begin
        instruction_reg <= instruction;
    end else begin
        instruction_reg <= instruction_reg;
    end
end

assign opcode = instruction_reg[6:0];
assign rd = instruction_reg[11:7];
assign rs1 = instruction_reg[19:15];
assign rs2 = instruction_reg[24:20];
assign funct3 = instruction_reg[14:12];
assign funct7 = instruction_reg[31:25];

endmodule
