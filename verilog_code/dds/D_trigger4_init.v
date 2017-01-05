module D_trigger4_init(clk,reset,init,D,Q);
input clk,reset;
input [3:0] D;
input [3:0] init;
output reg [3:0] Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= init;
  end
  else begin 
    Q <= D;
  end
end

endmodule
