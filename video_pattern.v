`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:31 12/02/2015 
// Design Name: 
// Module Name:    video_pattern 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//                 Generates 8 video test patterns at the resolution of 640x480 pixels
//
// Dependencies:
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module video_pattern(input [2:0] id, input [9:0] x, input [9:0] y, output reg [2:0] rgb);

always @(*)
  case (id)
  3'b000: // vertical test pattern
    begin
      if (x < 80) rgb = 3'b000;
      else if (x < 160) rgb = 3'b001;
      else if (x < 240) rgb = 3'b010;
      else if (x < 320) rgb = 3'b011;
      else if (x < 400) rgb = 3'b100;
      else if (x < 480) rgb = 3'b101;
      else if (x < 560) rgb = 3'b110;
      else rgb = 3'b111;
    end
  3'b001: // horizontal test pattern
    begin
      if (y < 60) rgb = 3'b000;
      else if (y < 120) rgb = 3'b001;
      else if (y < 180) rgb = 3'b010;
      else if (y < 240) rgb = 3'b011;
      else if (y < 300) rgb = 3'b100;
      else if (y < 360) rgb = 3'b101;
      else if (y < 420) rgb = 3'b110;
      else rgb = 3'b111;
    end
  3'b010: // red-screen test pattern
    begin
      rgb = 3'b100;
    end
  3'b011: // green-screen test pattern
    begin
      rgb = 3'b010;
    end
  3'b100: // blue-screen test pattern
    begin
      rgb = 3'b001;
    end
  3'b101: // white grid test pattern
    begin
       if (|x[4:0] == 0 || |y[4:0] == 0) rgb = 3'b111;
       else if (x == 639|| y == 479) rgb = 3'b111;
       else rgb = 3'b000;
    end
  3'b110: // green grid test pattern
    begin
       if (|x[4:0] == 0 || |y[4:0] == 0) rgb = 3'b010;
       else if (x == 639 || y == 479) rgb = 3'b010;
       else rgb = 3'b000;
    end
  3'b111: // color blocks test pattern
    begin
      rgb = (x[7:5] ^ y[7:5]);
    end
  endcase

endmodule
