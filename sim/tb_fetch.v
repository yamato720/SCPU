module tb_fetch();


reg         clk;
reg         rst;
reg [31:0]  pc_in;
reg [31:0]  base_in;


wire [6:0]  opcode;
wire [4:0]  rd;
wire [4:0]  rs1;
wire [4:0]  rs2;
wire [2:0]  funct3;
wire [6:0]  funct7;

wire [31:0] ins_out;


initial begin
    clk = 1'b0;
    rst = 1'b1;
    pc_in = 32'b0;
    base_in = 32'b0;

    #25;
    rst = 1'b0;
    pc_in = 32'd1;
    #40;
    pc_in = 32'd2;
    #40;
    pc_in = 32'd3;
    #40;
    pc_in = 32'd4;
    #40;
    pc_in = 32'd5;
    #40;
    pc_in = 32'd6;
    #40;
    pc_in = 32'd7;
    #40;
    pc_in = 32'd8;
    #200;
    $finish;
end



always #10 clk = ~clk;

wire [31:0] instruction;
assign ins_out = {funct7, rs2, rs1, funct3, rd, opcode};


Ins_buffer u_ins_buffer (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .base_in(base_in),
    .ins_out(instruction)
);

Decoder u_decoder (
    .clk(clk),
    .rst(rst),
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .funct3(funct3),
    .funct7(funct7)
);




// ins_fetch ins_fetch_inst
// (   .base_in(base_in),
//     .clk(clk),
//     .funct3(funct3),
//     .funct7(funct7),
//     .opcode(opcode),
//     .pc_in(pc_in),
//     .rd(rd),
//     .rs1(rs1),
//     .rs2(rs2),
//     .rst(rst)
// );


endmodule