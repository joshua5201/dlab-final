`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:29 01/07/2016 
// Design Name: 
// Module Name:    tp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TPs(input clk, input reset, input [2:0] id, input [9:0] x, input [9:0] y, input [1:0] state, 
	output reg [2:0] rgb, output reg game_end);
localparam INIT = 2'd0, GAME = 2'd1, WAIT = 2'd2;
reg [19:0] clk_count; // 50ms
reg [19:0] tick_count;

reg tp0_enabled;
wire tp0_bottom;
wire tp0_rgb;

always @(*)
begin
	rgb = tp0_rgb;
end
always @(posedge clk)
begin
	if (reset) begin
		clk_count <= 0;
		tick_count <= 0;
		tp0_enabled <= 0;
	end
	else begin
		if (state == GAME)
			tp0_enabled <= 1;
			
		if (clk_count > 250000) begin
			clk_count <= 0;
		end
		else begin
			clk_count <= clk_count + 1;
			if (tick_count > 250000) begin
				tick_count <= 0;
			end
			else begin
				tick_count <= tick_count + 1;
			end
		end
		
	end
end

endmodule