module background_gen (
		input 				clock,
		input 	[7:0]		xAddLCD,
		input		[8:0] 	yAddLCD,
		output	[15:0]	pixelData
		
);

wire [16:0] address;

backgound_gen (
	.address(address),
	.clock(clock),
	.q(pixelData)
);

assign address = (319 - yAddLCD) + 320 * xAddLCD;

endmodule 