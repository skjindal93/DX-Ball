module COLOR_BARS
(
pixel_clock,
reset,
pixel_count0,
line_count0,
ballx,bally,
padwn,padup,

vga_red_data,
vga_green_data,
vga_blue_data
);

input				pixel_clock;
input				reset;
input [10:0] 	pixel_count0;
input [9:0]		line_count0;
input [9:0] 	ballx;
input [8:0]		bally;
input [9:0] 	padwn;
input [9:0] 	padup;
reg [3:0]		r;
reg [6:0]		len;
reg [5:0]		br;
output [7:0]	vga_red_data;
output [7:0]	vga_green_data;
output [7:0]	vga_blue_data;


reg [10:0]		pixel_count;
reg [9:0]		line_count;

// create a vertical gradient for each bar from the factor value to black
// Example: 255*(480 - 0)*17/8192 == 254; 255*(480 - 479)*17/8192 == 0

reg [7:0]		red_factor;
reg [7:0]		green_factor;
reg [7:0]		blue_factor;
/*
wire [13:0] 	scaled_count	= (9'd480 - line_count[8:0]) * 5'd17;

wire [21:0]		red_scaled		= scaled_count * red_factor;
wire [21:0]		green_scaled	= scaled_count * green_factor;
wire [21:0]		blue_scaled		= scaled_count * blue_factor;
*/
// shift scaled results right by 13 (divide by 8192)
wire [7:0]		red_data			= red_factor[7:0];
wire [7:0]		green_data		= green_factor[7:0];
wire [7:0]		blue_data		= blue_factor[7:0];


// Create the color bars in memory, alternating memory locations every other
// line to allow for computation time.

// Only the least significant 10 bits are required out of the total 11 bits
// of pixel count, because active screen area has a maximum width of 1024.
// This configuration conveniently allows each video RAM color to fit into one
// block RAM. (A block RAM consists of 18,432 bits, and this configuration
// requires 8*2048 == 16,384 bits per color.) Note that there is not enough
// block RAM available to allow for all screen data to be stored at once.
// Doing so would require 8*1024*768*3 == 18,874,368 bits of RAM, while only
// 18,432*136 == 2,506,752 bits of block RAM are available on the XC2VP30.

// The remaining bits of pixel count are used to keep track of the front porch,
// synch, and back porch, which make up the blank period. It is OK that this
// module will output color data during the blank period, because the VIDEO_OUT
// module overrides the output of this module with zeros when the blank signal
// is high.
wire [10:0]		write_addr = {!line_count0[0], pixel_count0[9:0]};
wire [10:0]		read_addr = {line_count0[0], pixel_count0[9:0]};
wire				write_enable	= 1'b1; // write every clock posedge

reg [7:0] 		red_rainbow;
reg [7:0] 		green_rainbow;
reg [7:0] 		blue_rainbow;

// directions: 2'b00 == hold, 2'b01 == increase, 2'b10 == decrease
reg [1:0] 		red_direction;
reg [1:0] 		green_direction;
reg [1:0] 		blue_direction;

// compensate for the delay caused by displaying the previous line while
// calculating the current line by using a line counter that is one line
// ahead of the original line counter
always @ (posedge pixel_clock) begin
	if ((line_count0 == (`V_TOTAL - 2)) & (pixel_count0 == (`H_TOTAL - 3)))
		// last pixel in last line of frame, so reset line counter
		line_count <= 10'h000;
	
	else if (pixel_count0 == (`H_TOTAL - 3))
		// last pixel but not last line, so increment line counter
		line_count <= line_count + 1;
end

// compensate for putting the pixel_count generation and the code that
// checks it on the same clock edge
always @ (posedge pixel_clock) begin
	if ((pixel_count0 == (`H_TOTAL - 3)))
		// last pixel in last line of frame, so reset line counter
		pixel_count <= 10'h000;
	
	else
		// last pixel but not last line, so increment line counter
		pixel_count <= pixel_count + 1;
end

