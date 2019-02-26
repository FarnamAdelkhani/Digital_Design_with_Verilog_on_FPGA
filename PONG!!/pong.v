Main.v
`definecolor_red 8'b11100000
`definecolor_blue 8'b00000011
`definecolor_white 8'b11111111
`definecolor_black 8'b00000000
`definecolor_pink 8'b11111010

`definestate_reset 2'b00
`definestate_player_select 2'b01
`definestate_game 2'b10
`definestate_pause 2'b11
// keys
`define key_player1_right 8'h23
`define key_player1_left 8'h1C

`define key_player2_right 8'h4B
`define key_player2_left 8'h3B

`definekey_esc 8'h76
`definekey_space 8'h29
`define key_1 8'h16
`define key_2 8'h1E

`definepaddle_width 64
`definepaddle_height 8

`defineball_width 8
`defineball_height 8

`definescreen_width 640
`definescreen_height 480

`defineborder_size 6
`definefeature_size 11

`defineai_speed_default 4
module main(
	input clock,
	input ps2_data,
	input ps2_clock,
	input reset,
outputhsync,
outputvsync,
	outputreg [7:0]color,
	output [3:0] digit_selection,
	output [7:0] segment_selection
);
// declaration defines

wire done;
regold_done;
wire [7:0]tasta;
//reg clock;
reg border;
wire Inside;
wire [9:0] x_out, y_out;
reggame; // 1 daca e game si 0 pause

reg [3:0] score1, score2; // scorurile
wireenable_score;
wire [7:0] out_score;

reg [9:0] ball_x, ball_y;  		// position
reg [3:0] ball_vx, ball_vy;		// speed
regball_dx, ball_dy;				// direction: 1 pos, 0 neg

reg [9:0] paddle1_x, paddle1_y;	// position
reg [7:0] paddle1_vx, paddle1_vy;// speed

reg [9:0] paddle2_x, paddle2_y;	 // position
reg [7:0] paddle2_vx, paddle2_vy; //speed

reg [5:0] counter;
reg [5:0] speed;

reg [5:0] ai_counter;
reg [5:0] ai_speed;

regplayer_number; // 0 = 1 player ; 1 = 2 players
reg [1:0] states; // states

// 0: reset
// 1: player_select (keyboard 1 or 2), highlight player's bar
// 2: game (space keyboard to begin)
// 3: pause (space keyboard to rebegin game / esc to reset)
reg [7:0] key;

keyboardkeyb(.clock(clock),.ps2_clock(ps2_clock), .ps2_data(ps2_data),.done(done), .tasta(tasta));
display lcd(.clock(clock),.vsync(vsync),.hsync(hsync),.Inside(Inside),.x_out(x_out),.y_out(y_out));
//dashboard dashboard(.clock(clock),.score1(score1),.score2(score2),.digit_selection(digit_selection),.segment_selection(segment_selection));
Scor Scor(.clock(clock),.scor1(score1),.scor2(score2),.dec(digit_selection),.out(segment_selection),.enable(1));

initial begin
	states<= `state_reset;
	speed<= 5;
	score1 <= 0;
	score2 <= 0;
	ai_speed<= `ai_speed_default;
end

