/*To simplify top level instantiation multiplier rows can be called instead of individual elements,
this module is for the first row */

module MultiplierFirstRow #(
	parameter WIDTH = 4
)(
	input [WIDTH-1:0] m,	    //Input 1 (length based off row width)
	input [1:0] q,				 //Input 2 (length always 2 bits for first row)
	output [WIDTH-1:0] mout, //m passthrough
	output [WIDTH-1:0] sum,  //Sum for all elements of the first row
	output cout					 //Carry out of last element of row (Carry in of first elemment set to '0')
);
	
	//Wire for internal carry in/out connections
	wire carry[WIDTH-2:0];

	genvar i; //Generate variable to be used in the for loop 
	generate 
		//Instantiate "WIDTH" modules (row width)
		for (i = 0; i < WIDTH; i = i + 1) begin : loop_name       
			if(i==0)begin //First Element of the row
				MultiplierFirst MultiplierFirst_inst (
					.m(m[1:0]),
					.q(q),
					.cin(1'b0),	//First element carry in set to '0'
					.sum(sum[0]),
					.cout(carry[0]),
					.mout(mout[0])
				);
			end else if (i < WIDTH-1)begin // Middle elements of the row
				MultiplierFirst MultiplierFirst_inst (
					.m(m[i+1:i]),
					.q(q),
					.cin(carry[i-1]),
					.sum(sum[i]),
					.cout(carry[i]),
					.mout(mout[i])
				);
			end else begin //Last element of the row
				MultiplierFirst MultiplierFirst_inst (
					.m({1'b0, m[WIDTH-1]}),
					.q(q),
					.cin(carry[i-1]),
					.sum(sum[WIDTH-1]),
					.cout(cout),
					.mout(mout[WIDTH-1])
				);
			end
		end 
	endgenerate 

endmodule







