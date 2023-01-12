`timescale 1us / 1ns

module Synchronizer(
    input Reset,
    input Sensor,
    input Walk_Request,
    input Reprogram,
	 input clk,
    output reg Reprog_Sync,
    output reg WR_Sync,
    output reg Sensor_Sync,
    output reg Reset_Sync
    );
	always@(posedge clk) begin
	   Reset_Sync <= Reset;
	   WR_Sync <= Walk_Request;
	   Reprog_Sync <= Reprogram;
	   Sensor_Sync <= Sensor;
	
	end

endmodule
