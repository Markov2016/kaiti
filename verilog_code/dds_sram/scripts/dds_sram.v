module dds_sram(sys_clk,reset,fcw,offset,writed_,sin_amp);
  input sys_clk,reset;
  input [31:0] fcw,offset;
  output [15:0] sin_amp;
  output writed_;
  
  wire writed;
  wire [13:0] index;
  wire [15:0] phase;
  wire reset_,cen;
  assign cen = 0;
  assign reset_ = reset && writed;
  assign writed_ = reset_;

  PA32 pa(sys_clk,reset_,offset,fcw,phase);
  phase_compression_16 pc(phase,index);
  PAC pac(sys_clk,reset,cen,phase[15],index,writed,sin_amp);
endmodule
