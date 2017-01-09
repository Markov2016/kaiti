module PAC(sys_clk,reset,cen,sign,index,writed,sin_amp);
input sys_clk,reset,cen,sign;
input [13:0] index;
output reg writed;
output [15:0] sin_amp;

wire [15:0] sin_wave,temp;
reg wen,delay;
reg [13:0] index_;
reg [15:0] LUT [0:16383];
assign temp = (writed == 1)?sin_wave:16'b0;
assign sin_amp = (~sign)?temp:(~temp + 16'h0001);

always@(negedge reset) begin
  $readmemh("./scripts/LUT_16_16.txt",LUT);
  index_ <= 14'h0000;
  wen <= 0;
  writed <= 0;
  delay <= 0;
end
always@(negedge sys_clk) begin
  if(writed == 0) begin
    if(index_ == 14'h3fff) begin
       wen <= 1;
       writed <= 1;
       index_ <= index;
    end
    else begin
      if (delay == 0) begin
        delay <= 1;
      end
      else begin
        index_ <= index_ + 1;
      end
    end
  end
  else begin
    index_ <= index;
  end
end
sram_sp_hdc_svt_rvt_hvt s1(.Q(sin_wave), .CLK(sys_clk), .CEN(cen), .WEN(wen), .A(index_), .D(LUT[index_]), .EMA(0), .RETN(1));
endmodule
