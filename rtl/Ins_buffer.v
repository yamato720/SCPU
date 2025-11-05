module Ins_buffer(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pc_in,
    input  wire [31:0] base_in,
    output reg  [31:0] ins_out
);

reg [31:0] ins [0:127];

// reg        valid;
reg [31:0] pc_base;
reg [7:0]  index;

always @(*) begin
    index = pc_in - pc_base;
end

initial begin
    ins[0] = 32'h00000000; // NOP
    ins[1] = 32'h11111111; // NOP
    ins[2] = 32'h22222222; // NOP
    ins[3] = 32'h33333333; // NOP
    ins[4] = 32'h44444444; // NOP
    ins[5] = 32'h55555555; // NOP
    ins[6] = 32'h66666666; // NOP
    ins[7] = 32'h00000013; // NOP
    ins[8] = 32'h00000013; // NOP
    ins[9] = 32'h00000013; // NOP
    ins[10] = 32'h00000013; // NOP
    ins[11] = 32'h00000013; // NOP
    
end



always @(posedge clk) begin
    if (rst) begin
        ins_out <= 32'b0;
        // valid <= 1'b1;
        pc_base <= 32'b0;
    end else begin
        if (index <= 8'd11) begin
            ins_out <= ins[index];
            // valid <= 1'b1;
        end else begin
            ins_out <= 32'h00000013; // NOP
            // valid <= 1'b0;
        end
    end
end

endmodule

