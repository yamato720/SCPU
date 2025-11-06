module top (
    input  wire        clk,
    input  wire        rst,
    input  wire        pc_write
);


wire [31:0] next_pc;
wire [31:0] pc_out;
wire [31:0] pc_plus4;

PC_ctrl u_pc_ctrl (
    .next_pc(next_pc), 
    .pc_write(pc_write),
    .clk(clk),
    .rst(rst),
    .pc_out(pc_out),
    .pc_plus4(pc_plus4)
);

wire [31:0] ins_out;
Ins_buffer u_ins_buffer (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_out),
    .base_in(32'b0),
    .ins_out(ins_out)
);

wire [6:0]  opcode;
wire [4:0]  rd;
wire [4:0]  rs1;
wire [4:0]  rs2;
wire [2:0]  funct3;
wire [6:0]  funct7;

Decoder u_decoder (
    .clk(clk),
    .rst(rst),
    .instruction(ins_out),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .funct3(funct3),
    .funct7(funct7)
);

wire        branch;
wire        mem_read;
wire        mem2reg;
wire [1:0]  aluop;
wire        mem_write;
wire        alu_src;
wire        reg_write;

Opcode_ctrl u_opcode_ctrl (
    .opcode(opcode),
    .branch(branch),
    .mem_read(mem_read),
    .mem2reg(mem2reg),
    .aluop(aluop),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write)
);

wire [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

Registers u_registers (
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),
    .read_reg1(rs1),
    .read_reg2(rs2),
    .write_reg(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

wire [63:0] imm_out_64;
wire [31:0] imm_out_32;

ImmGenerator u_imm_gen (
    .instruction(ins_out),
    .imm_out_64(imm_out_64),
    .imm_out_32(imm_out_32)
);
wire [31:0] alu_src_out;

mux2_1 u_alu_src_mux (
    .in0(read_data2),
    .in1(imm_out_32),
    .sel(alu_src),
    .out(alu_src_out)
);

wire [3:0] alu_control;
wire [31:0] alu_result;

ALU_ctrl u_alu_ctrl (
    .aluop(aluop),
    .funct3(funct3),
    .funct7(funct7),
    .alu_control(alu_control)
);

wire        zero;
wire        cout;
wire        overflow;

ALU u_alu (   
    .rst(rst),
    .a(read_data1),
    .b(alu_src_out),
    .alu_control(alu_control),
    .alu_result(alu_result),
    .zero(zero),
    .cout(cout),
    .overflow(overflow)
);

wire [31:0] next_pc_branch;

adder_int32 u_pc_adder (
    .a(pc_out),
    .b(imm_out_32),
    .sum(next_pc_branch)
);
wire pc_select;

and_gate u_branch_and (
    .a(branch),
    .b(zero),
    .out(pc_select)
);

mux2_1 u_pc_mux (
    .in0(pc_plus4),
    .in1(next_pc_branch),
    .sel(pc_select),
    .out(next_pc)
);

DataMemory u_data_memory (
    .clk(clk),
    .rst(rst),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .addr(alu_result),
    .write_data(read_data2),
    .read_data(read_data)
);

mux2_1 u_mem2reg_mux (
    .in0(alu_result),
    .in1(read_data),
    .sel(mem2reg),
    .out(write_data)
);


endmodule