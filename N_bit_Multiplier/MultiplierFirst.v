/*This is the multiplier element that is only used in the first row of the N-bit multiplier*/

module MultiplierFirst (
	input [1:0] m, //Input 1
	input [1:0] q, //Input 2
	input cin, 		//Carry in
	output sum, 	//Multiplier first row result
	output cout, 	//Carry out
	output mout 	//m passthrough
);

	//Wires used to comine module inputs to full adder
	wire d1;
	wire d0;
	
	//Full adder used in module
	FullAdder FullAdder_inst ( 
		.cin(cin), 
		.a(d0),
		.b(d1),
		.sum(sum),
		.cout(cout)
	); 

	assign d1 = m[1] & q[0]; //First input to full adder
	assign d0 = m[0] & q[1]; //Second input to full adder
	assign mout = m; //m passthrough

endmodule