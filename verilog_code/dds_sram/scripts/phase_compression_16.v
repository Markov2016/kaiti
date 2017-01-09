module phase_compression_16(phase,index);
input  [15:0] phase;
output [13:0] index;
assign index = (phase[14] == 0)?phase[13:0]:~phase[13:0];
endmodule
