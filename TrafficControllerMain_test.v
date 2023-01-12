`timescale 1us / 1ns

module TrafficControllerMain_test;

	reg Reset = 0 ;
	reg Sensor = 0;
	reg Walk_Request = 0;
	reg Reprogram = 0 ;
	reg [1:0] Time_Parameter_Selector = 0;
	reg [3:0] Time_Value = 0;
	reg clk = 0;

	wire [6:0] LEDs;
    wire oneHz_clk;
	TrafficControllerMain uut (
		.Reset(Reset), 
		.Sensor(Sensor), 
		.Walk_Request(Walk_Request), 
		.Reprogram(Reprogram), 
		.Time_Parameter_Selector(Time_Parameter_Selector), 
		.Time_Value(Time_Value), 
		.clk(clk),
		.oneHz_clk(oneHz_clk),
		.LEDs(LEDs)
	);

	initial 
	begin
		Reset = 1;
		Sensor = 0;
		Walk_Request = 0;
		Reprogram = 0;
		Time_Parameter_Selector = 0;
		Time_Value = 0;
		clk = 0;
		#11
		Reset = 0;
		#19999990 Sensor = 1;
		#30 Sensor = 0; 
		#9999990 Walk_Request = 1;
		#30 Walk_Request = 0;
//		#100 
//		Reset = 1;
//		#100
//		Reset = 0;
//		#100
//		Walk_Request = 1;
//		#100
//		Walk_Request = 0;
//		Sensor = 1;
	end
	
	initial begin
	forever begin
	 #5 clk = ~clk;
	end 
	end
	
      
endmodule

