module COLOR_BARS
(
pixel_clock,
reset,
finish,
pixel_count0,
line_count0,
lives,
score,
bricki,
ballx,bally,
padwn,padup,
vga_red_data,
vga_green_data,
vga_blue_data
);

input				pixel_clock;
input				reset;
input [1:0]		finish;
input [10:0] 	pixel_count0;
input [9:0]		line_count0;
input [9:0] 	ballx;
input [8:0]		bally;
input [9:0] 	padwn;
input [9:0] 	padup;
input [39:0]	bricki;
input [2:0] lives;
input [6:0]		score;
reg [3:0]		r;
reg [6:0]		len;
reg [5:0]		br;
output [7:0]	vga_red_data;
output [7:0]	vga_green_data;
output [7:0]	vga_blue_data;

integer			scorefinal;
integer			finishfinal;
integer 			liveso;
integer			digit0;
integer			digit1;
initial digit0 <= 0;
initial digit1 <= 0;
reg [10:0]		pixel_count;
reg [9:0]		line_count;

// create a vertical gradient for each bar from the factor value to black
// Example: 255*(480 - 0)*17/8192 == 254; 255*(480 - 479)*17/8192 == 0

reg [7:0]		red_factor;
reg [7:0]		green_factor;
reg [7:0]		blue_factor;

//reg [1:0] digit;
reg [9:0] a[0:3];
reg [13:0] ssdisplay;
initial ssdisplay <= {0,0,0,0,0,0,0,0,0,0,0,0,0,0};

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

// directions: 2'b00 == hold, 2'b01 == increase, 2'b10 == decrease
integer i ; integer j ;
integer x ; integer y ;

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

always @ (posedge pixel_clock) begin
	a[0]=bricki[9:0];
	a[1]=bricki[19:10];
	a[2]=bricki[29:20];
	a[3]=bricki[39:30];
	scorefinal=score;
	liveso=lives;
	finishfinal=finish;
	if (scorefinal>39) begin
		digit1 = 4;
		digit0 = 0;
	end
	else if (scorefinal>29) begin
		digit1 = 3;
		digit0 = scorefinal-30;
	end
	else if (scorefinal>19) begin
		digit1 = 2;
		digit0 = scorefinal-20;
	end
	else if (scorefinal>9) begin
		digit1 = 1;
		digit0 = scorefinal-10;
	end
	else begin
		digit1 = 0;
		digit0 = scorefinal;
	end
	if (digit0==0) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 1;
		ssdisplay[9] = 1;
		ssdisplay[10] = 0;
		ssdisplay[11] = 1;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	else if (digit0==1) begin
		ssdisplay[7] = 0;
		ssdisplay[8] = 0;
		ssdisplay[9] = 1;
		ssdisplay[10] = 0;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 0;
	end
	else if (digit0==2) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 0;
		ssdisplay[9] = 1;
		ssdisplay[10] = 1;
		ssdisplay[11] = 1;
		ssdisplay[12] = 0;
		ssdisplay[13] = 1;
	end
	else if (digit0==3) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 0;
		ssdisplay[9] = 1;
		ssdisplay[10] = 1;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	else if (digit0==4) begin
		ssdisplay[7] = 0;
		ssdisplay[8] = 1;
		ssdisplay[9] = 1;
		ssdisplay[10] = 1;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 0;
	end
	else if (digit0==5) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 1;
		ssdisplay[9] = 0;
		ssdisplay[10] = 1;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	else if (digit0==6) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 1;
		ssdisplay[9] = 0;
		ssdisplay[10] = 1;
		ssdisplay[11] = 1;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	else if (digit0==7) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 0;
		ssdisplay[9] = 1;
		ssdisplay[10] = 0;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 0;
	end
	else if (digit0==8) begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 1;
		ssdisplay[9] = 1;
		ssdisplay[10] = 1;
		ssdisplay[11] = 1;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	else begin
		ssdisplay[7] = 1;
		ssdisplay[8] = 1;
		ssdisplay[9] = 1;
		ssdisplay[10] = 1;
		ssdisplay[11] = 0;
		ssdisplay[12] = 1;
		ssdisplay[13] = 1;
	end
	if (digit1==0) begin
		ssdisplay[0] = 1;
		ssdisplay[1] = 1;
		ssdisplay[2] = 1;
		ssdisplay[3] = 0;
		ssdisplay[4] = 1;
		ssdisplay[5] = 1;
		ssdisplay[6] = 1;
	end
	else if (digit1==1) begin
		ssdisplay[0] = 0;
		ssdisplay[1] = 0;
		ssdisplay[2] = 1;
		ssdisplay[3] = 0;
		ssdisplay[4] = 0;
		ssdisplay[5] = 1;
		ssdisplay[6] = 0;
	end
	else if (digit1==2) begin
		ssdisplay[0] = 1;
		ssdisplay[1] = 0;
		ssdisplay[2] = 1;
		ssdisplay[3] = 1;
		ssdisplay[4] = 1;
		ssdisplay[5] = 0;
		ssdisplay[6] = 1;
	end
	else if (digit1==3) begin
		ssdisplay[0] = 1;
		ssdisplay[1] = 0;
		ssdisplay[2] = 1;
		ssdisplay[3] = 1;
		ssdisplay[4] = 0;
		ssdisplay[5] = 1;
		ssdisplay[6] = 1;
	end
	else begin
		ssdisplay[0] = 0;
		ssdisplay[1] = 1;
		ssdisplay[2] = 1;
		ssdisplay[3] = 1;
		ssdisplay[4] = 0;
		ssdisplay[5] = 1;
		ssdisplay[6] = 0;
	end
