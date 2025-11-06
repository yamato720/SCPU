module Registers(
    input  wire        clk,
    input  wire        rst,
    input  wire        reg_write,
    input  wire [4:0]  read_reg1,
    input  wire [4:0]  read_reg2,
    input  wire [4:0]  write_reg,
    input  wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

reg [31:0] reg_file [0:31];

initial begin
    reg_file[0] = 32'b0;          // x0: 固定为 0 (RISC-V 规范)
    reg_file[1] = 32'd15;         // x1: 初始化为 15 (测试用)
    reg_file[2] = 32'd10;         // x2: 初始化为 10 (测试用)
    reg_file[3] = 32'd5;          // x3: 初始化为 5 (测试用)
    reg_file[4] = 32'b0;
    reg_file[5] = 32'b0;
    reg_file[6] = 32'b0;
    reg_file[7] = 32'b0;
    reg_file[8] = 32'b0;
    reg_file[9] = 32'b0;
    reg_file[10] = 32'b0;
    reg_file[11] = 32'b0;
    reg_file[12] = 32'b0;
    reg_file[13] = 32'b0;
    reg_file[14] = 32'b0;
    reg_file[15] = 32'b0;
    reg_file[16] = 32'b0;
    reg_file[17] = 32'b0;
    reg_file[18] = 32'b0;
    reg_file[19] = 32'b0;
    reg_file[20] = 32'b0;
    reg_file[21] = 32'b0;
    reg_file[22] = 32'b0;
    reg_file[23] = 32'b0;
    reg_file[24] = 32'b0;
    reg_file[25] = 32'b0;
    reg_file[26] = 32'b0;
    reg_file[27] = 32'b0;
    reg_file[28] = 32'b0;
    reg_file[29] = 32'b0;
    reg_file[30] = 32'b0;
    reg_file[31] = 32'b0;
end

always @(posedge clk) begin
    if (rst) begin
        // Reset all registers
        reg_file[0] <= 32'd0;
        // reg_file[1] <= 32'd1;
        // reg_file[2] <= 32'd2;
        // reg_file[3] <= 32'd3;
        // reg_file[4] <= 32'd4;
        // reg_file[5] <= 32'd5;
        // reg_file[6] <= 32'd6;
        // reg_file[7] <= 32'd7;
        // reg_file[8] <= 32'd8;
        // reg_file[9] <= 32'd9;
        // reg_file[10] <= 32'd10;
        // reg_file[11] <= 32'd11;
        // reg_file[12] <= 32'd12;
        // reg_file[13] <= 32'd13;
        // reg_file[14] <= 32'd14;
        // reg_file[15] <= 32'd15;
        // reg_file[16] <= 32'd16;
        // reg_file[17] <= 32'd17;
        // reg_file[18] <= 32'd18;
        // reg_file[19] <= 32'd19;
        // reg_file[20] <= 32'd20;
        // reg_file[21] <= 32'd21;
        // reg_file[22] <= 32'd22;
        // reg_file[23] <= 32'd23;
        // reg_file[24] <= 32'd24;
        // reg_file[25] <= 32'd25;
        // reg_file[26] <= 32'd26;
        // reg_file[27] <= 32'd27;
        // reg_file[28] <= 32'd28;
        // reg_file[29] <= 32'd29;
        // reg_file[30] <= 32'd30;
        // reg_file[31] <= 32'd31;
    end else if (reg_write && write_reg != 5'd0) begin
        // Write data to the register file, but skip x0
        reg_file[write_reg] <= write_data;
        reg_file[0] <= 32'b0; // Ensure x0 remains zero
    end
    else begin
        reg_file[0] <= 32'b0; // Ensure x0 remains zero
    end
end

assign read_data1 = reg_file[read_reg1];
assign read_data2 = reg_file[read_reg2];

endmodule
