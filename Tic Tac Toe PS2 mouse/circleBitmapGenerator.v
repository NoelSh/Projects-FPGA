module circleBitmapGenerator #(	
	parameter WIDTH = 240,
	parameter HEIGHT = 320,
	parameter BITS_WIDTH = 8,
	parameter BITS_HEIGHT = 9,
	parameter BITMAP_WIDTH = 78,
	parameter BITMAP_HEIGHT = 78
)(
	input 								  clock,
	input									  enable,
	input  [BITS_WIDTH-1:0] 		  xAddLCD,
	input  [BITS_HEIGHT-1:0] 		  yAddLCD,
	input  [BITS_WIDTH-1:0] 		  xAddBitmap,
	input  [BITS_HEIGHT-1:0] 		  yAddBitmap, 
	output 								  bitmapPixEN
);

	wire [6:0] bitmapAddress;
	wire [77:0] bitmapOutput;
	wire [6:0] bitmapPosition;
	wire pixelOutput;

	circleROM circleBitmapROM (
		.address(bitmapAddress),
		.clock(clock),
		.q(bitmapOutput)
	);	

	assign areaCheck = ((yAddLCD <= yAddBitmap) && (yAddLCD >= (yAddBitmap - BITMAP_WIDTH)) && (xAddLCD >= xAddBitmap) && (xAddLCD < (xAddBitmap + BITMAP_HEIGHT))) ? 1'b1 : 1'b0;
	assign bitmapPosition = xAddLCD - xAddBitmap;
	assign bitmapAddress = yAddBitmap - yAddLCD;
	assign pixelOutput = bitmapOutput[bitmapPosition];
	assign bitmapPixEN = enable ? ((areaCheck) ?  pixelOutput : 1'b0) : 1'b0;

endmodule