end

// select the color based on the horizontal position
always @ (posedge pixel_clock) begin
	br<=6'h0a;
	len<=7'h30;
	r<=4'ha;
	//ball
	if (finishfinal==0) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
		/*if (ssdisplay[0] == 1) begin
			if (line_count >= 160 & line_count <= 170 & pixel_count >= 235 & pixel_count <= 310) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[1] == 1) begin
			if (line_count >= 165 & line_count <= 240 & pixel_count >= 230 & pixel_count <= 240) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[2] == 1) begin
			if (line_count >= 165 & line_count <= 240 & pixel_count >= 305 & pixel_count <= 315) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[3] == 1) begin
			if (line_count >= 235 & line_count <= 245 & pixel_count >= 235 & pixel_count <= 310) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[4] == 1) begin
			if (line_count >= 240 & line_count <= 315 & pixel_count >= 230 & pixel_count <= 240) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[5] == 1) begin
			if (line_count >= 240 & line_count <= 315 & pixel_count >= 305 & pixel_count <= 315) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[6] == 1) begin
			if (line_count >= 310 & line_count <= 320 & pixel_count >= 235 & pixel_count <= 310) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[7] == 1) begin
			if (line_count >= 160 & line_count <= 170 & pixel_count >= 330 & pixel_count <= 415) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[8] == 1) begin
			if (line_count >= 165 & line_count <= 240 & pixel_count >= 325 & pixel_count <= 335) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[9] == 1) begin
			if (line_count >= 165 & line_count <= 240 & pixel_count >= 410 & pixel_count <= 420) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[10] == 1) begin
			if (line_count >= 235 & line_count <= 245 & pixel_count >= 330 & pixel_count <= 415) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[11] == 1) begin
			if (line_count >= 240 & line_count <= 315 & pixel_count >= 325 & pixel_count <= 335) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[12] == 1) begin
			if (line_count >= 240 & line_count <= 315 & pixel_count >= 410 & pixel_count <= 420) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[13] == 1) begin
			if (line_count >= 310 & line_count <= 320 & pixel_count >= 330 & pixel_count <= 415) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end*/
	end
	else if ((pixel_count-ballx-10)*(pixel_count-ballx-10)+(line_count+bally-450)*(line_count+bally-450) < 5 * 5) begin											//red
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
	//padwn
	else if ((pixel_count > padwn+10) & (pixel_count < 10+padwn+80)& line_count>450 - br & line_count<450) begin	//green
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	else if ((pixel_count >= 130) & (pixel_count <= 140) & line_count>=457 & line_count<=472) begin
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
		if (ssdisplay[0] == 1) begin
			if (line_count >= 459 & line_count <= 460 & pixel_count >= 133 & pixel_count <= 138) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[1] == 1) begin
			if (line_count >= 460 & line_count <= 464 & pixel_count >= 132 & pixel_count <= 133) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[2] == 1) begin
			if (line_count >= 460 & line_count <= 464 & pixel_count >= 138 & pixel_count <= 139) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[3] == 1) begin
			if (line_count >= 464 & line_count <= 465 & pixel_count >= 133 & pixel_count <= 138) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[4] == 1) begin
			if (line_count >= 465 & line_count <= 469 & pixel_count >= 132 & pixel_count <= 133) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[5] == 1) begin
			if (line_count >= 465 & line_count <= 469 & pixel_count >= 138 & pixel_count <= 139) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[6] == 1) begin
			if (line_count >= 469 & line_count <= 470 & pixel_count >= 133 & pixel_count <= 138) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
	end
	else if ((pixel_count >= 140) & (pixel_count <= 150) & line_count>=457 & line_count<=472) begin
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
		if (ssdisplay[7] == 1) begin
			if (line_count >= 459 & line_count <= 460 & pixel_count >= 142 & pixel_count <= 147) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[8] == 1) begin
			if (line_count >= 460 & line_count <= 464 & pixel_count >= 141 & pixel_count <= 142) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[9] == 1) begin
			if (line_count >= 460 & line_count <= 464 & pixel_count >= 147 & pixel_count <= 148) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[10] == 1) begin
			if (line_count >= 464 & line_count <= 465 & pixel_count >= 142 & pixel_count <= 147) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[11] == 1) begin
			if (line_count >= 465 & line_count <= 469 & pixel_count >= 141 & pixel_count <= 142) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[12] == 1) begin
			if (line_count >= 465 & line_count <= 469 & pixel_count >= 147 & pixel_count <= 148) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
		if (ssdisplay[13] == 1) begin
			if (line_count >= 469 & line_count <= 470 & pixel_count >= 142 & pixel_count <= 147) begin
				red_factor[7:0]	<= 8'h00;
				green_factor[7:0]	<= 8'hFF;
				blue_factor[7:0]	<= 8'hFF;
			end
		end
	end
	else if ((line_count>=460) & (line_count<=470) & (pixel_count>550) & pixel_count<(550+liveso*12)) begin
			red_factor[7:0]	<= 8'hFF;
			green_factor[7:0]	<= 8'h00;
			blue_factor[7:0]	<= 8'h00;
	end
	else if ((line_count>=460) & (line_count<=470) & (pixel_count>=(550+liveso*12)) & pixel_count<=586) begin
			red_factor[7:0]	<= 8'h00;
			green_factor[7:0]	<= 8'h00;
			blue_factor[7:0]	<= 8'h00;
	end
	else if ((pixel_count>0) & (pixel_count<10) & (line_count>0) & (line_count<480)) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	else if ((pixel_count>630) & (pixel_count<640) & (line_count>0) & (line_count<480)) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	else if ((pixel_count>0) & (pixel_count<640) & (line_count>0) & (line_count<10)) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	else if ((pixel_count>0) & (pixel_count<640) & (line_count>450) & (line_count<480)) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'h00;
	end
	/*else if ((pixel_count>10) & (pixel_count<630) & (line_count>10) & (line_count<70)) begin
		red_factor[7:0]		<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
		for (i=1; i<=4; i=i+1) begin
			for (j=1; j<=10; j=j+1) begin
				if ((pixel_count>10+(62*(j-1))) & (pixel_count<10+(62*j)) & (line_count>10+(15*(i-1))) & (line_count<10+(15*i))) begin
					if (a[i][j] == 1) begin
						red_factor[7:0]		<= 8'hFF;
						green_factor[7:0]	<= 8'hFF;
						blue_factor[7:0]	<= 8'hFF;
					end
				end
			end
		end
	end*/
	else
	if ((pixel_count>10) & (pixel_count<72) & (line_count>10) & (line_count<25)) begin
	if (a[0][0]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else
	if ((pixel_count>72) & (pixel_count<134) & (line_count>10) & (line_count<25)) begin
	 if (a[0][1]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>134) & (pixel_count<196) & (line_count>10) & (line_count<25)) begin
	if (a[0][2]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
end
else 
	if ((pixel_count>196) & (pixel_count<258) & (line_count>10) & (line_count<25)) begin
	if (a[0][3]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>258) & (pixel_count<320) & (line_count>10) & (line_count<25)) begin
	if (a[0][4]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>320) & (pixel_count<382) & (line_count>10) & (line_count<25)) begin
	if (a[0][5]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>382) & (pixel_count<444) & (line_count>10) & (line_count<25)) begin
	if (a[0][6]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>444) & (pixel_count<506) & (line_count>10) & (line_count<25)) begin
	if (a[0][7]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>506) & (pixel_count<568) & (line_count>10) & (line_count<25)) begin
	if (a[0][8]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>568) & (pixel_count<630) & (line_count>10) & (line_count<25)) begin
	if (a[0][9]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>10) & (pixel_count<72) & (line_count>25) & (line_count<40)) begin
	if (a[1][0]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>72) & (pixel_count<134) & (line_count>25) & (line_count<40)) begin
	if (a[1][1]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>134) & (pixel_count<196) & (line_count>25) & (line_count<40)) begin
	if (a[1][2]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>196) & (pixel_count<258) & (line_count>25) & (line_count<40)) begin
	if (a[1][3]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>258) & (pixel_count<320) & (line_count>25) & (line_count<40)) begin
	if (a[1][4]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>320) & (pixel_count<382) & (line_count>25) & (line_count<40)) begin
	if (a[1][5]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>382) & (pixel_count<444) & (line_count>25) & (line_count<40)) begin
	if (a[1][6]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>444) & (pixel_count<506) & (line_count>25) & (line_count<40)) begin
	if (a[1][7]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>506) & (pixel_count<568) & (line_count>25) & (line_count<40)) begin
	if (a[1][8]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>568) & (pixel_count<630) & (line_count>25) & (line_count<40)) begin
	if (a[1][9]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>10) & (pixel_count<72) & (line_count>40) & (line_count<55)) begin
	if (a[2][0]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>72) & (pixel_count<134) & (line_count>40) & (line_count<55)) begin
	if (a[2][1]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>134) & (pixel_count<196) & (line_count>40) & (line_count<55)) begin
	if (a[2][2]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>196) & (pixel_count<258) & (line_count>40) & (line_count<55)) begin
	if (a[2][3]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>258) & (pixel_count<320) & (line_count>40) & (line_count<55)) begin
	if (a[2][4]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>320) & (pixel_count<382) & (line_count>40) & (line_count<55)) begin
	if (a[2][5]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>382) & (pixel_count<444) & (line_count>40) & (line_count<55)) begin
	if (a[2][6]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>444) & (pixel_count<506) & (line_count>40) & (line_count<55)) begin
	if (a[2][7]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>506) & (pixel_count<568) & (line_count>40) & (line_count<55)) begin
	if (a[2][8]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>568) & (pixel_count<630) & (line_count>40) & (line_count<55)) begin
	if (a[2][9]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>10) & (pixel_count<72) & (line_count>55) & (line_count<70)) begin
	if (a[3][0]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>72) & (pixel_count<134) & (line_count>55) & (line_count<70)) begin
	if (a[3][1]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>134) & (pixel_count<196) & (line_count>55) & (line_count<70)) begin
	if (a[3][2]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>196) & (pixel_count<258) & (line_count>55) & (line_count<70)) begin
	if (a[3][3]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>258) & (pixel_count<320) & (line_count>55) & (line_count<70)) begin
	if (a[3][4]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>320) & (pixel_count<382) & (line_count>55) & (line_count<70)) begin
	if (a[3][5]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>382) & (pixel_count<444) & (line_count>55) & (line_count<70)) begin
	if (a[3][6]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>444) & (pixel_count<506) & (line_count>55) & (line_count<70)) begin
	if (a[3][7]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>506) & (pixel_count<568) & (line_count>55) & (line_count<70)) begin
	if (a[3][8]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end
else 
	if ((pixel_count>568) & (pixel_count<630) & (line_count>55) & (line_count<70)) begin
	if (a[3][9]==1) begin
		red_factor[7:0]	<= 8'hFF;
		green_factor[7:0]	<= 8'hFF;
		blue_factor[7:0]	<= 8'hFF;
	end
	else begin																	// black
		red_factor[7:0]	<= 8'h00;
		green_factor[7:0]	<= 8'h00;
		blue_factor[7:0]	<= 8'h00;
	end
end

	//background
	//else 
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