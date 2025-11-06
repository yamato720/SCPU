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
    reg_file[0] = 32'b0;
    reg_file[1] = 32'b0;
    reg_file[2] = 32'b0;
    reg_file[3] = 32'b0;
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
        reg_file[0] <= 32'b0;
        reg_file[1] <= 32'b0;
        reg_file[2] <= 32'b0;
        reg_file[3] <= 32'b0;
        reg_file[4] <= 32'b0;
        reg_file[5] <= 32'b0;
        reg_file[6] <= 32'b0;
        reg_file[7] <= 32'b0;
        reg_file[8] <= 32'b0;
        reg_file[9] <= 32'b0;
        reg_file[10] <= 32'b0;
        reg_file[11] <= 32'b0;
        reg_file[12] <= 32'b0;
        reg_file[13] <= 32'b0;
        reg_file[14] <= 32'b0;
        reg_file[15] <= 32'b0;
        reg_file[16] <= 32'b0;
        reg_file[17] <= 32'b0;
        reg_file[18] <= 32'b0;
        reg_file[19] <= 32'b0;
        reg_file[20] <= 32'b0;
        reg_file[21] <= 32'b0;
        reg_file[22] <= 32'b0;
        reg_file[23] <= 32'b0;
        reg_file[24] <= 32'b0;
        reg_file[25] <= 32'b0;
        reg_file[26] <= 32'b0;
        reg_file[27] <= 32'b0;
        reg_file[28] <= 32'b0;
        reg_file[29] <= 32'b0;
        reg_file[30] <= 32'b0;
        reg_file[31] <= 32'b0;
    end else if (reg_write && write_reg != 5'd0) begin
        // Write data to the register file, but skip x0
        reg_file[write_reg] <= write_data;
        reg_file[0] <= 32'b0; // Ensure x0 remains zero
    end
    else begin
        reg_file[0] <= 32'b0; // Ensure x0 remains zero
        reg_file[1] <= reg_file[1];
        reg_file[2] <= reg_file[2];
        reg_file[3] <= reg_file[3];
        reg_file[4] <= reg_file[4];
        reg_file[5] <= reg_file[5];
        reg_file[6] <= reg_file[6];
        reg_file[7] <= reg_file[7];
        reg_file[8] <= reg_file[8];
        reg_file[9] <= reg_file[9];
        reg_file[10] <= reg_file[10];
        reg_file[11] <= reg_file[11];
        reg_file[12] <= reg_file[12];
        reg_file[13] <= reg_file[13];
        reg_file[14] <= reg_file[14];
        reg_file[15] <= reg_file[15];
        reg_file[16] <= reg_file[16];
        reg_file[17] <= reg_file[17];
        reg_file[18] <= reg_file[18];
        reg_file[19] <= reg_file[19];
        reg_file[20] <= reg_file[20];
        reg_file[21] <= reg_file[21];
        reg_file[22] <= reg_file[22];
        reg_file[23] <= reg_file[23];
        reg_file[24] <= reg_file[24];
        reg_file[25] <= reg_file[25];
        reg_file[26] <= reg_file[26];
        reg_file[27] <= reg_file[27];
        reg_file[28] <= reg_file[28];
        reg_file[29] <= reg_file[29];
        reg_file[30] <= reg_file[30];
        reg_file[31] <= reg_file[31];
    end
end

assign read_data1 = reg_file[read_reg1];
assign read_data2 = reg_file[read_reg2];

endmodule
