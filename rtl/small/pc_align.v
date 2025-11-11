module pc_align (
    input  wire [31:0] pc_in,
    output wire [31:0] pc_out
);
    
    assign pc_out = {pc_in[31:1], 1'b0};

endmodule