`timescale 1ps/1ps

module tb_top();

    reg clk;
    reg rst;
    reg pc_write;

    top uut (
        .clk(clk),
        .rst(rst),
        .pc_write(pc_write)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        pc_write = 0;

        #15;
        rst = 0;

        #15;
        #400;
        repeat (20) begin  // 20 cycles 1 instruction
            pc_write = 1;
            #20;
            pc_write = 0;
            #400;
        end
        $finish;
    end

    always #10 clk = ~clk;

top top_inst(
    .clk(clk),
    .rst(rst),
    .pc_write(pc_write)
);

endmodule