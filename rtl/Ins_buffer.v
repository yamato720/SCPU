/*
指令缓存 (Instruction Buffer)

设计特点：
- 读取与执行并行：后台持续加载指令，不阻塞流水线
- 首指令快速可用：读取第一条指令后立即置valid
- 支持顺序执行和跳转

缓存大小配置建议：
- 16-32条：  小型嵌入式程序、简单测试（推荐用于当前测试）
- 64-128条： 中型程序、有循环的裸机程序
- 256-512条：大型程序、Linux用户态程序
- 1K-2K条：  Linux内核代码（需要配合TLB和页表）

注意：
1. Linux系统建议配合多级缓存：
   - L1 I-Cache: 16-32KB (本模块可作为L1或预取缓冲)
   - 后端接入更大的存储层次
2. 当前设计在跳转时会触发缓存重填，大小对分支密集代码影响有限
3. 对于循环代码，缓存大小应 >= 循环体大小以获得最佳性能

*/

`ifndef INS_BUFFER_SIZE
`define INS_BUFFER_SIZE 128  // 默认128条，可在编译时通过 -D 参数修改
`endif

`ifndef INS_BUFFER_ADDR_WIDTH
`define INS_BUFFER_ADDR_WIDTH 7  // log2(128) = 7
`endif

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

reg [31:0] ins [0:`INS_BUFFER_SIZE-1];

reg        finished;
reg [31:0] pc_base;
reg [`INS_BUFFER_ADDR_WIDTH:0]  index;        // 需要多1位以检测溢出
reg [`INS_BUFFER_ADDR_WIDTH:0]  access_cnt;   // 当前已读取的指令数
reg low_high_toggle;

always @(posedge clk) begin
    index = (pc_in - pc_base) >> 2;
end

integer init_i;
initial begin
    for (init_i = 0; init_i < `INS_BUFFER_SIZE; init_i = init_i + 1) begin
        ins[init_i] = 32'h00000013; // NOP (ADDI x0, x0, 0)
    end
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
        access_cnt <= 0;
        wait_cycle <= 2'b00;
    end else if(access_cnt == `INS_BUFFER_SIZE) begin  // 读满指令后停止
        finished <= 1'b1;
        addr_low <= pc_base;
        addr_high <= pc_base + 32'b1;
        wait_cycle <= 2'b00;
        access_cnt <= 0;
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
        if(wait_cycle == 2'b11 && access_cnt == 0) begin
            valid <= 1'b1;  // 第一条指令读取完成后立即置valid
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

