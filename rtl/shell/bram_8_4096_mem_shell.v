module bram_8_4096_mem_shell(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[11:0],dina[7:0],douta[7:0],clkb,enb,web[0:0],addrb[11:0],dinb[7:0],doutb[7:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [11:0]addra;
  input [7:0]dina;
  output reg [7:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [11:0]addrb;
  input [7:0]dinb;
  output reg [7:0]doutb;

  reg [7:0] ram [0:4095];


  // initial begin
  //   for (integer i = 0; i < 4096; i = i + 1) begin
  //     ram[i] = 8'b0;
  //   end
  // end

  always @(posedge clka) begin
    if (ena) begin
      if (wea) begin
        ram[addra] <= dina;
      end
      douta <= ram[addra];
    end
  end

  always @(posedge clkb) begin
    if (enb) begin
      if (web) begin
        ram[addrb] <= dinb;
      end
      doutb <= ram[addrb];
    end
  end

endmodule