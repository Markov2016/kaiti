module PAC_real(sys_clk,reset,cen,wen,sign,index,data_wr,sin_amp);
input sys_clk,reset,cen,wen,sign;
input [13:0] index;
input [15:0] data_wr;
output [15:0] sin_amp;

wire [15:0] sin_wave,temp;
assign temp = (writed == 1)?sin_wave:16'b0;
assign sin_amp = (~sign)?temp:(~temp + 16'h0001);

sram_sp_hdc_svt_rvt_hvt s1(.Q(sin_wave), .CLK(sys_clk), .CEN(cen), .WEN(wen), .A(index), .D(data_wr), .EMA(0), .RETN(1));

endmodule