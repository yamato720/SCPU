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

always @(posedge clk) begin
    if (rst) begin
        // Reset all registers
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            reg_file[i] <= 32'b0;
        end
    end else if (reg_write) begin
        // Write data to the register file
        reg_file[write_reg] <= write_data;
    end
end

assign read_data1 = reg_file[read_reg1];
assign read_data2 = reg_file[read_reg2];

endmodule