// cycle through all of the possible hues in a rainbow pattern
always @ (posedge pixel_clock) begin
	// start last color bar at pure red
	if (reset) begin
		red_rainbow <= 8'hFF;
		green_rainbow <= 8'h00;
		blue_rainbow <= 8'h00;
		red_direction <= 2'b00;
		green_direction <= 2'b01;
		blue_direction <= 2'b00;
	end
	else begin
		// on the first line that is past the active region displayed,
		// calculate the color for the last color bar
		if ((pixel_count == 0) & (line_count == 480)) begin
			if (red_direction[0]) begin
				if (red_rainbow == 8'hFF) begin
					red_direction <= 2'b00;
					blue_direction <= 2'b10;
				end
				else
					red_rainbow <= red_rainbow + 8'h01;
			end
			if (red_direction[1]) begin
				if (red_rainbow == 8'h00) begin
					red_direction <= 2'b00;
					blue_direction <= 2'b01;
				end
				else
					red_rainbow <= red_rainbow - 8'h01;
			end
			
			if (green_direction[0]) begin
				if (green_rainbow == 8'hFF) begin
					green_direction <= 2'b00;
					red_direction <= 2'b10;
				end
				else
					green_rainbow <= green_rainbow + 8'h01;
			end
			if (green_direction[1]) begin
				if (green_rainbow == 8'h00) begin
					green_direction <= 2'b00;
					red_direction <= 2'b01;
				end
				else
					green_rainbow <= green_rainbow - 8'h01;
			end
			
			if (blue_direction[0]) begin
				if (blue_rainbow == 8'hFF) begin
					blue_direction <= 2'b00;
					green_direction <= 2'b10;
				end
				else
					blue_rainbow <= blue_rainbow + 8'h01;
			end
			if (blue_direction[1]) begin
				if (blue_rainbow == 8'h00) begin
					blue_direction <= 2'b00;
					green_direction <= 2'b01;
				end
				else
					blue_rainbow <= blue_rainbow - 8'h01;
			end
		end
	end
end

// select the color based on the horizontal position
always @ (posedge pixel_clock) begin
	/*ballx<=10'h060;
	bally<=9'h060;
	padup<=10'h000;
	padwn<=10'h000;*/
	br<=6'h0a;
	len<=7'h30;
	r<=4'ha;
	
	//ball
	if ((pixel_count-ballx-50)*(pixel_count-ballx-50)+(line_count+bally-430)*(line_count+bally-430) < 10 * 10) begin											//red
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
	
	//padup
	else if ((pixel_count > padup+50) & (pixel_count < 50+padup+len)& line_count>30 & line_count<30+br) begin
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	//padwn
	else if ((pixel_count > padwn+50) & (pixel_count < 50+padwn+len)& line_count>430 - br & line_count<430) begin	//green
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	//lineup
	else if (line_count>40 & line_count<42 & pixel_count>50 & pixel_count<306) begin
		red_factor[7:0]	<=8'h00;
		green_factor[7:0]	<= 8'h09;
		blue_factor[7:0]	<= 8'hFF;
	end
	//linedwn
	else if (line_count>418 & line_count<420 & pixel_count>50 & pixel_count<306) begin
		red_factor[7:0]	<=8'h00;
		green_factor[7:0]	<= 8'h09;
		blue_factor[7:0]	<= 8'hFF;
	end
	//background
	else if (pixel_count<50 | pixel_count>306 | line_count<30 | line_count>430) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
//	else if ((pixel_count > 240) & (pixel_count < 319)) begin	//cyan
//		red_factor[7:0]	<= 8'h00;
//		green_factor[7:0]	<= 8'hFF;
//		blue_factor[7:0]	<= 8'hFF;
//	end
//	else if ((pixel_count > 320) & (pixel_count < 399)) begin	//blue
//		red_factor[7:0]	<= 8'h00;
//		green_factor[7:0]	<= 8'h00;
//		blue_factor[7:0]	<= 8'hFF;
//	end
//	else if ((pixel_count > 400) & (pixel_count < 479)) begin	//magenta
//		red_factor[7:0]	<= 8'hFF;
//		green_factor[7:0]	<= 8'h00;
//		blue_factor[7:0]	<= 8'hFF;
//	end
//	else if ((pixel_count > 480) & (pixel_count < 559)) begin	//white
	//	red_factor[7:0]	<= 8'hFF;
	//	green_factor[7:0]	<= 8'hFF;
	//	blue_factor[7:0]	<= 8'hFF;
//	end
//	else if (pixel_count > 560) begin									//rainbow pattern
//		red_factor[7:0]	<= red_rainbow;
//		green_factor[7:0]	<= green_rainbow;
//		blue_factor[7:0]	<= blue_rainbow;
//	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end

// Instantiate the video RAMs

VIDEO_RAM RED_RAM
(
pixel_clock,		// write clock
write_enable,		// write eanble
write_addr,			// write address
red_data,			// write data

pixel_clock,		// read clock
read_addr,			// read address
vga_red_data		// read data
);

VIDEO_RAM GREEN_RAM
(
pixel_clock,		// write clock
write_enable,		// write eanble
write_addr,			// write address
green_data,			// write data

pixel_clock,		// read clock
read_addr,			// read address
vga_green_data		// read data
);

VIDEO_RAM BLUE_RAM
(
pixel_clock,		// write clock
write_enable,		// write enable
write_addr,			// write address
blue_data,			// write data

pixel_clock,		// read clock
read_addr,			// read address
vga_blue_data		// read data
);

endmodule //COLOR_BARS