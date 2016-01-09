`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:47 01/07/2016 
// Design Name: 
// Module Name:    msg 
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
module msg(input [9:0] x, input [9:0] y, input [1:0] state, output reg [2:0] rgb);
localparam INIT = 2'd0, GAME = 2'd1, WAIT = 2'd2;

always @(*)
	if (state == WAIT && x > 200 && x < 440 && y > 140 && y < 340 ) begin
		rgb = 3'b011;
	end
	else begin
		rgb = 3'b000;
	end
endmodule
