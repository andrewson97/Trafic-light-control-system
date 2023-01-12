`timescale 1us / 1ns

module TrafficControllerMain(
    input Reset,
    input Sensor,
    input Walk_Request,
    input Reprogram,
    input [1:0] Time_Parameter_Selector,
    input [3:0] Time_Value,
    input clk,
    output [6:0] LEDs,
    output oneHz_clk
    );
	 
	 wire [1:0] interval;
	 wire [1:0] Selector;
	 wire [3:0] value;
	 wire Reset_Sync,Sensor_Sync,WR,WR_Reset,start_timer,expired,Prog_Sync,
			WR_Sync;//,oneHz_clk
	 
	Divider divider (
		.rst(Reset_Sync),
		.clk(clk), 
		.oneHz_clk(oneHz_clk)
	);
	
	FSM fsm (
		.Sensor_Sync(Sensor_Sync), 
		.WR(WR), 
		.WR_Reset(WR_Reset), 
		.LEDs(LEDs), 
		.interval(interval), 
		.start_timer(start_timer), 
		.expired(expired), 
		.Reprog_Sync(Reprog_Sync), 
		.clk(clk),
		.Reset_Sync(Reset_Sync)
	);
	
	Synchronizer synchronizer (
		.Reset(Reset), 
		.Sensor(Sensor), 
		.Walk_Request(Walk_Request), 
		.Reprogram(Reprogram), 
		.clk(clk), 
		.Reprog_Sync(Reprog_Sync), 
		.WR_Sync(WR_Sync), 
		.Sensor_Sync(Sensor_Sync), 
		.Reset_Sync(Reset_Sync)
	);


	TimeParameter timeParameter (
			.Selector(Time_Parameter_Selector), 
			.Time_value(Time_Value), 
			.Reprog_Sync(Reprog_Sync), 
			.interval(interval), 
			.clk(clk), 
			.value(value)
		);
		
	Timer timer (
		.Value(value), 
		.oneHz_clk(oneHz_clk), 
		.start_timer(start_timer),
		.clk(clk),
		.expired(expired),
		.Reset_Sync(Reset_Sync)
	);
	
	WalkRegister walkRegister (
		.WR_Sync(WR_Sync), 
		.WR_Reset(WR_Reset),  
		.WR(WR)
	);



endmodule


