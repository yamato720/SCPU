module ImmGenerator (
    input wire [31:0] instruction,
    output wire [63:0] imm_out_64,
    output wire [31:0] imm_out_32
);

reg [63:0] imm_out;
always @(*)
begin
    case (instruction[6:0])
        7'b0010011, // I-type
        7'b0000011,
        7'b1100111: begin
            imm_out = {{52{instruction[31]}}, instruction[31:20]};
        end
        7'b0100011: begin // S-type
            imm_out = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end
        7'b1100011: begin // B-type
            imm_out = {{51{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        end
        7'b0110111, // U-type
        7'b0010111: begin
            imm_out = {{32{instruction[31]}}, instruction[31:12], 12'b0};
        end
        7'b1101111: begin // J-type
            imm_out = {{43{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        end
        default: begin
            imm_out = 64'b0;
        end
    



    endcase
end


assign imm_out_64 = imm_out;
assign imm_out_32 = imm_out[31:0];

endmodule