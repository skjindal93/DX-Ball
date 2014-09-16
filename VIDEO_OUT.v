module VIDEO_OUT
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

input				pixel_clock;
input				reset;
input [7:0]		vga_red_data;
input [7:0]		vga_green_data;
input [7:0]		vga_blue_data;
input				h_synch;
input				v_synch;
input				comp_synch;
input				blank;

output			VGA_OUT_PIXEL_CLOCK;
output			VGA_HSYNCH;
output			VGA_VSYNCH;
output			VGA_COMP_SYNCH;
output			VGA_OUT_BLANK_Z;
output [7:0]	VGA_OUT_RED;
output [7:0]	VGA_OUT_GREEN;
output [7:0]	VGA_OUT_BLUE;

reg				VGA_HSYNCH;
reg				VGA_VSYNCH;
reg				VGA_COMP_SYNCH;
reg				VGA_OUT_BLANK_Z;
reg [7:0]		VGA_OUT_RED;
reg [7:0]		VGA_OUT_GREEN;
reg [7:0]		VGA_OUT_BLUE;

wire high = 1'b1;
wire low = 1'b0;

// make the external video connections
always @ (posedge pixel_clock or posedge reset) begin
	if (reset) begin
		// shut down the video output during reset
		VGA_HSYNCH 				<= 1'b1;
		VGA_VSYNCH 				<= 1'b1;
		VGA_COMP_SYNCH 		<= 1'b1;
		VGA_OUT_BLANK_Z 		<= 1'b0;
		VGA_OUT_RED[7:0]		<= 8'h00;
		VGA_OUT_GREEN[7:0]	<= 8'h00;
		VGA_OUT_BLUE[7:0]		<= 8'h00;
	end
	
	else if (blank) begin
		// output black during the blank signal
		VGA_HSYNCH	 			<= h_synch;
		VGA_VSYNCH 	 			<= v_synch;
		VGA_COMP_SYNCH 		<= 1'b0; // disable sync on green
		VGA_OUT_BLANK_Z 		<= !blank;
		VGA_OUT_RED[7:0]		<= 8'h00;
		VGA_OUT_GREEN[7:0]	<= 8'h00;
		VGA_OUT_BLUE[7:0]		<= 8'h00;
	end
	
	else begin
		// output color data otherwise
		VGA_HSYNCH	 			<= h_synch;
		VGA_VSYNCH 	 			<= v_synch;
		VGA_COMP_SYNCH 		<= 1'b0; // disable sync on green
		VGA_OUT_BLANK_Z 		<= !blank;
		VGA_OUT_RED[7:0]		<= vga_red_data[7:0];
		VGA_OUT_GREEN[7:0]	<= vga_green_data[7:0];
		VGA_OUT_BLUE[7:0]		<= vga_blue_data[7:0];
	end
end 

OFDDRTRSE  PIXEL_CLOCK_OUT(
.O   (VGA_OUT_PIXEL_CLOCK),
.C0  (pixel_clock),
.C1  (!pixel_clock),
.CE  (high),
.D0  (low),
.D1  (high),
.R   (reset),
.S   (low),
.T   (low));

endmodule // VIDEO_OUT