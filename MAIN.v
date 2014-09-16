module MAIN
(
SYSTEM_CLOCK,
score,
lives,
bricki,
ballx,
bally,
padup,
padwn,
finish,
LED_0,
LED_1,
LED_2,
LED_3,
pixel_clock,
VGA_OUT_PIXEL_CLOCK,
VGA_COMP_SYNCH,
VGA_OUT_BLANK_Z,
VGA_HSYNCH,
VGA_VSYNCH,
VGA_OUT_RED,
VGA_OUT_GREEN,
VGA_OUT_BLUE,
pass
);

input				SYSTEM_CLOCK;				// 100MHz LVTTL SYSTEM CLOCK
output			pass;
input [1:0]		finish;
input [39:0]	bricki;
input [9:0] 	ballx;
input [8:0]		bally;
input [9:0] 	padwn;
input [9:0] 	padup;
input [6:0]		score;
input [2:0]		lives;

output			LED_0;						// User LED 0
output			LED_1;						// User LED 1
output			LED_2;						// User LED 2
output			LED_3;						// User LED 3
output		   pixel_clock;
output 			VGA_OUT_PIXEL_CLOCK;		// pixel clock for the video DAC
output			VGA_COMP_SYNCH;			// composite sync for the video DAC
output 			VGA_OUT_BLANK_Z;			// composite blanking for the video DAC
output 			VGA_HSYNCH;					// horizontal sync for the VGA output connector
output			VGA_VSYNCH;					// vertical sync for the VGA output connector
output [7:0] 	VGA_OUT_RED;				// RED DAC data
output [7:0] 	VGA_OUT_GREEN;				// GREEN DAC data
output [7:0] 	VGA_OUT_BLUE;				// BLUE DAC data


reg				pass;
wire				system_clock_buffered;	// buffered SYSTEM CLOCK
wire				pixel_clock;				// generated from SYSTEM CLOCK
wire				reset;						// reset asserted when DCMs are NOT LOCKED

wire [7:0]		vga_red_data;				// red video data
wire [7:0]		vga_green_data;			// green video data
wire [7:0]		vga_blue_data;				// blue video data

// internal video timing signals
wire 				h_synch;
wire 				v_synch;
wire 				comp_synch;
wire 				blank;
wire [10:0]		pixel_count;				// bit mapped pixel position within the line
wire [9:0]		line_count;					// bit mapped line number in a frame lines within the frame


assign LED_0 = 0; // Turn LED_0 On
assign LED_1 = 1; // Turn LED_1 Off
assign LED_2 = 0; // Turn LED_2 On
assign LED_3 = 1; // Turn LED_3 Off

// instantiate the clock generation module
CLOCK_GEN CLOCK_GEN 
(
SYSTEM_CLOCK,
system_clock_buffered,
pixel_clock,
reset
);

// instantiate the video timing generator
SVGA_TIMING_GENERATION SVGA_TIMING_GENERATION
(
pixel_clock,
reset,
h_synch,
v_synch,
comp_synch,
blank,
pixel_count,
line_count
);

// instantiate the color bar generator
COLOR_BARS COLOR_BARS
(
pixel_clock,
reset,
finish,
pixel_count,
line_count,
lives,
score,
bricki,
ballx,bally,
padwn,padup,
vga_red_data,
vga_green_data,
vga_blue_data
);

// instantiate the video output mux
VIDEO_OUT VIDEO_OUT
(
pixel_clock,
reset,
vga_red_data,
vga_green_data,
vga_blue_data,
h_synch,
v_synch,
comp_synch,
blank,

VGA_OUT_PIXEL_CLOCK,
VGA_HSYNCH,
VGA_VSYNCH,
VGA_COMP_SYNCH,
VGA_OUT_BLANK_Z,
VGA_OUT_RED,
VGA_OUT_GREEN,
VGA_OUT_BLUE
);

//always @ (posedge SYSTEM_CLOCK) begin
	//pass=SYSTEM_CLOCK;
//end
endmodule // MAIN