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
    ins[7] = 32'h00000033; // NOP
    ins[8] = 32'h00000033; // NOP
    ins[9] = 32'h00000033; // NOP
    ins[10] = 32'h00000033; // NOP
    ins[11] = 32'h00000033; // NOP
    ins[12] = 32'h00000033; // NOP
    ins[13] = 32'h00000033; // NOP
    ins[14] = 32'h00000033; // NOP
    ins[15] = 32'h00000033; // NOP
    ins[16] = 32'h00000033; // NOP
    ins[17] = 32'h00000033; // NOP
    ins[18] = 32'h00000033; // NOP
    ins[19] = 32'h00000033; // NOP
    ins[20] = 32'h00000033; // NOP
    ins[21] = 32'h00000033; // NOP
    ins[22] = 32'h00000033; // NOP
    ins[23] = 32'h00000033; // NOP
    ins[24] = 32'h00000033; // NOP
    ins[25] = 32'h00000033; // NOP
    ins[26] = 32'h00000033; // NOP
    ins[27] = 32'h00000033; // NOP
    ins[28] = 32'h00000033; // NOP
    ins[29] = 32'h00000033; // NOP
    ins[30] = 32'h00000033; // NOP
    ins[31] = 32'h00000033; // NOP
    ins[32] = 32'h00000033; // NOP
    ins[33] = 32'h00000033; // NOP
    ins[34] = 32'h00000033; // NOP
    ins[35] = 32'h00000033; // NOP
    ins[36] = 32'h00000033; // NOP
    ins[37] = 32'h00000033; // NOP
    ins[38] = 32'h00000033; // NOP
    ins[39] = 32'h00000033; // NOP
    ins[40] = 32'h00000033; // NOP
    ins[41] = 32'h00000033; // NOP
    ins[42] = 32'h00000033; // NOP
    ins[43] = 32'h00000033; // NOP
    ins[44] = 32'h00000033; // NOP
    ins[45] = 32'h00000033; // NOP
    ins[46] = 32'h00000033; // NOP
    ins[47] = 32'h00000033; // NOP
    ins[48] = 32'h00000033; // NOP
    ins[49] = 32'h00000033; // NOP
    ins[50] = 32'h00000033; // NOP
    ins[51] = 32'h00000033; // NOP
    ins[52] = 32'h00000033; // NOP
    ins[53] = 32'h00000033; // NOP
    ins[54] = 32'h00000033; // NOP
    ins[55] = 32'h00000033; // NOP
    ins[56] = 32'h00000033; // NOP
    ins[57] = 32'h00000033; // NOP
    ins[58] = 32'h00000033; // NOP
    ins[59] = 32'h00000033; // NOP
    ins[60] = 32'h00000033; // NOP
    ins[61] = 32'h00000033; // NOP
    ins[62] = 32'h00000033; // NOP
    ins[63] = 32'h00000033; // NOP
    ins[64] = 32'h00000033; // NOP
    ins[65] = 32'h00000033; // NOP
    ins[66] = 32'h00000033; // NOP
    ins[67] = 32'h00000033; // NOP
    ins[68] = 32'h00000033; // NOP
    ins[69] = 32'h00000033; // NOP
    ins[70] = 32'h00000033; // NOP
    ins[71] = 32'h00000033; // NOP
    ins[72] = 32'h00000033; // NOP
    ins[73] = 32'h00000033; // NOP
    ins[74] = 32'h00000033; // NOP
    ins[75] = 32'h00000033; // NOP
    ins[76] = 32'h00000033; // NOP
    ins[77] = 32'h00000033; // NOP
    ins[78] = 32'h00000033; // NOP
    ins[79] = 32'h00000033; // NOP
    ins[80] = 32'h00000033; // NOP
    ins[81] = 32'h00000033; // NOP
    ins[82] = 32'h00000033; // NOP
    ins[83] = 32'h00000033; // NOP
    ins[84] = 32'h00000033; // NOP
    ins[85] = 32'h00000033; // NOP
    ins[86] = 32'h00000033; // NOP
    ins[87] = 32'h00000033; // NOP
    ins[88] = 32'h00000033; // NOP
    ins[89] = 32'h00000033; // NOP
    ins[90] = 32'h00000033; // NOP
    ins[91] = 32'h00000033; // NOP
    ins[92] = 32'h00000033; // NOP
    ins[93] = 32'h00000033; // NOP
    ins[94] = 32'h00000033; // NOP
    ins[95] = 32'h00000033; // NOP
    ins[96] = 32'h00000033; // NOP
    ins[97] = 32'h00000033; // NOP
    ins[98] = 32'h00000033; // NOP
    ins[99] = 32'h00000033; // NOP
    ins[100] = 32'h00000033; // NOP
    ins[101] = 32'h00000033; // NOP
    ins[102] = 32'h00000033; // NOP
    ins[103] = 32'h00000033; // NOP
    ins[104] = 32'h00000033; // NOP
    ins[105] = 32'h00000033; // NOP
    ins[106] = 32'h00000033; // NOP
    ins[107] = 32'h00000033; // NOP
    ins[108] = 32'h00000033; // NOP
    ins[109] = 32'h00000033; // NOP
    ins[110] = 32'h00000033; // NOP
    ins[111] = 32'h00000033; // NOP
    ins[112] = 32'h00000033; // NOP
    ins[113] = 32'h00000033; // NOP
    ins[114] = 32'h00000033; // NOP
    ins[115] = 32'h00000033; // NOP
    ins[116] = 32'h00000033; // NOP
    ins[117] = 32'h00000033; // NOP
    ins[118] = 32'h00000033; // NOP
    ins[119] = 32'h00000033; // NOP
    ins[120] = 32'h00000033; // NOP
    ins[121] = 32'h00000033; // NOP
    ins[122] = 32'h00000033; // NOP
    ins[123] = 32'h00000033; // NOP
    ins[124] = 32'h00000033; // NOP
    ins[125] = 32'h00000033; // NOP
    ins[126] = 32'h00000033; // NOP
    ins[127] = 32'h00000033; // NOP
    
    
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

