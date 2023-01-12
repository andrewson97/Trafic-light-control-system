`timescale 1us / 1ns

//module Divider(
//    input clk,
//	input rst,
//    output reg oneHz_enable
//    );
	 
//	 localparam [24:0] hz_constant = 25'd10;
//	 reg [24:0]counter = hz_constant;
//	 always@(posedge clk)
//		begin
//			if (rst) counter = hz_constant;
//			else begin
//				counter = counter - 1;
//				oneHz_enable = (counter == 0);
//				if (!counter) counter = hz_constant;
//			end
//		end

//endmodule
//module Divider(
//    input clk,
//    input rst,
//    output reg oneHz_enable
//    );

//    reg [27:0] counter = 0;
//    initial begin
//        oneHz_enable = 1;
//    end
//    always @(posedge clk) begin
//        counter = counter +1;
//        if (counter == 500000000) begin
//            oneHz_enable = ~oneHz_enable;
//            counter = 0;
//        end
//        if (rst) counter=0;
//    end

//endmodule

module Divider(
    input clk,
    input rst,
    output reg oneHz_clk
    );
    parameter MAX_COUNT = 50_000_000 - 1;
    reg [27:0] counter_100M;
    initial begin
        oneHz_clk = 1;
    end
    //assign an = 6'b1110;
    always @(posedge clk) begin
    if (rst) counter_100M <= 0;
    else if  (counter_100M == MAX_COUNT) begin
        counter_100M <= 0;
        oneHz_clk = ~ oneHz_clk;
        end
    else begin
        counter_100M <= counter_100M + 1'b1;
        end
    end
endmodule