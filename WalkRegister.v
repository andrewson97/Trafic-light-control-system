`timescale 1us / 1ns

module WalkRegister(
    input WR_Sync,
    input WR_Reset,
    output reg WR
    );
	 
	 always@(posedge WR_Sync ,posedge WR_Reset) begin
		if (WR_Sync) WR = 1;
		else if (WR_Reset) WR = 0;
	 end
	
	 


endmodule
