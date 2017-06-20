/*Noel Shimali

*/

module textGenerator #(	
	parameter WIDTH = 240,
	parameter HEIGHT = 320,
	parameter BITS_WIDTH = 8,
	parameter BITS_HEIGHT = 9,
	parameter FONT_WIDTH = 5,
	parameter FONT_HEIGHT = 7,
	parameter FONT_SPACE = 2,
	parameter MAX_TEXT_WIDTH = 20
)(
	input 								  clock,
	input									  enable,
	input  [BITS_WIDTH-1:0] 		  xAddLCD,
	input  [BITS_HEIGHT-1:0] 		  yAddLCD,
	input  [BITS_WIDTH-1:0] 		  xAddText,
	input  [BITS_HEIGHT-1:0] 		  yAddText, 
	input	 [(MAX_TEXT_WIDTH*8)-1:0] textString,
	input	 [5:0]						  stringLength, //fixed ABSOLUTE MAX = 63
	output 								  textPixEN
);


wire [7:0] fontValue;
wire  [8:0] fontAddress;
wire [7:0] fontOutput;
wire [BITS_HEIGHT-1:0] textAddEnd;
wire [5:0] characterIndex;
wire [5:0] characterPos;
wire [4:0] fontOffset;
wire textOutput;
wire areaCheck;

fontROM fontBitmapROM (
	.address(fontAddress),
	.clock(clock),
	.q(fontOutput)
);	


assign textAddEnd = yAddText - (((stringLength*FONT_WIDTH)+((stringLength-1)*FONT_SPACE))-1);

//Check if in text area
assign areaCheck = ((yAddLCD <= yAddText) && (yAddLCD >= textAddEnd) && (xAddLCD >= xAddText) && (xAddLCD < (xAddText + FONT_HEIGHT))) ? 1'b1 : 1'b0;

assign characterIndex = (yAddLCD - textAddEnd) / (FONT_WIDTH + FONT_SPACE);

//Isolate character from string
assign characterPos = stringLength - characterIndex;

//Character ROM address offset
assign fontOffset = (characterPos > 0) ? (yAddText - yAddLCD) - ((characterPos - 1) * (FONT_WIDTH + FONT_SPACE))  : yAddText - yAddLCD;

//Convert ascii value of isolated character to ROM starting address
assign fontValue = textString[(((characterIndex + 1) * 8) - 1) -: 8] - 32;

assign fontAddress = (fontValue * FONT_WIDTH) + fontOffset;

//Signal to activate pixel if character is in it
assign textOutput = (fontOffset < FONT_WIDTH) ? fontOutput[xAddLCD-xAddText] : 1'b0; 

assign textPixEN = enable ? areaCheck ? textOutput : 1'b0 : 1'b0;

endmodule
