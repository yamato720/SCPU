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
    input  wire [2:0]  mem_width,
    input  wire        tick_exmem,
    output reg  [31:0] read_data,
    output wire        en,
    output wire        we,
    output reg  [31:0] addr_a,
    output reg  [7:0]  data_a,
    output reg  [31:0] addr_b,
    output reg  [7:0]  data_b
);

    /* mem_width decoding (funct3)
    000: byte (LB, SB)
    001: halfword (LH, SH)
    010: word (LW, SW)
    011: doubleword (LD, SD)
    100: byte unsigned (LBU)
    101: halfword unsigned (LHU)
    110: word unsigned (LWU)
    */

    assign en = (mem_read | mem_write) & tick_exmem;
    assign we = mem_write & tick_exmem;

    reg [1:0] state;
    reg       wait_state;

    always @(posedge clk) begin
        if (rst) begin
            addr_a <= 32'b0;
            data_a <= 8'b0;
            addr_b <= 32'b0;
            data_b <= 8'b0;
            read_data <= 32'b0;
            state <= 2'b00;
            wait_state <= 1'b1;
        end if((mem_read | mem_write) && tick_exmem) begin
            case ({state, mem_width})
            5'b00000: begin  // signed byte
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= {8{write_data[7]}};
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end

            end
            5'b01000: begin
                read_data[15:0] <= {{8{recv_data_a[7]}}, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10000: begin
                data_a <= {8{write_data[7]}};
                data_b <= {8{write_data[7]}};
                state <= state + 1;
            end
            5'b11000: begin
                read_data[31:16] <= {16{read_data[7]}}; 
                state <= 2'b00;
            end
            5'b00100: begin  // unsigned byte
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= 8'd0;
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end
            end
            5'b01100: begin
                read_data[15:0] <= {{8'd0}, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10100: begin
                data_a <= 8'd0;
                data_b <= 8'd0;
                state <= state + 1;
            end
            5'b11100: begin
                read_data[31:16] <= 16'd0; 
                state <= 2'b00;
            end
            5'b00001: begin  // signed halfword
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= write_data[15:8];
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end
            end
            5'b01001: begin
                read_data[15:0] <= {recv_data_b, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10001: begin
                data_a <= {8{write_data[15]}};
                data_b <= {8{write_data[15]}};
                state <= state + 1;
            end
            5'b11001: begin
                read_data[31:16] <= {16{recv_data_b[7]}}; 
                state <= 2'b00;
            end
            5'b00101: begin  // unsigned halfword
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= write_data[15:8];
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end
            end
            5'b01101: begin
                read_data[15:0] <= {recv_data_b, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10101: begin
                data_a <= 8'd0;
                data_b <= 8'd0;
                state <= state + 1;
            end
            5'b11101: begin
                read_data[31:16] <= 16'd0; 
                state <= 2'b00;
            end
            5'b00010: begin  // signed word
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= write_data[15:8];
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end
            end
            5'b01010: begin
                read_data[15:0] <= {recv_data_b, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10010: begin
                data_a <= write_data[23:16];
                data_b <= write_data[31:24];
                state <= state + 1;
            end
            5'b11010: begin
                read_data[31:16] <= {recv_data_b, recv_data_a}; 
                state <= 2'b00;
            end
            5'b00110: begin  // unsigned word
                addr_a <= addr;
                addr_b <= addr + 32'd1;
                data_a <= write_data[7:0];
                data_b <= write_data[15:8];
                if(wait_state == 1'b1) begin
                    wait_state <= 1'b0;
                end else begin
                    state <= state + 1;
                end
            end
            5'b01110: begin
                read_data[15:0] <= {recv_data_b, recv_data_a}; 
                state <= state + 1;
                addr_a <= addr + 32'd2;
                addr_b <= addr + 32'd3;
            end
            5'b10110: begin
                data_a <= write_data[23:16];
                data_b <= write_data[31:24];
                state <= state + 1;
            end
            5'b11110: begin
                read_data[31:16] <= {recv_data_b, recv_data_a}; 
                state <= 2'b00;
            end
            default:begin 
                addr_a <= addr_a;
                data_a <= data_a;
                addr_b <= addr_b;
                data_b <= data_b;
                read_data <= read_data;
                state <= 2'b00;
                wait_state <= 1'b1;
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
            wait_state <= 1'b1;
        end
    end

endmodule