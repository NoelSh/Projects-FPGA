/*--------------------------------------------------------------------------------
-- Company: University of Leeds
-- Engineer: 			Noel Shimali
-- Create Date:    	02/2017 
-- Project Name: 	 	N-bit Multiplier
-- Target Devices: 	Cyclone V
-- Description: 	N-bit multiplier created in Verilog, takes two binary numbers
--						which can bit N-bit in size and multiplies then to give a result,
--						the product can be displayed on seven segment displays.						
-- Revision: 1.0
-- Additional Comments: When testing on hardware read the parameter comments for
								NbitMultiplier module those are the only two values that
								can be changed as desired. If seven segment display output
								is not required use MultiplierNbit module instead
--------------------------------------------------------------------------------*/

module NbitMultiplier#(
	parameter N = 5, //Any value >= 1, for hardware testing max value at N == 5
	parameter DISPLAY_WIDTH = 3 // N == 1 or 2, Width = 1 -- N == 3, Width = 2 -- N > 3, Width = 3
)(
	input	[N-1:0] m,	//First binary input for multiplier
	input [N-1:0] q,	//Second binary input for multiplier
	input bcdEnable,	//Button to change display format to Decimal or Hexadecimal
	output [(7*DISPLAY_WIDTH)-1:0] displaySeg,	//Seven segment display output
	output bcdLed		//LED to confirm bcdEnable input has been read properly
);
	
	wire [(N*2)-1:0] P; //Wire to connect multipliers output to display
	reg bcd_toggle = 1'b0; //Stores state to display output in Hex or Decimal
	
	//Instantiate the multiplier which takes bit length (N) as a parameter
	MultiplierNbit #(
		.N(N)		//Input bit length
	) multiplier(
		.m(m),	//Input 1
		.q(q),	//Input 2
		.P(P)		//Output result
	);
	
	//Instantiate the Display that takes segment width (DISPLAY_WIDTH) as a parameter
	SevenSegDisplay #(
		.WIDTH(DISPLAY_WIDTH) //KEEP WIDTH AT 1, 2 or 3!
	) display(
		.bcdEnable(bcd_toggle),	//Send bcd flag to display module
		.valueNumber(P),	//binary result from multiplier to get sent for display conversion
		.displayNumber(displaySeg)	//Converted output from multiplier value to a segment digit value
	);
	
	//If button is pressed toggle between Hexadecimal or Decimal output
	always @(posedge bcdEnable) begin
		bcd_toggle = ~bcd_toggle;	//Invert between the two states (Hex/Decimal)
	end
	//Verify the output format has been changed with an on board LED
	assign bcdLed = bcd_toggle;
	
endmodule


