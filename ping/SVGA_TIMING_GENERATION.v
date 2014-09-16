`include "SVGA_DEFINES.v"

module SVGA_TIMING_GENERATION
(
pixel_clock,
reset,
h_synch_delay,
v_synch_delay,
comp_synch,
blank,
pixel_count,
line_count
);

input 			pixel_clock;		// pixel clock 
input 			reset;				// reset
output 			h_synch_delay;		// horizontal synch for VGA connector
output 			v_synch_delay;		// vertical synch for VGA connector
output 			comp_synch;			// composite synch for DAC
output			blank;				// composite blanking 
output [10:0]	pixel_count;		// counts the pixels in a line
output [9:0]	line_count;			// counts the display lines

reg [9:0]		line_count;			// counts the display lines
reg [10:0]		pixel_count;		// counts the pixels in a line	
reg				h_synch;				// horizontal synch
reg				v_synch;				// vertical synch
reg				h_synch_delay;		// h_synch delayed 2 clocks to line up with DAC pipeline
reg				v_synch_delay;		// v_synch delayed 2 clocks to line up with DAC pipeline
reg				h_synch_delay0;	// h_synch delayed 1 clock
reg				v_synch_delay0;	// v_synch delayed 1 clock

reg				h_c_synch;			// horizontal component of comp synch
reg				v_c_synch;			// vertical component of comp synch
reg				comp_synch;			// composite synch for DAC
reg				h_blank;				// horizontal blanking
reg				v_blank;				// vertical blanking
reg				blank;				// composite blanking


// CREATE THE HORIZONTAL LINE PIXEL COUNTER
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset set pixel counter to 0
		pixel_count <= 11'h000;
	
	else if (pixel_count == (`H_TOTAL - 1))
		// last pixel in the line, so reset pixel counter
		pixel_count <= 11'h000;
	
	else
		pixel_count <= pixel_count +1;		
end

// CREATE THE HORIZONTAL SYNCH PULSE
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove h_synch
		h_synch <= 1'b0;
	
	else if (pixel_count == (`H_ACTIVE + `H_FRONT_PORCH -1))
		// start of h_synch
		h_synch <= 1'b1;
	
	else if (pixel_count == (`H_TOTAL - `H_BACK_PORCH -1))
		// end of h_synch
		h_synch <= 1'b0;
end


// CREATE THE VERTICAL FRAME LINE COUNTER
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset set line counter to 0
		line_count <= 10'h000;
	
	else if ((line_count == (`V_TOTAL - 1))&& (pixel_count == (`H_TOTAL - 1)))
		// last pixel in last line of frame, so reset line counter
		line_count <= 10'h000;
	
	else if ((pixel_count == (`H_TOTAL - 1)))
		// last pixel but not last line, so increment line counter
		line_count <= line_count + 1;
end

// CREATE THE VERTICAL SYNCH PULSE
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove v_synch
		v_synch = 1'b0;

	else if ((line_count == (`V_ACTIVE + `V_FRONT_PORCH -1) &&
		   (pixel_count == `H_TOTAL - 1))) 
		// start of v_synch
		v_synch = 1'b1;
	
	else if ((line_count == (`V_TOTAL - `V_BACK_PORCH - 1))	&&
		   (pixel_count == (`H_TOTAL - 1)))
		// end of v_synch
		v_synch = 1'b0;
end

// ADD TWO PIPELINE DELAYS TO THE SYNCHs COMPENSATE FOR THE DAC PIPELINE DELAY
always @ (posedge pixel_clock or posedge reset) begin
	if (reset) begin					
		h_synch_delay0 <= 1'b0;
		v_synch_delay0 <= 1'b0;
		h_synch_delay  <= 1'b0;
		v_synch_delay  <= 1'b0;
	end
	
	else begin
		h_synch_delay0 <= h_synch;
		v_synch_delay0 <= v_synch;
		h_synch_delay  <= h_synch_delay0;
		v_synch_delay  <= v_synch_delay0;
	end
end



// CREATE THE HORIZONTAL BLANKING SIGNAL
// the "-2" is used instead of "-1" because of the extra register delay
// for the composite blanking signal 
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove the h_blank
		h_blank <= 1'b0;

	else if (pixel_count == (`H_ACTIVE -2)) 
		// start of HBI
		h_blank <= 1'b1;
	
	else if (pixel_count == (`H_TOTAL -2))
		// end of HBI
		h_blank <= 1'b0;
end


// CREATE THE VERTICAL BLANKING SIGNAL
// the "-2" is used instead of "-1"  in the horizontal factor because of the extra
// register delay for the composite blanking signal 
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove v_blank
		v_blank <= 1'b0;

	else if ((line_count == (`V_ACTIVE - 1) &&
		   (pixel_count == `H_TOTAL - 2))) 
		// start of VBI
		v_blank <= 1'b1;
	
	else if ((line_count == (`V_TOTAL - 1)) &&
		   (pixel_count == (`H_TOTAL - 2)))
		// end of VBI
		v_blank <= 1'b0;
end


// CREATE THE COMPOSITE BANKING SIGNAL
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove blank
		blank <= 1'b0;

	// blank during HBI or VBI
	else if (h_blank || v_blank)
		blank <= 1'b1;
		
	else
		// active video do not blank
		blank <= 1'b0;
end
		
// CREATE THE HORIZONTAL COMPONENT OF COMP SYNCH
// the "-2" is used instead of "-1" because of the extra register delay
// for the composite synch
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
		// on reset remove h_c_synch
		h_c_synch <= 1'b0;

	else if (pixel_count == (`H_ACTIVE + `H_FRONT_PORCH -2)) 
		// start of h_c_synch
		h_c_synch <= 1'b1;

	else if (pixel_count == (`H_TOTAL - `H_BACK_PORCH -2))
 	 	// end of h_c_synch
		h_c_synch <= 1'b0;
end

// CREATE THE VERTICAL COMPONENT OF COMP SYNCH 
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
 		// on reset remove v_c_synch
		v_c_synch <= 1'b0;

	else if ((line_count == (`V_ACTIVE + `V_FRONT_PORCH - 1) &&
		   (pixel_count == `H_TOTAL - 2))) 
	  	// start of v_c_synch
		v_c_synch <= 1'b1;
	
	else if ((line_count == (`V_TOTAL - `V_BACK_PORCH - 1))	&&
		   (pixel_count == (`H_TOTAL - 2)))
	 	// end of v_c_synch
		v_c_synch <= 1'b0;
end

// CREATE THE COMPOSITE SYNCH SIGNAL
always @ (posedge pixel_clock or posedge reset) begin
	if (reset)
 		// on reset remove comp_synch
		comp_synch <= 1'b0;

	else
		comp_synch <= (v_c_synch ^ h_c_synch);
end

endmodule //SVGA_TIMING_GENERATION



