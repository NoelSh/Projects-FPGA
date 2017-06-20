module example_x_figure_generator #(
	parameter SCREEN_WIDTH = 240,
	parameter SCREEN_HEIGHT = 320,
	parameter BITS_SCREEN_WIDTH = 8,
	parameter BITS_SCREEN_HEIGHT = 9
)(
	input 									clock,
	input  [BITS_SCREEN_WIDTH-1:0]  	xAddLCD,
	input  [BITS_SCREEN_HEIGHT-1:0] 	yAddLCD, 
	input  [8:0] 							x_status,
	output 									x_enable
);

	crossBitmapGenerator #(	
		.WIDTH(SCREEN_WIDTH),
		.HEIGHT(SCREEN_HEIGHT),
		.BITS_WIDTH(BITS_SCREEN_WIDTH),
		.BITS_HEIGHT(BITS_SCREEN_HEIGHT),
		.BITMAP_WIDTH(78),
		.BITMAP_HEIGHT(78)
	)crossBitmapGenerator(
		.clock(clock),
		.enable(enable),
		.xAddLCD(xAddLCD),
		.yAddLCD(yAddLCD),
		.xAddBitmap(xPosBitmap),
		.yAddBitmap(yPosBitmap), 
		.bitmapPixEN(x_enable)
	);

	wire [BITS_SCREEN_WIDTH-1:0]  xPosBitmap;
	wire [BITS_SCREEN_HEIGHT-1:0] yPosBitmap;

	wire enable;
	wire enable_0;
	wire enable_1;
	wire enable_2;
	wire enable_3;
	wire enable_4;
	wire enable_5;
	wire enable_6;
	wire enable_7;
	wire enable_8;
	
	assign enable_0 = (((x_status[0] == 1) ? 1'b1 : 1'b0) && xAddLCD > 0 	&& xAddLCD < 78	&& yAddLCD > 201 	&& yAddLCD < 279);
	assign enable_1 = (((x_status[1] == 1) ? 1'b1 : 1'b0) && xAddLCD > 0		&& xAddLCD < 78	&& yAddLCD > 121 	&& yAddLCD < 199);
	assign enable_2 = (((x_status[2] == 1) ? 1'b1 : 1'b0) && xAddLCD > 0		&& xAddLCD < 78	&& yAddLCD > 41 	&& yAddLCD < 119);
	assign enable_3 = (((x_status[3] == 1) ? 1'b1 : 1'b0) && xAddLCD > 80	&& xAddLCD < 158	&& yAddLCD > 201 	&& yAddLCD < 279);
	assign enable_4 = (((x_status[4] == 1) ? 1'b1 : 1'b0) && xAddLCD > 80	&& xAddLCD < 158	&& yAddLCD > 121 	&& yAddLCD < 199);
	assign enable_5 = (((x_status[5] == 1) ? 1'b1 : 1'b0) && xAddLCD > 80	&& xAddLCD < 158	&& yAddLCD > 41 	&& yAddLCD < 119);
	assign enable_6 = (((x_status[6] == 1) ? 1'b1 : 1'b0) && xAddLCD > 160	&& xAddLCD < 238	&& yAddLCD > 201 	&& yAddLCD < 279);
	assign enable_7 = (((x_status[7] == 1) ? 1'b1 : 1'b0) && xAddLCD > 160	&& xAddLCD < 238	&& yAddLCD > 121 	&& yAddLCD < 199);
	assign enable_8 = (((x_status[8] == 1) ? 1'b1 : 1'b0) && xAddLCD > 160	&& xAddLCD < 238	&& yAddLCD > 41 	&& yAddLCD < 119);

	assign xPosBitmap = (xAddLCD > 0 && xAddLCD < 78) ? 0 : (xAddLCD > 80	&& xAddLCD < 158) ? 81 : (xAddLCD > 160	&& xAddLCD < 238) ? 161 : 600;
	assign yPosBitmap = (yAddLCD > 41 && yAddLCD < 119) ? 119 : (yAddLCD > 121	&& yAddLCD < 199) ? 199 : (yAddLCD > 201	&& yAddLCD < 279) ? 279 : 600;
	assign enable = enable_0 || enable_1 || enable_2 || enable_3 || enable_4 || enable_5 || enable_6 || enable_7 || enable_8;


endmodule 
