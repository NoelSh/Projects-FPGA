module texttest(
	input clock,
	output [7:0] xAdd,
	output [8:0] yAdd,
	output textEnable
);

	localparam WIDTH = 240;
	localparam HEIGHT = 320;

	reg [7:0] xAddr;
	reg [8:0] yAddr;
	
	wire textEN;
		
	textGenerator #(	
		.WIDTH(WIDTH),
		.HEIGHT(HEIGHT),
		.BITS_WIDTH (8),
		.BITS_HEIGHT (9),
		.FONT_WIDTH (5),
		.FONT_HEIGHT (7),
		.FONT_SPACE (2),
		.MAX_TEXT_WIDTH (20)
	) textGen (
		.clock(clock),
		.xAddLCD(xAddr),
		.yAddLCD(yAddr),
		.xAddText(40),
		.yAddText(100), 
		.textString("hello"),
		.stringLength(5),
		.textPixEN(textEN)
	);

	// X Counter
	always @ (posedge clock) begin
		if (xAddr < (WIDTH-1)) begin
			xAddr <= xAddr + 8'd1;
		end else begin
			xAddr <= 8'b0;
		end
	end

	// Y Counter
	always @ (posedge clock) begin
		if (xAddr == (WIDTH-1)) begin
			if (yAddr < (HEIGHT-1)) begin
				yAddr <= yAddr + 9'd1;
			end else begin
				yAddr <= 9'b0;
			end
		end
	end
	
	assign xAdd = xAddr;
	assign yAdd = yAddr;
	assign textEnable = textEN;

endmodule

