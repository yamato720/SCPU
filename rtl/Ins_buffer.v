/*

5周期一条指令比较合适，这样即使出现流水线停顿，busy结束后也能保证有指令可用

*/


module Ins_buffer(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pc_in,
    input  wire [7:0]  ins_low,
    input  wire [7:0]  ins_high,
    output reg  [31:0] ins_out,
    output reg  [31:0] addr_low,
    output reg  [31:0] addr_high,
    output reg         valid,
    output reg         busy
);

reg [31:0] ins [0:127];

reg        finished;
reg [31:0] pc_base;
reg [7:0]  index;
reg [7:0]  access_cnt;
// reg        valid;
reg low_high_toggle;

always @(posedge clk) begin
    index = (pc_in - pc_base) >> 2;
end

initial begin
    for (index = 0; index < 128; index = index + 1) begin
        ins[index] = 32'h00000013; // NOP
    end
    
    // ==================== 测试说明 ====================
    // 注意: 由于 Registers.v 初始值全为 0，这些指令执行结果都会是 0
    // 建议在 Registers.v 的 initial 块中设置:
    //   reg_file[1] = 32'd15;  // x1 = 15
    //   reg_file[2] = 32'd10;  // x2 = 10
    //   reg_file[3] = 32'd5;   // x3 = 5
    // 或者添加 I-type (ADDI) 支持来动态初始化
end

reg [31:0] ins_temp;

always @(posedge clk) begin
    if (rst) begin
        ins_out <= 32'b0;
        valid <= 1'b0;
        ins_temp <= 32'b0;
        pc_base <= 32'b0;
    end else begin
        if (index < access_cnt && valid) begin
            ins_out <= ins[index];
            ins_temp <= ins[index];
        end else begin
            ins_out <= ins_temp;
            valid <= 1'b0;
            pc_base <= pc_in;
        end
    end
end


reg finished;

always @(posedge clk) begin
    if (rst) begin
        busy <= 1'b1;
    end else if(!(index < access_cnt && valid)) begin
        busy <= 1'b1;   
    end else if(valid == 1 && valid_latch == 0) begin
        busy <= 1'b0;
    end else
    begin
        busy <= busy;
    end
end




reg  [1:0] wait_cycle;

reg valid_latch; 

always @(posedge clk) begin
    valid_latch <= valid;
end


always @(posedge clk) begin
    if (rst) begin
        finished <= 1'b0;
        low_high_toggle <= 1'b0;
        addr_low <= 32'b0;
        addr_high <= 32'b1;
        access_cnt <= 8'b0;
        wait_cycle <= 2'b00;
    end else if(access_cnt > 8'd127) begin  // 读满128条指令后停止
        finished <= 1'b1;
        addr_low <= pc_base;
        addr_high <= pc_base + 32'b1;
        wait_cycle <= 2'b00;
        access_cnt <= 8'b0;
    end else if (!finished && wait_cycle[0] == 1'b0) begin
        addr_low <= addr_low + 32'd2;
        addr_high <= addr_high + 32'd2;
        wait_cycle <= wait_cycle + 1'b1;
    end else if(!finished && wait_cycle[0] == 1'b1) begin
        if (low_high_toggle == 1'b0) begin
            ins[access_cnt][15:0]   <= {ins_high, ins_low};
        end else begin
            ins[access_cnt][31:16]  <= {ins_high, ins_low};
            access_cnt <= access_cnt + 1;
        end
        low_high_toggle <= ~low_high_toggle;
        if(wait_cycle == 2'b11 && access_cnt == 8'd0) begin
            valid <= 1'b1;
        end
        wait_cycle <= wait_cycle + 1'b1;
    end else if(!valid)begin
        finished <= 1'b0;
        low_high_toggle <= 1'b0;
        addr_low <= pc_in;
        addr_high <= pc_in + 32'b1;
        wait_cycle <= 2'b00;
    end

end


endmodule

