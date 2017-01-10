module dds_real(sys_clk,reset,cen,wen,fcw,offset,index,data_wr,sin_amp);
  input sys_clk,reset,cen,wen;
  input [13:0] index;
  input [15:0] data_wr;
  input [31:0] fcw,offset;
  output [15:0] sin_amp;
  wire [15:0] phase;


  PA32 pa(sys_clk,reset,offset,fcw,phase);
  phase_compression_16 pc(phase,index);
  PAC_real pac(sys_clk,reset,cen,wen,phase[15],index,data_wr,sin_amp);
endmodule
