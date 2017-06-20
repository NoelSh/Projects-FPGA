/*To simplify top level instantiation multiplier rows can be called instead of individual elements,
this module is for all rows except the first row */

module MultiplierNextRow #(
	parameter WIDTH = 4
)(
	input [WIDTH-1:0] m,		 //Input 1.1 (length based off row width)
	input [WIDTH-1:0] sumin, //Input 1.2 (sum from previous row)
	input q,						 //Input 2 (length based off row width)
	output [WIDTH-1:0] sum,	 //Sum for all elements of the current row
	output cout,				 //Carry out of last element of row (Carry in of first elemment set to '0')
	output [WIDTH-1:0] mout	 //m passthrough
);

	//Wire for internal carry in/out connections
	wire carry[WIDTH-2:0];

	genvar i; //Generate variable to be used in the for loop 

	generate 
		//Instantiate "WIDTH" modules (row width)  
		for (i = 0; i < WIDTH; i = i + 1) begin : loop_name 
			if(i==0)begin //First element of the row
				MultiplierNext MultiplierNext_inst (
						.m(m[0]),
						.sumin(sumin[0]),
						.q(q),
						.cin(1'b0),
						.sum(sum[0]),
						.cout(carry[0]),
						.mout(mout[0])
				);
			end else if (i < WIDTH-1)begin //Middle elements of the row
				MultiplierNext MultiplierNext_inst (
						.m(m[i]),
						.sumin(sumin[i]),
						.q(q),
						.cin(carry[i-1]),
						.sum(sum[i]),
						.cout(carry[i]),
						.mout(mout[i])
				);
			end else begin //Last element of the row
				MultiplierNext MultiplierNext_inst (
						.m(m[WIDTH-1]),
						.sumin(sumin[WIDTH-1]),
						.q(q),
						.cin(carry[i-1]),
						.sum(sum[WIDTH-1]),
						.cout(cout),				//Carry out to be used in last bit final result or next row input 1.2 to last element
						.mout(mout[WIDTH-1])
				);
			end
		end 
	endgenerate 

endmodule







