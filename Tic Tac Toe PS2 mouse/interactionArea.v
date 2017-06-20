module interactionArea #(
	parameter SCREEN_WIDTH = 240,
	parameter SCREEN_HEIGHT = 320,
	parameter BITS_SCREEN_WIDTH = 8,
	parameter BITS_SCREEN_HEIGHT = 9

)(
	input  clock,
	input  enable,
	input  positionCheck,
	input  [BITS_SCREEN_WIDTH-1:0]  xAddLCD,
	input  [BITS_SCREEN_HEIGHT-1:0] yAddLCD, 
	input  [BITS_SCREEN_WIDTH-1:0]  xPos,
	input  [BITS_SCREEN_HEIGHT-1:0] yPos,
	input  [BITS_SCREEN_WIDTH-1:0]  xLength,
	input  [BITS_SCREEN_HEIGHT-1:0] yLength,
	input  [BITS_SCREEN_WIDTH-1:0]  xPosPointer,
	input  [BITS_SCREEN_HEIGHT-1:0] yPosPointer,
	output insideArea,
	output areaActive
);

reg areaActiveReg = 1'b0;
wire areaCheck;

always @(posedge clock) begin
	if (positionCheck == 1'b1) begin
		areaActiveReg = 1'b1;
	end else begin
		areaActiveReg = 1'b0;
	end
end

assign addressCheck = ((xAddLCD >= xPos) && (xAddLCD < (xPos + xLength)) && (yAddLCD <= yPos) && (yAddLCD > (yPos - yLength))) ? 1'b1 : 1'b0;
assign areaCheck = ((xPosPointer >= xPos) && (xPosPointer < (xPos + xLength)) && (yPosPointer <= yPos) && (yPosPointer > (yPos - yLength))) ? 1'b1 : 1'b0;

assign insideArea = enable ? (addressCheck ? 1'b1 : 1'b0) : 1'b0;
assign areaActive = enable ? (areaCheck ? areaActiveReg : 1'b0) : 1'b0;
							  
endmodule


