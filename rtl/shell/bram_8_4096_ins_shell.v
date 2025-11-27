module bram_8_4096_ins_shell(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
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


  // initial begin  // R-type Test
  //   douta = 8'b0;
  //   doutb = 8'b0;
  //   {ram[3], ram[2], ram[1], ram[0]} =     32'h00F00093; 
  //   {ram[7], ram[6], ram[5], ram[4]} =     32'h00A00113;  
  //   {ram[11], ram[10], ram[9], ram[8]} =   32'h00500193; 
  //   {ram[15], ram[14], ram[13], ram[12]} = 32'h00200213;
  //   {ram[19], ram[18], ram[17], ram[16]} = 32'hFF800293;
  //   {ram[23], ram[22], ram[21], ram[20]} = 32'h00208333;
  //   {ram[27], ram[26], ram[25], ram[24]} = 32'h403083B3;
  //   {ram[31], ram[30], ram[29], ram[28]} = 32'h0020F433;
  //   {ram[35], ram[34], ram[33], ram[32]} = 32'h0030E4B3;
  //   {ram[39], ram[38], ram[37], ram[36]} = 32'h0030C533;
  //   {ram[43], ram[42], ram[41], ram[40]} = 32'h0011A5B3;
  //   {ram[47], ram[46], ram[45], ram[44]} = 32'h0030A633;
  //   {ram[51], ram[50], ram[49], ram[48]} = 32'h004096B3;
  //   {ram[55], ram[54], ram[53], ram[52]} = 32'h0021B733;
  //   {ram[59], ram[58], ram[57], ram[56]} = 32'h0032B7B3;
  //   {ram[63], ram[62], ram[61], ram[60]} = 32'h0040D833;
  //   {ram[67], ram[66], ram[65], ram[64]} = 32'h4042D8B3;
  //   {ram[71], ram[70], ram[69], ram[68]} = 32'h00730933;
  //   {ram[75], ram[74], ram[73], ram[72]} = 32'h00000013;
    

  //   // The rest are zeros (NOP instructions)
  //   for (integer i = 76; i < 4096; i = i + 4) begin
  //       {ram[i+3],ram[i+2],ram[i+1],ram[i]} = 32'h00000013; // NOP
  //   end
  // end

  // initial begin  // LD, SD Test
  //   douta = 8'b0;
  //   doutb = 8'b0;
  //   {ram[3], ram[2], ram[1], ram[0]} =         32'h0C800093; 
  //   {ram[7], ram[6], ram[5], ram[4]} =         32'h07F00113; 
  //   {ram[11], ram[10], ram[9], ram[8]} =       32'hF8000193; 
  //   {ram[15], ram[14], ram[13], ram[12]} =     32'h0FF00213; 
  //   {ram[19], ram[18], ram[17], ram[16]} =     32'h00007297; 
  //   {ram[23], ram[22], ram[21], ram[20]} =     32'hC6728293; 
  //   {ram[27], ram[26], ram[25], ram[24]} =     32'hFFFF8337; 
  //   {ram[31], ram[30], ram[29], ram[28]} =     32'h00010397; 
  //   {ram[35], ram[34], ram[33], ram[32]} =     32'hFE338393; 
  //   {ram[39], ram[38], ram[37], ram[36]} =     32'h40000413; 
  //   {ram[43], ram[42], ram[41], ram[40]} =     32'hFFF00493; 
  //   {ram[47], ram[46], ram[45], ram[44]} =     32'h00208023; 
  //   {ram[51], ram[50], ram[49], ram[48]} =     32'h003080A3; 
  //   {ram[55], ram[54], ram[53], ram[52]} =     32'h00408123; 
  //   {ram[59], ram[58], ram[57], ram[56]} =     32'h00509223; 
  //   {ram[63], ram[62], ram[61], ram[60]} =     32'h00609323; 
  //   {ram[67], ram[66], ram[65], ram[64]} =     32'h00709523; 
  //   {ram[71], ram[70], ram[69], ram[68]} =     32'h0080A623; 
  //   {ram[75], ram[74], ram[73], ram[72]} =     32'h0090A823; 
  //   {ram[79], ram[78], ram[77], ram[76]} =     32'h00008503; 
  //   {ram[83], ram[82], ram[81], ram[80]} =     32'h00108583; 
  //   {ram[87], ram[86], ram[85], ram[84]} =     32'h0020C603; 
  //   {ram[91], ram[90], ram[89], ram[88]} =     32'h00409683; 
  //   {ram[95], ram[94], ram[93], ram[92]} =     32'h00609703; 
  //   {ram[99], ram[98], ram[97], ram[96]} =     32'h00A0D783; 
  //   {ram[103], ram[102], ram[101], ram[100]} = 32'h00C0A803; 
  //   {ram[107], ram[106], ram[105], ram[104]} = 32'h0100A883; 
  //   {ram[111], ram[110], ram[109], ram[108]} = 32'h00000013; 
  //   {ram[115], ram[114], ram[113], ram[112]} = 32'h00000013; 
    
  //   for (integer i = 116; i < 4096; i = i + 4) begin
  //     {ram[i+3],ram[i+2],ram[i+1],ram[i]} = 32'h00000013; // NOP
  //   end
  // end

  initial begin  // branch Test
    douta = 8'b0;
    doutb = 8'b0;
    {ram[3], ram[2], ram[1], ram[0]} =          32'h00A00093;
    {ram[7], ram[6], ram[5], ram[4]} =          32'h01400113;
    {ram[11], ram[10], ram[9], ram[8]} =        32'h00A00193;
    {ram[15], ram[14], ram[13], ram[12]} =      32'hFFB00213;
    {ram[19], ram[18], ram[17], ram[16]} =      32'h00F00293;
    {ram[23], ram[22], ram[21], ram[20]} =      32'h00308463;
    {ram[27], ram[26], ram[25], ram[24]} =      32'h00100313;
    {ram[31], ram[30], ram[29], ram[28]} =      32'h00209463;
    {ram[35], ram[34], ram[33], ram[32]} =      32'h00100393;
    {ram[39], ram[38], ram[37], ram[36]} =      32'h00124463;
    {ram[43], ram[42], ram[41], ram[40]} =      32'h00100413;
    {ram[47], ram[46], ram[45], ram[44]} =      32'h00115463;
    {ram[51], ram[50], ram[49], ram[48]} =      32'h00100493;
    {ram[55], ram[54], ram[53], ram[52]} =      32'h0020E463;
    {ram[59], ram[58], ram[57], ram[56]} =      32'h00100513;
    {ram[63], ram[62], ram[61], ram[60]} =      32'h0012F463;
    {ram[67], ram[66], ram[65], ram[64]} =      32'h00100593;
    {ram[71], ram[70], ram[69], ram[68]} =      32'h0140056F;
    {ram[75], ram[74], ram[73], ram[72]} =      32'h00000013;
    {ram[79], ram[78], ram[77], ram[76]} =      32'h00000013;
    {ram[83], ram[82], ram[81], ram[80]} =      32'h00000013;
    {ram[87], ram[86], ram[85], ram[84]} =      32'h00000013;
    {ram[91], ram[90], ram[89], ram[88]} =      32'h01E00613;
    {ram[95], ram[94], ram[93], ram[92]} =      32'h008505E7;
    {ram[99], ram[98], ram[97], ram[96]} =      32'h02800693;
    {ram[103], ram[102], ram[101], ram[100]} =  32'h00000013;
    
    for (integer i = 104; i < 4096; i = i + 4) begin
      {ram[i+3],ram[i+2],ram[i+1],ram[i]} = 32'h00000013; // NOP
    end
  end

  

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