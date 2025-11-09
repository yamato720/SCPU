`timescale 1ps/1ps
module tb_mem();





initial begin
    clk = 0;
    rst = 1;
    mem_write = 0;
    mem_read = 0;
    addr = 0;
    write_data = 0;

    #100;
    rst = 0;

    // Write data to memory
    mem_write = 1;
    addr = 32'h00000000;
    write_data = 32'hDEADBEEF;
    #80;

    // Read data from memory
    mem_write = 0;
    mem_read = 1;
    addr = 32'h00000000;
    #80;
    mem_write = 0;
    mem_read = 0;
    #100;

    $finish;
end


always #10 clk = ~clk;

reg clk;
reg rst;
reg        mem_write;
reg        mem_read;
reg  [31:0] addr;
reg  [31:0] write_data;
wire [31:0] read_data;
wire        en;
wire        we;
wire [11:0] addr_a;
wire [7:0]  data_a;
wire [11:0] addr_b;
wire [7:0]  data_b;
wire [7:0]  recv_data_a;
wire [7:0]  recv_data_b;





DataMemory DataMemory_inst(
    .clk(clk),
    .rst(rst),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .addr(addr),
    .write_data(write_data),
    .recv_data_a(recv_data_a),
    .recv_data_b(recv_data_b),
    .read_data(read_data),
    .en(en),
    .we(we),
    .addr_a(addr_a),
    .data_a(data_a),
    .addr_b(addr_b),
    .data_b(data_b)
);

bram_8_4096_mem_shell bram_8_4096_mem_shell_inst (
    .clka(clk),
    .ena(en),
    .wea(we),
    .addra(addr_a),
    .dina(data_a),
    .douta(recv_data_a),
    .clkb(clk),
    .enb(en),
    .web(we),
    .addrb(addr_b),
    .dinb(data_b),
    .doutb(recv_data_b)
);


endmodule