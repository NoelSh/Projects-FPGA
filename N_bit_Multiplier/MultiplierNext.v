/*This is the multiplier element that is used in all rows but the first for the N-bit multiplier*/

module MultiplierNext (
	input m,		 //Input 1.1
	input sumin, //Input 1.2 (uses sum from previous row)
	input q,		 //Input 2
	input cin,	 //Carry in
	output sum,	 //Multiplier row element result
	output cout, //Carry out
	output mout  //m passthrough
);
	
	//Wire used to comine module inputs to full adder
	wire d0;
	
	//Full adder used in module
	FullAdder FullAdder_inst ( 
		.cin(cin), 
		.a(d0),
		.b(sumin),
		.sum(sum),
		.cout(cout)
	); 

	assign d0 = m & q; //First input to full adder, second input is directly connected from module input port
	assign mout = m;	//m passthrough

endmodule