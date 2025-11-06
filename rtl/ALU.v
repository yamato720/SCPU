module ALU
(   
    input  wire        rst,
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0]  alu_control,
    output reg  [31:0] alu_result,
    output reg         zero,
    output reg         cout,
    output reg         overflow
);




reg [32:0] result_temp;

always @(*) begin
    if(rst) begin
        result_temp = 33'd0;
        alu_result = 32'd0;
        zero = 1'b1;
        cout = 1'b0;
        overflow = 1'b0;
    end
    else begin
        case (alu_control)
            4'b0000: begin   // ADD
                result_temp = a + b;
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = ((a[31] == b[31]) && (result_temp[31] != a[31]));
                alu_result = result_temp[31:0];
            end
            4'b0001: begin   // SUB
                result_temp = a + {1'b0, ~b} + 33'b1;
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result = result_temp[31:0];
            end
            4'b0010: begin // Not A
                result_temp = {1'b0, ~a};
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = 1'b0;
                alu_result = result_temp[31:0];
            end
            4'b0011: begin // A AND B
                result_temp = {1'b0, a & b};
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = 1'b0;
                alu_result = result_temp[31:0];
            end
            4'b0100: begin // A OR B
                result_temp = {1'b0, a | b};
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = 1'b0;
                alu_result = result_temp[31:0];
            end
            4'b0101: begin // A XOR B
                result_temp = {1'b0, a ^ b};
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = 1'b0;
                alu_result = result_temp[31:0];
            end
            4'b0110: begin // SLT
                result_temp = a + ({1'b0, ~b} + 33'b1);
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result = ((((a[31] != b[31]) && (result_temp[31] != a[31])) ? ~result_temp[31] : result_temp[31]) && (result_temp[31] != 1'b0)) ? 32'd1 : 32'd0;
            end
            4'b0111: begin // EQU
                result_temp = a + ({1'b0, ~b} + 33'b1);
                zero = (result_temp == 33'd0);
                cout = result_temp[32];
                overflow = 1'b0;
                alu_result = {result_temp == 33'd0 ? 32'd1 : 32'd0};
            end
            default: begin
                result_temp = 33'd0;
                alu_result = 32'd0;
                zero = 1'b1;
                cout = 1'b0;
                overflow = 1'b0;
            end
        endcase
    end
end





endmodule


