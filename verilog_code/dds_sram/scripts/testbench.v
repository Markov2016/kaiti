`timescale 1ns/ 1ns
module testbench();
  reg sys_clk,reset;
  reg [31:0] fcw,offset;
  wire writed_;
  wire [15:0] sin_amp;
  reg [15:0] i;
  dds_sram d1(sys_clk,reset,fcw,offset,writed_,sin_amp);
  initial begin
    sys_clk = 1;reset = 1;
    fcw = 32'h01111111;
    offset = 32'b0;
    i <= 16'b0;
    #20 reset = 0;
    #20 reset = 1;
  end
  
  always begin
    #5 sys_clk = ~sys_clk;
  end

  always@(posedge writed_) begin
    if( i == 16'b0) begin
      i = 16'b1;
    end
  end
  
  integer w_file;
  initial begin  w_file = $fopen("data_out.txt");end
  always@(negedge sys_clk) begin
	if (i > 0) begin
		$fdisplay(w_file,"%h",sin_amp);
		i <= i+1;
		if (i>4096) begin
			$stop;
		end
	end
	
  end
endmodule