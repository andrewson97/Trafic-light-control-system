`timescale 1us / 1ns


module Divider_test;

	reg clk;
	reg rst;
	

	wire oneHz_clk;

	Divider uut (
		.rst(rst),
		.clk(clk), 
		.oneHz_clk(oneHz_clk)
	);


	initial begin 
	clk=0;
	rst=0;
	#10;
	rst=1;
	#10;
	rst=0;
	end
	
	initial begin
	forever begin
	 #1 clk = ~clk;
	end 
	end
      
endmodule

