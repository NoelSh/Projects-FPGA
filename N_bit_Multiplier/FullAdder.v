module FullAdder(
	input a,		//First input to full adder
	input b,		//Second input to full adder
	input cin,	//Carry in used for chaining full adders together
	output sum, //Same digit position result for a + b input
	output cout //Carry out used for chaining full adders together this is the MSB of result concatanated with sum on the MSB fulladder
);

	assign sum = (a^b)^cin;
	assign cout = ((a^b)&cin)|(a&b);

endmodule