module ALU
(   
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] a_in,
    input  wire [31:0] b_in,
    input  wire [4:0]  alu_control_in,
    input  wire        tick_idex,
    input  wire [31:0] pc,
    output reg  [31:0] alu_result,
    output reg         zero,
    output reg         cout,
    output reg         overflow,
    output reg  [2:0]  branch_taken
);

/*
branch_taken:
000: not taken
001: taken pc + imm 
010: taken rs1 + imm
*/


reg [32:0] result_temp;
reg [31:0] a;
reg [31:0] b;
reg [4:0]  alu_control;
reg [31:0] pc_reg;

always @(posedge clk) begin
    if(rst) begin
        result_temp = 33'd0;
        alu_result = 32'd0;
        zero = 1'b1;
        cout = 1'b0;
        overflow = 1'b0;
        a <= 32'd0;
        b <= 32'd0;
        alu_control <= 5'd0;
        pc_reg <= 32'd0;
        branch_taken <= 3'd0;
    end
    else if(tick_idex) begin
        a <= a_in;
        b <= b_in;
        alu_control <= alu_control_in;
        pc_reg <= pc;
        result_temp <= 33'd0;
        alu_result <= 32'd0;
        zero <= 1'b1;
        cout <= 1'b0;
        overflow <= 1'b0;
        branch_taken <= 3'd0;
    end
    else begin
        case (alu_control)
            5'b00000: begin   // ADD
                result_temp <= a + b;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] == b[31]) && (result_temp[31] != a[31]));
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00001: begin   // SUB
                result_temp <= a + {1'b0, ~b} + 33'b1;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00010: begin // Not A
                result_temp <= {1'b0, ~a};
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00011: begin // A AND B
                result_temp <= {1'b0, a & b};
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00100: begin // A OR B
                result_temp <= {1'b0, a | b};
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00101: begin // A XOR B
                result_temp <= {1'b0, a ^ b};
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b00110: begin // BLT
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result <= ((((a[31] != b[31]) && (result_temp[31] != a[31])) ? ~result_temp[31] : result_temp[31]) && (result_temp[31] != 1'b0)) ? 32'd1 : 32'd0;
                branch_taken <= (alu_result == 32'd1) ? 3'd1 : 3'd0;
            end
            5'b00111: begin // BEQ
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= {result_temp[31:0] == 32'd0 ? 32'd1 : 32'd0};
                branch_taken <= (alu_result == 32'd1) ? 3'd1 : 3'd0;
            end
            5'b01000: begin // SLL
                result_temp <= a << b[4:0];
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b01001: begin // BLTU
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result <= result_temp[31] && a[31] == 0 ? 32'd1 : 32'd0;
                branch_taken <= (alu_result == 32'd1) ? 3'd1 : 3'd0;
            end
            5'b01010: begin // SRL
                result_temp <= a >> b[4:0];
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b01011: begin // SRA
                result_temp <= ($signed(a)) >>> b[4:0];
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b01100: begin // LUI
                result_temp <= b ;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b01101: begin // AUIPC
                result_temp <= pc_reg + b;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd0;
            end
            5'b01110: begin // BNE
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= {result_temp[31:0] == 32'd0 ? 32'd1 : 32'd0};
                branch_taken <= (alu_result == 32'd1) ? 3'd0 : 3'd1;
            end
            5'b01111: begin // BGE
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result <= ((((a[31] != b[31]) && (result_temp[31] != a[31])) ? ~result_temp[31] : result_temp[31]) && (result_temp[31] != 1'b0)) ? 32'd1 : 32'd0;
                branch_taken <= (alu_result == 32'd1) ? 3'd0 : 3'd1;
            end
            5'b10000: begin // BGEU
                result_temp <= a + ({1'b0, ~b} + 33'b1);
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= ((a[31] != b[31]) && (result_temp[31] != a[31]));
                alu_result <= result_temp[31] && a[31] == 0 ? 32'd1 : 32'd0;
                branch_taken <= (alu_result == 32'd1) ? 3'd0 : 3'd1;
            end
            5'b10001: begin // JALR
                result_temp <= pc_reg + 32'd4;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd3;
            end
            5'b10010: begin // JAL
                result_temp <= pc_reg + 32'd4;
                zero <= (result_temp == 33'd0);
                cout <= result_temp[32];
                overflow <= 1'b0;
                alu_result <= result_temp[31:0];
                branch_taken <= 3'd2;
            end
            default: begin
                result_temp <= 33'd0;
                alu_result <= 32'd0;
                zero <= 1'b1;
                cout <= 1'b0;
                overflow <= 1'b0;
                branch_taken <= 3'd0;
            end
        endcase
    end
end





endmodule


