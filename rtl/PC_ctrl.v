module PC_ctrl (
    input  wire [31:0] next_pc,
    input  wire        pc_write,
    input  wire        clk,
    input  wire        rst,
    output wire [31:0] pc_out,
    output wire [31:0] pc_plus4
);
    reg [31:0] pc_current;

    always @(posedge clk) begin
        if (rst)
            pc_current <= 32'd0;
        else if (pc_write)
            pc_current <= next_pc;
        else
            pc_current <= pc_current;
    end

    assign pc_out = pc_current;
    assign pc_plus4 = pc_current + 32'd4; // current use +4 for testing

endmodule