// drawing
always @(posedge clock)
begin
	if(Inside) begin

		// scancode keyboard
		if(old_done != done) begin
			if(done) begin
				key<= tasta;

			end else


			old_done<= done;
		end

		// Game logic
		if(x_out == 1 &&y_out == 1) begin

			// switch states
			case (states)
				`state_reset:
					begin
						ball_x<= `screen_width>> 1; // ball in the center of screen
						ball_y<= `screen_height>> 1;

						paddle2_x <= `screen_width>> 1;
						paddle2_y <= `border_size<< 2;

						paddle1_x <= `screen_width>> 1;
						paddle1_y <= `screen_height - (`border_size<< 2);

						states<= `state_player_select;

						score1 <= 0;
						score2 <= 0;
					end
				`state_player_select:
					begin

						if (key == `key_1) begin
							player_number<= 0;
							key<= 0;
						end else if (key == `key_2) begin
							player_number<=1;
							key<= 0;
						end else if (key == `key_space) begin
							key<= 0;
							states<= `state_game;

							// set ball speed
							ball_vx<= 3;
							ball_vy<= 2;
							ball_dx<= 1;
							ball_dy<= 1;
							speed<= 5;
						end
					end
				`state_game:
					begin

						if (key == `key_space) begin
							states<= `state_pause;
							key<= 0;
						end else if (key == `key_player1_left) begin
							if (paddle1_x >= `feature_size + `ball_width + (`paddle_width>> 1))
								paddle1_x <= paddle1_x - `ball_width;
							key<= 0;
						end else if (key == `key_player1_right) begin
							if (paddle1_x <= `screen_width - `feature_size - `ball_width - (`paddle_width>> 1))
								paddle1_x <= paddle1_x + `ball_width;
							key<= 0;
						end else if (key == `key_player2_left) begin
							if(player_number)
								if (paddle2_x >= `feature_size + `ball_width + (`paddle_width>> 1))
									paddle2_x <= paddle2_x - `ball_width;
							key<= 0;
						end else if (key == `key_player2_right) begin
							if(player_number)
								if (paddle2_x <= `screen_width - `feature_size - `ball_width - (`paddle_width>> 1))
									paddle2_x <= paddle2_x + `ball_width;
							key<= 0;
						end
							// TO BE CONTINUED

						if(counter == speed) begin
							counter<= 0;

							if(ball_dx) // to right
								if (ball_x<= `screen_width - `feature_size - `ball_width - (`ball_width>> 1))
									ball_x<= ball_x + `ball_width;
								else
									ball_dx<= 0;
							else       // to left
								if (ball_x>= `feature_size + `ball_width + (`ball_width>> 1))
									ball_x<= ball_x - `ball_width;
								else
									ball_dx<= 1;

						if(ball_dy) // to down
								if ((ball_x>= paddle1_x - (`paddle_width>> 1)) && (ball_x<= paddle1_x + (`paddle_width>> 1)) && (ball_y == paddle1_y - `ball_width)) begin
									ball_dy<= 0;
									if(speed > 1)
										speed<= speed - 1;

								end else if (ball_y<= `screen_height - `feature_size - `ball_width - (`ball_width>> 1))
									ball_y<= ball_y + `ball_width;
								else begin
									ball_dy<= 0;
									speed<= 5;
									score2 <= score2 + 1;
									if (score2 == 9)
										states<= `state_reset;

								end
							else       // to up
								if ((ball_x>= paddle2_x - (`paddle_width>> 1)) && (ball_x<= paddle2_x + (`paddle_width>> 1)) && (ball_y == paddle2_y + `ball_width)) begin
									ball_dy<= 1;
									if(speed > 1)
										speed<= speed - 1;

								end else if (ball_y>= `feature_size + `ball_width + (`ball_width>> 1))
									ball_y<= ball_y - `ball_width;
								else begin
									ball_dy<= 1;
									speed<= 5;
									score1 <= score1 + 1;
									if (score1 == 9)
										states<= `state_reset;
								end


						end else
							counter<= counter + 1;

						if(!player_number) begin

							// ai logic

							if(ai_counter == ai_speed) begin
								ai_counter<= 0;


								if(ball_x> paddle2_x)
									// move right
									if (paddle2_x <= `screen_width - `feature_size - `ball_width - (`paddle_width>> 1))
										paddle2_x <= paddle2_x + `ball_width;

								if(ball_x< paddle2_x)
									//move left
									if (paddle2_x >= `feature_size + `ball_width + (`paddle_width>> 1))
										paddle2_x <= paddle2_x - `ball_width;
							end else
								ai_counter<= ai_counter + 1;
						end
					end
				`state_pause:
					begin

						if (key == `key_space) begin
							states<= `state_game;
							key<= 0;
						end else if (key == `key_esc) begin
							states<= `state_reset;
							key<= 0;
						end
					end
			endcase

		end

		//border
		if (x_out<= `border_size || x_out>= `screen_width - `border_size || (y_out> 1 &&y_out<= `border_size) || y_out>= `screen_height - `border_size)
			color<= `color_white;
		else if (x_out<= `feature_size || x_out>= `screen_width - `feature_size || (y_out> 1 &&y_out<= `feature_size) || y_out>= `screen_height - `feature_size)
			color<= `color_pink;

		//paddle1 bottom
		else if (x_out>= paddle1_x  - (`paddle_width>> 1) &&x_out<= paddle1_x + (`paddle_width>> 1) &&y_out>= paddle1_y - (`paddle_height>> 1) &&y_out<= paddle1_y  + (`paddle_height>> 1))
			color<= `color_red;

		//paddle2 top
		else if (x_out>= paddle2_x  - (`paddle_width>> 1) &&x_out<= paddle2_x + (`paddle_width>> 1) &&y_out>= paddle2_y - (`paddle_height>> 1) &&y_out<= paddle2_y  + (`paddle_height>> 1))
			if(states == `state_player_select)
				if(player_number)
					color<= `color_red;
				else
					color<= `color_black;
			else
				color<= `color_red;

		//ball
		else if (x_out>= ball_x  - (`ball_width>> 1) &&x_out<= ball_x + (`ball_width>> 1) &&y_out>= ball_y - (`ball_height>> 1) &&y_out<= ball_y  + (`ball_height>> 1))
			color<= `color_white;
		// background
		else
			color<= `color_black;
	end
end



endmodule


// VGA
// ModulSincronizare
// Display will generate the HS (HorizSyncro),
// VS (Vertical Syncro) and X,Y - that will be used
// to control the main module
// Inside register says if it is
//the HS (Horizontal Synchronization),
// VS(Vertical Synchronization) and
// the control signals which is
// used by second module.
// (r,g,b) <= (1,1,1) for white
// Format 800 x 524 25Mhz -> 640 x 480
module display(
	input clock,
	outputreghsync,
	outputregvsync,
	outputreg Inside, // verificadaca e in interior sau nu
	outputreg [9:0] x_out,
	outputreg [9:0] y_out
);
reg [9:0] x;
reg [9:0] y;

always @(posedge clock) begin
	// HS
	// 0 - 47 -> Back porch
	// 47 - 687 -  Display
	// 687 - 703 - Front Porch
	// 703 - 799 Retrace

	// indicator of visible area
	if(x <= 687 && x >= 47 && y <= 512 && y >=32)
		Inside <= 1;
	else
		Inside <= 0;

	// horizontal back porch
	if(x >= 0 && x <= 47)
		hsync<= 1;
	else
		hsync<= 0;

	// vertical back porch
	if(y >= 0 && y <= 31)
		vsync<= 1;
	else
		vsync<= 0;

	// horizontal visible area
	if(x >= 47 && x <= 687)
		hsync<= 1;
	else
		hsync<= 0;

	// vertical visible area
	if(y >= 32 && y <= 512)
		vsync<= 1;
	else
		vsync<= 0;

	// horizontal front porch
	if (x >= 687 && x < 703)
		hsync<= 1;
	else
		hsync<= 0;

	// vertical front porch
	if(y >= 512 && y <= 522)
		vsync<= 1;
	else
		vsync<= 0;

	// horizontal sync pulse
	if (x > 703 && x < 799)
		hsync<= 0;
	else
		hsync<= 1;

	// vertical sync pulse
	if(y >= 522 && y <= 524)
		vsync<= 0;
	else
		vsync<= 1;

	if(x == 799) begin
		x <= 0;
		if(y == 524)
			y <= 0;
		else
			y <= y + 1;
	end else
		x <= x + 1;

	x_out<= x - 48;
	y_out<= y - 31;
end

endmodule

// Keyboard
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UPB
// Engineer: Sorina Lupu
//
// Create Date:    13:45:29 04/19/2014
// Design Name:
// Module Name:    keyboard
// Project Name:
// Target Devices:
// Tool versions:
// Description: Keyboard for PONG and Bricks
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Enjoy:)
//
//////////////////////////////////////////////////////////////////////////////////
`define q 8'h15
`define a 8'h1C
`define s 8'h1B
`define d 8'h23

`definei 8'h43
`define j 8'h38
`define k 8'h42
`define l 8'h4B

module keyboard(
	input clock,
input ps2_clock,
	input ps2_data,
outputreg done,
outputreg [7:0] tasta
);
//One player
// Q = 15 = 8'h15
// A = 1C = 8'h1C
// S = 1B = 8'h1B
// D = 23 = 8'h23
// Second Player
// I = 43 = 8'h43
// J = 38 = 8'h3B
// K = 42 = 8'h42
// L = 4B = 8'h4B


reg [3:0] count; // 11 biti
reg skip;

regclock_new;

initial begin
	count<= 4'h1;
	done<= 1'b0;
	tasta<= 8'hf0;
	skip<= 0;
end

always @(posedge clock) begin
	if(ps2_clock == 1) begin
		clock_new<= 1;
	end else begin
		clock_new<= 0;
	end
end

always @(negedgeclock_new) //Activating at negative edge of clock from keyboard
begin

	case(count)
		1: done <= 0; //first bit
		2: tasta[0]<=ps2_data;
		3: tasta[1]<=ps2_data;
		4: tasta[2]<=ps2_data;
		5: tasta[3]<=ps2_data;
		6: tasta[4]<=ps2_data;
		7: tasta[5]<=ps2_data;
		8: tasta[6]<=ps2_data;
		9: tasta[7]<=ps2_data;
		10: ; //Parity bit
		11: begin  //Ending bit

				// key up
				if(tasta == 8'hF0)
					skip<= 1;
				else if (!skip)
					done<= 1;
				else
					skip<= 0;
			end
	endcase

	if(count <= 10)
		count<= count+1;
	else if(count==11)
		count<= 1;
end

endmodule

// Scor

moduleScor(
input [3:0] scor1,
input [3:0] scor2,
input clock,
input enable,
output  [7:0] out,
output  [3:0] dec
  );

wire [7:0] fir1;
wire [7:0] fir2;
wire fir3;

AfisajAfisaj1(
  .in(scor1),
  .out(fir1)
  );

AfisajAfisaj2(
  .in(scor2),
  .out(fir2)
  );

  Mux Muxs(
  .select(fir3),
  .in0(fir1),
  .in1(fir2),
  .outm(out)
  );

  Selector Selectors(
  .clock(clock),
  .e1(fir3),
  .e2(dec),
  .enable(enable)
  );

endmodule

// Display 7 segments
moduleAfisaj(
outputreg[7:0] out,
input  [3:0] in
);
always@(in) begin
case(in)
    0: out = 8'b11000000;
    1: out = 8'b11111001;
    2: out = 8'b10100100;
    3: out = 8'b10110000;
    4: out = 8'b10011001;
    5: out = 8'b10010010;
    6: out = 8'b10000010;
    7: out = 8'b11111000;
    8: out = 8'b10000000;
    9: out = 8'b10010000;
default: out = 8'b00001010;
endcase
end
endmodule

// MUX
module Mux(
input wire select,
input wire [7:0] in0,
input wire [7:0] in1,
outputreg [7:0] outm
  );
always@(select) begin
if(select) begin
outm=in1;
end else begin
outm=in0;
end
end
endmodule


// Selector
module Selector(
input clock,
output e1,
outputreg [3:0] e2,
input enable
);

reg [20:0] count;

assign e1=count[18];

always@(posedge clock) begin
  e2 <= 4'b1111;
if(enable) begin
count<= count + 1;
if(e1) begin
      e2 <= 4'b0111;
end else begin
      e2 <= 4'b1101;
end
end
end
endmodule


//links.ucf
net "clock" loc = "P54";

net "digit_selection[0]" loc = "P26";
net "digit_selection[1]" loc = "P32";
net "digit_selection[2]" loc = "P33";
net "digit_selection[3]" loc = "P34";

net "segment_selection[0]" loc = "P25";
net "segment_selection[1]" loc = "P16";
net "segment_selection[2]" loc = "P23";
net "segment_selection[3]" loc = "P21";
net "segment_selection[4]" loc = "P20";
net "segment_selection[5]" loc = "P17";
net "segment_selection[6]" loc = "P83";
net "segment_selection[7]" loc = "P22";


net "hsync" loc = "P39";
net "vsync" loc = "P35";


net "color[0]" loc = "P44";
net "color[1]" loc = "P43";

net "color[2]" loc = "P52";
net "color[3]" loc = "P51";
net "color[4]" loc = "P50";

net "color[5]" loc = "P70";
net "color[6]" loc = "P68";
net "color[7]" loc = "P67";

net "ps2_clock" loc = "P96";
net "ps2_data" loc = "P97";

net "reset" loc ="P69";
