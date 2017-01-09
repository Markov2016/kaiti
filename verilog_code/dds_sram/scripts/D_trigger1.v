module D_trigger1(clk,reset,D,Q);
input clk,reset;
input  D;
output reg  Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 1'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule
