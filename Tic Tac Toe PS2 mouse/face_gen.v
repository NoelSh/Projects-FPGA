module face_gen (
		input 			clock,
		input 	[7:0]	xAddLCD,
		input		[8:0] yAddLCD,
		output	[15:0]pixelData
		
);
wire [15:0] address;
wire [15:0] pixelData1;

welcomfaceROM (
	.address(address),
	.clock(clock),
	.q(pixelData1)
);	

assign pixelData = (yAddLCD<=289 && yAddLCD >=30 && xAddLCD>=0 && xAddLCD <=239) ? pixelData1 : 16'b0000000000000000;
assign address = (289 - yAddLCD) + 260 * ( xAddLCD -0 );

endmodule 