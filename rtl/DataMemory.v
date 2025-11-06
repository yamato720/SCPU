module DataMemory (
    input  wire        clk,
    input  wire        rst,
    input  wire        mem_write,
    input  wire        mem_read,
    input  wire [31:0] addr,
    input  wire [4:0] write_data,
    output wire [31:0] read_data
);

    reg [31:0] mem [0:4]; // 512 Bytes

    always @(posedge clk) begin
        if (rst) begin
            // Reset memory
            mem[0] <= 32'b0;
            mem[1] <= 32'b0;
            mem[2] <= 32'b0;
            mem[3] <= 32'b0;
            mem[4] <= 32'b0;
        end 
        
    end


    assign read_data = (mem_read) ? mem[addr[11:2]] : 32'bz;

endmodule