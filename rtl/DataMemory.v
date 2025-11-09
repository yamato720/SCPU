/*
4周期一次读写，一个周期地址稳定，一个周期数据稳定，读写各占2个周期
*/

module DataMemory (
    input  wire        clk,
    input  wire        rst,
    input  wire        mem_write,
    input  wire        mem_read,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    input  wire [7:0]  recv_data_a,
    input  wire [7:0]  recv_data_b,
    output reg  [31:0] read_data,
    output wire        en,
    output wire        we,
    output reg  [31:0] addr_a,
    output reg  [7:0]  data_a,
    output reg  [31:0] addr_b,
    output reg  [7:0]  data_b
);

    assign en = mem_read | mem_write;
    assign we = mem_write;

    reg [1:0] state;

    always @(posedge clk) begin
        if (rst) begin
            addr_a <= 32'b0;
            data_a <= 8'b0;
            addr_b <= 32'b0;
            data_b <= 8'b0;
            read_data <= 32'b0;
            state <= 2'b00;
        end if(mem_read | mem_write) begin
            case (state)
            2'b00: begin
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= write_data[15:8];
                state <= state + 1;
            end
            2'b01: begin
                read_data[15:0] <= {recv_data_b, recv_data_a}; 
                state <= state + 1;
            end
            2'b10: begin
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
                data_a <= write_data[23:16];
                data_b <= write_data[31:24];
                state <= state + 1;
            end
            2'b11: begin
                read_data[31:16] <= {recv_data_b, recv_data_a}; 
                state <= 2'b00;
            end
            endcase
        end
        else begin
            addr_a <= addr_a;
            data_a <= data_a;
            addr_b <= addr_b;
            data_b <= data_b;
            read_data <= read_data;
            state <= 2'b00;
        end
    end

endmodule