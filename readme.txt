VGA Demo for Digilent XUP-V2P
-------------------------------------------------------------------------------

Description:

This project demonstrates using the video DAC on the Digilent XUP-V2P to output 
bitmapped VGA from a Verilog design. In addition, it demonstrates how to set 
the user LEDs on the XUP-V2P.

The demo displays eight color bars which grade from full intensity to black 
vertically. The first seven color bars output red, yellow, green, cyan, blue, 
magenta, and white, respectively. The last color bar changes color in a 
continuous rainbow pattern. The demo outputs 640x480 at 60 Hz with 24-bit color 
by default, but the VGA timing code is designed to operate at up to 1024x768 at 
85 Hz.


Included Files:

main.bit - programming file synthesized and implemented using ISE 8.1.02i
VGA_demo.ise - ISE 8.1i project file
LEDs_VGA.ucf - constraints file
CLOCK_GEN.v - clock divider module
COLOR_BARS.v - bitmap color bar generator module
MAIN.v - primary module
SVGA_DEFINES.v - definition of the resolution and display rate parameters
SVGA_TIMING_GENERATION.v - SVGA timing signal generator module
VIDEO_OUT.v - video output mux module
VIDEO_RAM.v - instantiations of block RAM module


Authors:

This project is based on the XUP-V2P Built in Self Test source code provided by 
Xilinx, Inc. It has been modified by Eric Gallimore and Nathaniel Smith under 
the supervision of Professor Mark Chang at Franklin W. Olin College of 
Engineering (http://www.olin.edu/).

The Xilinx copyright claims for the code provided in the Built in Self Test are 
as follows:
	
	XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
	SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR
	XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION
	AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION
	OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS
	IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
	AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
	FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
	WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
	IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
	REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
	INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE.

	(c) Copyright 2004 Xilinx, Inc.
	All rights reserved.


Revisions:

1.0	(2006-02-24)
	VGA Demo for Digilent XUP-V2P initial version. 
	(c) Copyright 2006 Eric Gallimore and Nathaniel Smith
	All rights reserved.

0.0	(2004-08-12)
	XUP-V2P Built in Self Test
	(c) Copyright 2004 Xilinx, Inc.
	All rights reserved.