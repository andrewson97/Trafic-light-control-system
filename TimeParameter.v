`timescale 1us / 1ns

 module TimeParameter(
    input [1:0] Selector,
    input [3:0] Time_value,
    input Reprog_Sync,
	input [1:0] interval,
	input clk,
    output reg [3:0] value
    );
	 
	 reg[3:0] tb = 4'b0110, // interval value = 00
				 te = 4'b0011, // interval value = 01
				 ty = 4'b0010; // interval value = 10
	     
						 
	always@(posedge clk) begin
	
	case (interval)
		// which interval to time
		2'b00: value = tb;
		2'b01: value = te;
		2'b10: value = ty;
		2'b11: value = 2*tb;
	
	endcase

	if (Reprog_Sync) begin
		case (Selector) 
			2'b00: begin
						tb = 4'b0110; // interval value = 00
						te = 4'b0011; // interval value = 01
						ty = 4'b0010; // interval value = 10
					 end
			2'b01: tb = Time_value;
			2'b10: te = Time_value;
			2'b11: ty = Time_value;
		endcase
	end
		
	end

	

endmodule
