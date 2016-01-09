`timescale 1ns / 1ps
module final(
    input  clk,
    input  reset,
    input  button,
		input  ROT_A,
		input ROT_B,

    // VGA specific I/O ports
    output HSYNC,
    output VSYNC,
    output VGA_RED,
    output VGA_GREEN,
    output VGA_BLUE,
		output [7:0] led
    );
// general VGA control signals
wire video_on;      // when video_on is 0, the VGA controller is sending
                    // synchronization signals to the display device.

wire pixel_tick;    // when pixel tick is 1, we must update the RGB value
                    // based for the new coordinate (pixel_x, pixel_y)

wire [9:0] pixel_x; // x coordinate of the next pixel (between 0 ~ 639) 
wire [9:0] pixel_y; // y coordinate of the next pixel (between 0 ~ 479)

reg [2:0] rgb_reg;  // RGB value for the current pixel
reg [2:0] rgb_next; // RGB value for the next pixel

// Application-specific VGA signals
wire [2:0] current_rgb; // RGB values for the frame display application.
                        // In this demo, the value is generated by
                        // a video pattern generator:
                        //      video_pattern(id, x, y, current_rgb),
                        // where the input is the current scan coordinate (x, y),
                        // and the output is the RGB value of the video pattern
                        // 'id' at pixel (x, y).
wire [2:0] rgb_gp;
wire [2:0] rgb_score;
wire [2:0] rgb_msg;
// Declare system variables
wire btn_level, btn_pressed;
reg  prev_btn_level;
wire rot_event;
wire rot_right;
wire rot_left;
assign rot_right = !rot_left;

Rotation_direction rotate(
    .CLK(clk),
    .ROT_A(ROT_A),
    .ROT_B(ROT_B),
    .rotary_event(rot_event),
    .rotary_right(rot_left)
);
reg [3:0] score_reg;
reg [3:0] tp_count;
reg [1:0] S;
localparam INIT = 2'd0, GAME = 2'd1, WAIT = 2'd2;
always @(posedge clk)
begin
	if (reset) 
		S <= INIT;
	else begin
		case (S)
			INIT: begin
				if (btn_pressed)
					S <= GAME;
			end
			GAME: begin
				if (tp_count == 10)
					S <= WAIT;
			end
			WAIT: begin
			end
		endcase
	end
end

debounce btn_db0(
  .clk(clk),
  .btn_input(button),
  .btn_output(btn_level)
  );
// instiantiate a VGA sync signal generator
vga_sync vs0(
  .clk(clk), .reset(reset), .oHS(HSYNC), .oVS(VSYNC),
  .visible(video_on), .p_tick(pixel_tick),
  .pixel_x(pixel_x), .pixel_y(pixel_y)
  );

reg [9:0] gp_x;
GP gp0(
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(gp_x),
	.state(S),
	.rgb(rgb_gp)
);
/*
TPs tps(
	.clk(clk),
	.reset(reset),
	.id(3'b0),
	.x(pixel_x),
	.y(pixel_y),
	.state(S),
	.rgb(rgb_tp),
	.game_end(game_end)
);
*/

wire [2:0] rgb_tp0;
wire [3:0] tp0_bottom;
reg tp0_enabled;
wire [3:0] tp0_point;
TP tp0 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(234),
	.enabled(tp0_enabled),
	.color(3'b110),
	.speed(3),
	.delay(0),
	.gp_x(gp_x),
	.shape(2),
	.reach_bottom(tp0_bottom),
	.point(tp0_point),
	.rgb(rgb_tp0)
);

wire [2:0] rgb_tp1;
wire [3:0] tp1_bottom;
reg tp1_enabled;
wire [3:0] tp1_point;
TP tp1 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(345),
	.enabled(tp1_enabled),
	.color(3'b111),
	.speed(5),
	.delay(1),
	.gp_x(gp_x),
	.shape(0),
	.reach_bottom(tp1_bottom),
	.point(tp1_point),
	.rgb(rgb_tp1)
);

wire [2:0] rgb_tp2;
wire [3:0] tp2_bottom;
reg tp2_enabled;
wire [3:0] tp2_point;

TP tp2 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(456),
	.enabled(tp2_enabled),
	.color(3'b101),
	.speed(3),
	.delay(3),
	.gp_x(gp_x),
	.shape(1),	
	.reach_bottom(tp2_bottom),
	.point(tp2_point),	
	.rgb(rgb_tp2)
);

wire [2:0] rgb_tp3;
wire [3:0] tp3_bottom;
reg tp3_enabled;
wire [3:0] tp3_point;

TP tp3 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(440),
	.enabled(tp3_enabled),
	.color(3'b111),
	.speed(1),
	.delay(4),
	.gp_x(gp_x),
	.shape(0),	
	.reach_bottom(tp3_bottom),
	.point(tp3_point),	
	.rgb(rgb_tp3)
);

wire [2:0] rgb_tp4;
wire [3:0] tp4_bottom;
reg tp4_enabled;
wire [3:0] tp4_point;

TP tp4 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(69),
	.enabled(tp4_enabled),
	.color(3'b111),
	.speed(4),
	.delay(6),
	.gp_x(gp_x),
	.shape(2),	
	.reach_bottom(tp4_bottom),
	.point(tp4_point),	
	.rgb(rgb_tp4)
);

wire [2:0] rgb_tp5;
wire [3:0] tp5_bottom;
reg tp5_enabled;
wire [3:0] tp5_point;

TP tp5 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(34),
	.enabled(tp5_enabled),
	.color(3'b101),
	.speed(1),
	.delay(7),
	.gp_x(gp_x),
	.shape(2),	
	.reach_bottom(tp5_bottom),
	.point(tp5_point),	
	.rgb(rgb_tp5)
);

wire [2:0] rgb_tp6;
wire [3:0] tp6_bottom;
reg tp6_enabled;
wire [3:0] tp6_point;

TP tp6 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(600),
	.enabled(tp6_enabled),
	.color(3'b101),
	.speed(3),
	.delay(9),
	.gp_x(gp_x),	
	.shape(0),	
	.reach_bottom(tp6_bottom),
	.point(tp6_point),	
	.rgb(rgb_tp6)
);

wire [2:0] rgb_tp7;
wire [3:0] tp7_bottom;
reg tp7_enabled;
wire [3:0] tp7_point;

TP tp7 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(489),
	.enabled(tp7_enabled),
	.color(3'b010),
	.speed(3),
	.delay(10),
	.gp_x(gp_x),
	.shape(0),	
	.reach_bottom(tp7_bottom),
	.point(tp7_point),	
	.rgb(rgb_tp7)
);

wire [2:0] rgb_tp8;
wire [3:0] tp8_bottom;
reg tp8_enabled;
wire [3:0] tp8_point;

TP tp8 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(333),
	.enabled(tp8_enabled),
	.color(3'b100),
	.speed(4),
	.delay(13),
	.gp_x(gp_x),	
	.shape(1),	
	.reach_bottom(tp8_bottom),
	.point(tp8_point),	
	.rgb(rgb_tp8)
);

wire [2:0] rgb_tp9;
wire [3:0] tp9_bottom;
reg tp9_enabled;
wire [3:0] tp9_point;

TP tp9 (
	.clk(clk),
	.reset(reset),
	.x(pixel_x),
	.y(pixel_y),
	.position_x(500),
	.enabled(tp9_enabled),
	.color(3'b001),
	.speed(6),
	.delay(13),
	.gp_x(gp_x),	
	.shape(2),	
	.reach_bottom(tp9_bottom),
	.point(tp9_point),
	.rgb(rgb_tp9)
);


always @(*)
begin
	score_reg = tp0_point + tp1_point + tp2_point + tp3_point + tp4_point + tp5_point + tp6_point
		 + tp7_point + tp8_point + tp9_point;
	tp_count = tp0_bottom + tp1_bottom + tp2_bottom + tp3_bottom + tp4_bottom + tp5_bottom + tp6_bottom
		 + tp7_bottom + tp8_bottom + tp9_bottom;
end
assign led[7:4] = 0;
assign led[3:0] = score_reg;
score score0(
	.x(pixel_x),
	.y(pixel_y),
	.state(S),
	.score(score_reg),
	.rgb(rgb_score)
);
msg msg0(
	.x(pixel_x),
	.y(pixel_y),
	.state(S),
	.rgb(rgb_msg)
);

// VGA color pixel generator
assign {VGA_RED, VGA_GREEN, VGA_BLUE} = rgb_reg;
always @(posedge clk) begin
  if (pixel_tick)
    rgb_reg <= rgb_next;
  else
    rgb_reg <= rgb_reg;
	
	if (S == INIT || reset)  begin
		gp_x <= 240;
		tp0_enabled <= 0;
		tp1_enabled <= 0;
		tp2_enabled <= 0;
		tp3_enabled <= 0;
		tp4_enabled <= 0;
		tp5_enabled <= 0;
		tp6_enabled <= 0;
		tp7_enabled <= 0;
		tp8_enabled <= 0;
		tp9_enabled <= 0;

	end
	else begin
		if (S == GAME) begin
			if (tp0_point == 0)
				tp0_enabled <= 1;
			if (tp1_point == 0)				
				tp1_enabled <= 1;
			if (tp2_point == 0)
				tp2_enabled <= 1;
			if (tp3_point == 0)
				tp3_enabled <= 1;
			if (tp4_point == 0)
				tp4_enabled <= 1;
			if (tp5_point == 0)
				tp5_enabled <= 1;
			if (tp6_point == 0)
				tp6_enabled <= 1;
			if (tp7_point == 0)
				tp7_enabled <= 1;
			if (tp8_point == 0)
				tp8_enabled <= 1;
			if (tp9_point == 0)
				tp9_enabled <= 1;
		end
	end

	
	if (rot_event) begin
		if (S == GAME && rot_right) begin
			if (gp_x + 10 >= 608) begin
				gp_x <= 608;
			end 
			else begin
				gp_x <= gp_x + 10;
			end
		end 
		else if (S == GAME && rot_left) begin
			if (gp_x <= 10) begin
				gp_x <= 0;
			end
			else begin
				gp_x <= gp_x - 10;
			end
		end
		else begin
		end
	end
end

always @(*) begin
  if (~video_on)
    rgb_next = 3'b000; // synchronization period, no need to set RGB values
  else
		rgb_next = rgb_gp + rgb_tp0 + rgb_tp1 + rgb_tp2 + rgb_tp3 + rgb_tp4
			+ rgb_tp5 + rgb_tp6 + rgb_tp7 + rgb_tp8 + rgb_tp9 + rgb_score + rgb_msg;

end

// Button click controller
always @(posedge clk) begin
  if (reset)
    prev_btn_level <= 1;
  else
    prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level & ~prev_btn_level);
endmodule
