`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:16 04/19/2013 
// Design Name: 
// Module Name:    brick 
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
module brick();
task makebrick;
input [7:0] x;
input [7:0] y;
input state;
begin
	if ((pixel_count>x) & (pixel_count<x+62) & (line_count>y) & (line_count<y+15)) begin
		if (state = 1) begin
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
endtask
endmodule
