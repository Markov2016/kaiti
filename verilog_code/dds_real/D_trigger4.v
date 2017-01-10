module D_trigger4(clk,reset,D,Q);
input clk,reset;
input [3:0] D;
output reg [3:0] Q;

always@(posedge clk or negedge reset) begin
  if(~reset) begin
    Q <= 4'b0;
  end
  else begin 
    Q <= D;
  end
end

endmodule