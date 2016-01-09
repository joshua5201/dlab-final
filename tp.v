`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:35:18 01/08/2016 
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
module TP(
	input clk,
	input reset,
	input [9:0] x, 
	input [9:0] y, 
	input [9:0] position_x, 
	input enabled,
	input [2:0] color,
	input [9:0] speed,
	input [9:0] delay,
	input [9:0] gp_x,
	input [2:0] shape,
	output reg [3:0] reach_bottom,
	output reg [3:0] point,
	output reg [2:0] rgb
);

reg [19:0] clk_count;
reg [19:0] tick_count;
reg [9:0] position_y;
reg [19:0] s1;
reg [19:0] s2;
always @(*)
begin
	if (enabled && point == 0 && reach_bottom == 0 && position_y && x - position_x < 20 && x - position_x >= 0 && y - position_y < 20 
		&& y - position_y >= 0) begin
		if (shape == 0) begin
			rgb = color;
		end
		else if (shape == 1) begin
			case (x - position_x)
				0: rgb = s1[19] ? 3'b110 : 3'b000;
				1: rgb = s1[18] ? 3'b110 : 3'b000;
				2: rgb = s1[17] ? 3'b110 : 3'b000;
				3: rgb = s1[16] ? 3'b110 : 3'b000;
				4: rgb = s1[15] ? 3'b110 : 3'b000;
				5: rgb = s1[14] ? 3'b110 : 3'b000;
				6: rgb = s1[13] ? 3'b110 : 3'b000;
				7: rgb = s1[12] ? 3'b110 : 3'b000;
				8: rgb = s1[11] ? 3'b110 : 3'b000;
				9: rgb = s1[10] ? 3'b110 : 3'b000;
				10: rgb = s1[9] ? 3'b110 : 3'b000;
				11: rgb = s1[8] ? 3'b110 : 3'b000;
				12: rgb = s1[7] ? 3'b110 : 3'b000;
				13: rgb = s1[6] ? 3'b110 : 3'b000;
				14: rgb = s1[5] ? 3'b110 : 3'b000;
				15: rgb = s1[4] ? 3'b110 : 3'b000;
				16: rgb = s1[3] ? 3'b110 : 3'b000;
				17: rgb = s1[2] ? 3'b110 : 3'b000;
				18: rgb = s1[1] ? 3'b110 : 3'b000;
				19: rgb = s1[0] ? 3'b110 : 3'b000;
				default: rgb = 3'b000;
				endcase
			end 
		else begin
			case (x - position_x)
				0: rgb = s2[19] ? 3'b110 : 3'b000;
				1: rgb = s2[18] ? 3'b110 : 3'b000;
				2: rgb = s2[17] ? 3'b110 : 3'b000;
				3: rgb = s2[16] ? 3'b110 : 3'b000;
				4: rgb = s2[15] ? 3'b110 : 3'b000;
				5: rgb = s2[14] ? 3'b110 : 3'b000;
				6: rgb = s2[13] ? 3'b110 : 3'b000;
				7: rgb = s2[12] ? 3'b110 : 3'b000;
				8: rgb = s2[11] ? 3'b110 : 3'b000;
				9: rgb = s2[10] ? 3'b110 : 3'b000;
				10: rgb = s2[9] ? 3'b110 : 3'b000;
				11: rgb = s2[8] ? 3'b110 : 3'b000;
				12: rgb = s2[7] ? 3'b110 : 3'b000;
				13: rgb = s2[6] ? 3'b110 : 3'b000;
				14: rgb = s2[5] ? 3'b110 : 3'b000;
				15: rgb = s2[4] ? 3'b110 : 3'b000;
				16: rgb = s2[3] ? 3'b110 : 3'b000;
				17: rgb = s2[2] ? 3'b110 : 3'b000;
				18: rgb = s2[1] ? 3'b110 : 3'b000;
				19: rgb = s2[0] ? 3'b110 : 3'b000;
				default: rgb = 3'b000;
				endcase
		end
	end
	else begin
		rgb = 3'b000;
	end
end

always @(posedge clk)
begin
	if (reset) begin
		clk_count <= 0;
		position_y <= 0;
		reach_bottom <= 0;
		tick_count <= 0;
		point <= 0;
	end
	else begin
		if (enabled) begin
			if (clk_count > 250000 + 125000*(speed-1)) begin
				clk_count <= 0;
				if (tick_count >= 250000)
					tick_count <= 0;
				else
					tick_count <= tick_count + 1;
					
				if (reach_bottom == 0 && tick_count > delay * 200) 
					position_y <= position_y + 1;
			end 
			else begin
				clk_count <= clk_count + 1;
			end
			
			if (position_y >= 420) begin
				if (gp_x > position_x && gp_x - position_x <= 30) begin
					point <= 1;
				end
				else if (position_x > gp_x && position_x - gp_x <= 30) begin
					point <= 1;
				end
			end
			
			if (position_y >= 460) begin
				reach_bottom <= 1;
			end
			else begin
				reach_bottom <= 0;
			end
			
		end
	end
end
always @(*) begin
	case (y - position_y) 
		 0: s1 = 20'b00000011111111000000;
		 1: s1 = 20'b00000111111111110000;
		 2: s1 = 20'b00001111111111111000;
		 3: s1 = 20'b00011111111111111000;
		 4: s1 = 20'b00011111111111111100;
		 5: s1 = 20'b00111111111111111100;
		 6: s1 = 20'b01111111111111111110;
		 7: s1 = 20'b01111111111111111110;
		 8: s1 = 20'b01111111111111111110;
		 9: s1 = 20'b11111111111111111111;
	  10: s1 = 20'b11111111111111111111;
		11: s1 = 20'b11111111111111111111;
		12: s1 = 20'b11111111111111111110;
		13: s1 = 20'b01111111111111111110;
		14: s1 = 20'b01111111111111111110;
		15: s1 = 20'b01111111111111111100;
		16: s1 = 20'b01111111111111111100;
		17: s1 = 20'b00111111111111111000;
		18: s1 = 20'b00001111111111100000;
		19: s1 = 20'b00000111111111000000;
		default: s1 = 20'd0;
	endcase
end
always @(*) begin
	case (y - position_y) 
		 0: s2 = 20'b00000000011000000000;
		 1: s2 = 20'b00000000011000000000;
		 2: s2 = 20'b00000000111100000000;
		 3: s2 = 20'b00000000111100000000;
		 4: s2 = 20'b00000001111110000000;
		 5: s2 = 20'b00000001111110000000;
		 6: s2 = 20'b00000011111111000000;
		 7: s2 = 20'b00000011111111000000;
		 8: s2 = 20'b00000111111111100000;
		 9: s2 = 20'b00000111111111100000;
	  10: s2 = 20'b00001111111111110000;
		11: s2 = 20'b00001111111111110000;
		12: s2 = 20'b00011111111111111000;
		13: s2 = 20'b00011111111111111000;
		14: s2 = 20'b00111111111111111100;
		15: s2 = 20'b00111111111111111100;
		16: s2 = 20'b01111111111111111110;
		17: s2 = 20'b01111111111111111110;
		18: s2 = 20'b11111111111111111111;
		19: s2 = 20'b11111111111111111111;
		default: s2 = 20'd0;
	endcase
end
endmodule
