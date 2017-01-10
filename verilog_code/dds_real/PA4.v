module PA4(clk,reset,init,fcw,carry_in,phase,carry_out);
input clk,reset;
input [3:0] fcw;
input [3:0] init;
input carry_in;
output [3:0] phase;
output carry_out;
wire [3:0] next_phase;

D_trigger4_init D1(clk,reset,init,next_phase,phase);
adder4 a1(fcw,phase,carry_in,next_phase,carry_out);

endmodule
