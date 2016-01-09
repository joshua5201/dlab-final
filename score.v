`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:36 01/07/2016 
// Design Name: 
// Module Name:    score 
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
module score(input [9:0] x, input [9:0] y, input [7:0] score, input [1:0] state, output reg [2:0] rgb);
localparam INIT = 2'd0, GAME = 2'd1, WAIT = 2'd2;

always @(*)
begin
	if (x > 440 && x < 590 && y > 20 && y < 130) begin
		rgb = 3'b111;
	end
	else begin
		rgb = 3'b000;
	end
end

endmodule