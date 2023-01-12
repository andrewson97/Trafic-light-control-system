`timescale 1us / 1ns
//`timescale 1ns / 1ps

module FSM(
    input Sensor_Sync,
    input WR,
    input expired,
    input Reprog_Sync,
	input Reset_Sync,
	input clk,
	output reg WR_Reset,
    output reg [6:0] LEDs,
    output reg [1:0] interval,
    output reg start_timer
    );
	 
	 localparam tb = 2'b00,//tBASE
					te = 2'b01,//tEXT
					ty = 2'b10,//tYEL
					tbx2 = 2'b11;//2*tBASE
					
	 reg main_tb;
	 reg main_2tb;
	 reg side_detected;
	 reg side_ext;
	 reg first;
	 // MAIN LIGHTS | SIDE LIGHTS | WALK LAMP
	 
	 localparam A = 7'b0011000, // 001 100 0 main green | side red | walk off
					B = 7'b0101000, // 010 100 0 main yellow | side red | walk off
					C = 7'b1000010, // 100 001 0 main red | side green | walk off
					D = 7'b1000100, // 100 010 0 main red | side yellow | walk off/
					E = 7'b1001001, // 001 100 0 main red | side red | walk on
	                F = 7'b0000000; // all LEDS off testing
	 initial begin
        main_tb = 0; // variable to check if tb time spent on main green
        main_2tb = 0;
        // initialize values
        LEDs = A;
        side_detected = 0;
        interval = tb;
        WR_Reset = 0;
        side_ext = 0;
        //start_timer = 1;
        first = 1;
        //senseOneTime = 1;
     end
     
     always@(posedge clk) 
		begin
		
		start_timer = 0;
		if (Reprog_Sync | Reset_Sync | first) begin
			LEDs = A;
			interval = tb;
			main_tb=1;
			WR_Reset = 0;
			start_timer = 1;
			first = 0;
			//senseOneTime = 1;
        end
        if (expired) 
			begin
				case (LEDs)
					A: begin
					   if (main_tb & Sensor_Sync) begin
					       // check if sensor activated
					           interval = te;
					           //LEDs=F;
					           LEDs=A;
					           start_timer=1;
					           //main_tb=1;
					           side_detected = 1;
					   end
					   else if (main_tb & side_detected) begin
					       // main (main becomes 0 in the first if) was green for tb and side detected 
					       interval = ty;
					       //LEDs=F;
                           LEDs=B;
                           start_timer=1;
                           main_tb=0;
                           side_detected =0;
					   end
					   else if (main_tb) begin
					       // main was green for tb and sensor was not triggered
					       interval <= tb;
					       //LEDs=F;
					       start_timer<=1;
                           main_tb<=0;
                           main_2tb<=1;
                           LEDs<=A; // stay on for one more tb length
					   end
					   else if (main_2tb) begin
					       // main was green for 2*tb
					       interval = ty;
					       LEDs=F;
                           LEDs=B; // switch to main yello state
                           start_timer<=1;
                           main_2tb=0;
					   end
					   else if (~main_tb) begin
					       interval = tb;
					       LEDs=F;
                           LEDs=A;
                           start_timer=1;
                           main_tb=1;
					   end
					end   
					B: begin
					   if (WR) begin
					       //LEDs=F;
					       LEDs = E;
                           interval = te;
                           start_timer = 1;
                           WR_Reset = 1;
					   end
					   else begin
					       //LEDs=F;
					       LEDs = C;
					       interval = tb;
					       start_timer = 1;
					   end
					end
					C: begin
					   if (Sensor_Sync & ~side_ext) begin
					       interval = te;
					       LEDs=F;
					       LEDs=C;
					       start_timer=1;
					       side_ext = 1;
					   end
					   else begin
					       side_ext = 0;
					       interval = ty;
					       LEDs=F;
					       LEDs = D;
					       start_timer=1;
					   end
					end   
					D: begin
							LEDs = A;
							interval = tb;
							start_timer = 1;
							main_tb=1;
						end
					E: begin
					        LEDs=F;
							LEDs = D; // was C
							interval = tb;
							start_timer = 1;
							WR_Reset = 0;
						end
					default : 
							begin
							LEDs=F;
							LEDs = A;
							interval = tb;
							main_tb = 1;
							start_timer = 1;
							end
				endcase
			end
		end
endmodule
	 /*always@(posedge clk) 
		begin
		
		start_timer = 0;
		if (Reprog_Sync | Reset_Sync) begin
			LEDs = A;
			interval = tbx2;
			WR_Reset = 0;
			start_timer = 1;
			senseOneTime = 1;
			end
		if (expired) 
			begin
				case (LEDs)
					A: begin
							if (deviate) begin
								if (Sensor_Sync & senseOneTime)begin
									LEDs = A;
									interval = te;
									start_timer = 1;
									senseOneTime = 0;
 								end
								else begin
									LEDs = A;
									interval = tb;
									start_timer = 1;
								end
								deviate = 0;
							end
							
							else begin	
								LEDs = B;
								interval = ty;
								start_timer = 1;
							end
						end
					
					B:	begin
							if (WR) begin
								LEDs = E;
								interval = te;
								start_timer = 1;
								WR_Reset = 1;
							end
							else begin
								LEDs = C;
								interval = tb;
								start_timer = 1;
							end
							senseOneTime = 1;
						end
					C: begin
							if (Sensor_Sync & senseOneTime) begin
								LEDs = C;
								interval = te;
								start_timer = 1;
								senseOneTime = 0;
							end
							else begin
								LEDs = D;
								interval = ty;
								start_timer = 1;
								senseOneTime = 1;
							end
						end
					D: begin
							LEDs = A;
							interval = tb;
							start_timer = 1;
							deviate = 1;
							senseOneTime = 1;
						end
					E: begin
							LEDs = C;
							interval = tb;
							start_timer = 1;
							WR_Reset = 0;
						end
					default : 
							begin
							LEDs = A;
							interval = tb;
							deviate = 1;
							start_timer = 1;
							end
				endcase
		
		end
		end*/
	
	

//endmodule
