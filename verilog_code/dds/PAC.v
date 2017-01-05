module PAC(sys_clk,reset,index,sign,sin_amp);
  input sys_clk,reset,sign;
  input [13:0] index;
  output [15:0] sin_amp;
  reg [15:0] temp;
  assign sin_amp = (~sign)?temp:(~temp + 16'h0001);
  reg [15:0] LUT [0:16383];
  always@(negedge reset) begin
    $readmemh("./LUT_16_16.txt",LUT);
  end
  always@(negedge sys_clk) begin
    temp <= LUT[index];
  end
 
endmodule
