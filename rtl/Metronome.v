module Metronome
(
    input  wire clk,
    input  wire rst,
    input  wire stuck,
    output reg  tick_pc,
    output reg  tick_ifid,
    output reg  tick_idex,
    output reg  tick_exmem,
    output reg  tick_memwb
);
/*
PC: 5周期
ID: 5周期
EX: 5周期
MEM:5周期
WB: 5周期
*/  
    parameter cycle_max = 25;

    reg [4:0] cycle_count;
    reg       pc_flag;
    reg       ifid_flag;
    reg       idex_flag;
    reg       exmem_flag;
    reg       memwb_flag;


    reg       pc_flag_latch;
    reg       ifid_flag_latch;
    reg       idex_flag_latch;
    reg       exmem_flag_latch;
    reg       memwb_flag_latch;


    always @(posedge clk) begin
        if (rst || stuck) begin
            cycle_count <= 5'd1;
            pc_flag    <= 1'b0;
            ifid_flag  <= 1'b0;
            idex_flag  <= 1'b0;
            exmem_flag <= 1'b0;
            memwb_flag <= 1'b0;

            pc_flag_latch    <= 1'b0;
            ifid_flag_latch  <= 1'b0;
            idex_flag_latch  <= 1'b0;
            exmem_flag_latch <= 1'b0;
            memwb_flag_latch <= 1'b0;
        end else begin
            pc_flag <= (cycle_count  == 0);
            pc_flag_latch <= pc_flag;
            ifid_flag <= (cycle_count == 4);
            ifid_flag_latch <= ifid_flag;
            idex_flag <= (cycle_count == 9);
            idex_flag_latch <= idex_flag;
            exmem_flag <= (cycle_count == 14);
            exmem_flag_latch <= exmem_flag;
            memwb_flag <= (cycle_count == 19);   
            memwb_flag_latch <= memwb_flag;
            cycle_count <= (cycle_count + 1) % cycle_max;
        end
    end
    always @(posedge clk)begin
        if(rst || stuck) begin
            tick_pc    <= 1'b0;
        end else if(pc_flag_latch==0 && pc_flag==1) begin
            tick_pc    <= 1'b1;
        end else begin
            tick_pc    <= 1'b0;
        end
    end

    always @(posedge clk)begin
        if(rst || stuck) begin
            tick_ifid    <= 1'b0;
        end else if(ifid_flag_latch==0 && ifid_flag==1) begin
            tick_ifid    <= 1'b1;
        end else begin
            tick_ifid    <= 1'b0;
        end
    end

    always @(posedge clk)begin
        if(rst || stuck) begin
            tick_idex    <= 1'b0;
        end else if(idex_flag_latch==0 && idex_flag==1) begin
            tick_idex    <= 1'b1;
        end else begin
            tick_idex    <= 1'b0;
        end
    end

    reg [3:0] mem_access;
    always @(posedge clk) begin
        if(rst || stuck) begin
            tick_exmem <= 1'b0;
            mem_access <= 4'b0000;
        end else if(exmem_flag_latch==0 && exmem_flag==1) begin
            mem_access <= 4'b0000;
            tick_exmem <= 1'b1;
        end
        else if(mem_access == 4'b0100) begin
            tick_exmem <= 1'b0;
            mem_access <= 4'b0000;
        end else begin
            tick_exmem <= tick_exmem;
            mem_access <= mem_access + 1;
        end
        
    end

    always @(posedge clk)begin
        if(rst || stuck) begin
            tick_idex    <= 1'b0;
        end else if(idex_flag_latch==0 && idex_flag==1) begin
            tick_idex    <= 1'b1;
        end else begin
            tick_idex    <= 1'b0;
        end
    end


    always @(posedge clk)begin
        if(rst || stuck) begin
            tick_memwb    <= 1'b0;
        end else if(memwb_flag_latch==0 && memwb_flag==1) begin
            tick_memwb    <= 1'b1;
        end else begin
            tick_memwb    <= 1'b0;
        end
    end
endmodule