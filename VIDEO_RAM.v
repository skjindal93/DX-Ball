module VIDEO_RAM
(
clka,		// write clock
wea,		// write enable
addra,	// write address
dia,		// write data

clkb,		// read clock
addrb,	// read address
dob		// read data
);

input  clka;
input  wea;
input  [10:0] addra;
input  [7:0] dia;

input  clkb;
input  [10:0] addrb;
output [7:0] dob;

reg    [7:0] ram [2047:0];
reg    [10:0] read_addra;
reg    [10:0] read_addrb;

always @(posedge clka) begin
	if (wea)
		ram[addra] <= dia;
	read_addra <= addra;
end

always @(posedge clkb) begin
	read_addrb <= addrb;
end

assign dob = ram[read_addrb];

// initialize the RAM with zeros
integer index;
initial begin
	for (index = 0; index <= 2047; index = index + 1) begin
		ram[index] = 8'h00;
	end                     
end

endmodule //VIDEO_RAM