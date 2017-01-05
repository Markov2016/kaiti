module dds(sys_clk,reset,fcw,offset,sin_amp);
  input sys_clk,reset;
  input [31:0] fcw,offset;
  output [15:0] sin_amp;
  
  wire [13:0] index;
  wire [15:0] phase;
  
  PA32 pa(sys_clk,reset,offset,fcw,phase);
  phase_compression_16 pc(phase,index);
  PAC pac(sys_clk,reset,index,phase[15],sin_amp);
endmodule
