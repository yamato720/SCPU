`timescale 1ps / 1ps
module tb_fetch();


reg         clk;
reg         rst;
reg [31:0]  pc_in;


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

    #25;
    rst = 1'b0;
    #65;
    #100;
    pc_in = 32'd4;
    #100;
    pc_in = 32'd8;
    #100;
    pc_in = 32'd12;
    #100;
    pc_in = 32'd16;
    #100;
    pc_in = 32'd20;
    #100;
    pc_in = 32'd24;
    #100;
    pc_in = 32'd28;
    #100;
    pc_in = 32'd32;
    #100;
    pc_in = 32'd36;
    #100;
    pc_in = 32'd40;
    #100;
    pc_in = 32'd44;
    #100
    #100;
    pc_in = 32'd48;
    #100;
    pc_in = 32'd52;
    #100;
    pc_in = 32'd56;
    #100;
    pc_in = 32'd60;


    #200;
    $finish;
end



always #10 clk = ~clk;

wire [31:0] instruction;
assign ins_out = {funct7, rs2, rs1, funct3, rd, opcode};
wire [7:0]  ins_low;
wire [7:0]  ins_high;
wire [31:0] addr_low;
wire [31:0] addr_high;

bram_8_4096_ins_shell bram_inst (
    .clka(clk),
    .ena(1'b1),
    .wea(1'b0),
    .addra(addr_low[11:0]),
    .dina(8'b0),
    .douta(ins_low),
    .clkb(clk),
    .enb(1'b1),
    .web(1'b0),
    .addrb(addr_high[11:0]),
    .dinb(8'b0),
    .doutb(ins_high)
);

wire valid;
wire busy;

Ins_buffer u_ins_buffer (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .ins_low(ins_low),
    .ins_high(ins_high),
    .ins_out(instruction),
    .addr_low(addr_low),
    .addr_high(addr_high),
    .valid(valid),
    .busy(busy)
);



Decoder u_decoder (
    .clk(clk),
    .rst(rst),
    .instruction(instruction),
    .busy(busy),
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