module starship_gen (
		input 			clock,
		input 	[7:0]	xAddLCD,
		input		[8:0] yAddLCD,
		output	[15:0]pixelData
		
);
wire [14:0] address;
wire [15:0] pixelData1;

starship GEN (
	.address(address),
	.clock(clock),
	.q(pixelData1)
);	

assign pixelData = (yAddLCD<=242 && yAddLCD >=80 && xAddLCD>=54 && xAddLCD <=185) ? pixelData1 : 16'b0000000000000000;
assign address = (242 - yAddLCD) + 163 * ( xAddLCD -54 );

endmodule 