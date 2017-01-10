module adder4(add1,add2,carry_in,out,carry_out);
input [3:0] add1,add2;
input carry_in;
output [3:0] out;
output carry_out;
wire [3:0] carry;

assign out[0] = (add1[0] ^ add2[0]) ^ carry_in;
assign out[1] = (add1[1] ^ add2[1]) ^ carry[0];
assign out[2] = (add1[2] ^ add2[2]) ^ carry[1];
assign out[3] = (add1[3] ^ add2[3]) ^ carry[2];
assign carry[0]  = (add1[0] && add2[0]) || (add1[0] && carry_in) || (carry_in && add2[0]);
assign carry[1]  = (add1[1] && add2[1]) || (add1[1] && carry[0]) || (carry[0] && add2[1]);
assign carry[2]  = (add1[2] && add2[2]) || (add1[2] && carry[1]) || (carry[1] && add2[2]);
assign carry_out = (add1[3] && add2[3]) || (add1[3] && carry[2]) || (carry[2] && add2[3]);

endmodule
