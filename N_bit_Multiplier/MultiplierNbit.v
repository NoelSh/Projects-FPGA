/* MultiplierNbit uses MultiplierFirstRow and MultiplierNextRow to build the multiplier. Row length and instances
creation numbers depend on the parameter N (input bit length). If N is at low values generation loops are not
used to reduce in overall complexity of Verilog code, if N is at 1 or 2 only simple combinational logic is used
without any instances from other modules needed. P[0] is independant of the size of N and always is m[0] & q[0]. */

module MultiplierNbit #(
	parameter N = 4		//Input bit length
)(
	input	[N-1:0] m,		//Input 1
	input [N-1:0] q,		//Input 2
	output [(N*2)-1:0] P	//Output result
);
	//Wires that are only used if N >= 3
	wire PPi[N-2:0];				 //Connects final carry out of previous row to the input of current row
	wire [N-1:0] mout[N-2:0];	 //Redundant connection wire only added for completion
	wire [N-2:0] sumAry[N-1:0]; //Connects sum of previous row to the input of current row

	genvar i; //Generate variable to be used in the for loop 
	generate
		if (N == 2) begin //Full adders not neccasary if N == 2
			assign P[1] = (m[0] & q[1]) ^ (m[1] & q[0]);
			assign P[2] = ((m[0] & q[1]) & (m[1] & q[0])) ^ (m[1] & q[1]);
			assign P[3] = ((m[0] & q[1]) & (m[1] & q[0])) & (m[1] & q[1]);
			
		end else if (N == 3) begin //Cannot put N == 3 in generation loop without complex modification
			MultiplierFirstRow #(
				.WIDTH(N)
			) row1 (
				.m		(m),					   //Input 1 ("m")
				.q		(q[1:0]),				//Input 2 ("q")
				.mout	(mout[0]),				//m passthrough
				.sum	({sumAry[0], P[1]}),	//Sum of first row (connects to next row and lsb connects directly to "P" (multiplication result))
				.cout	(PPi[0])					//Carry out of firt row to connect to last element of next row (msb)
			);	
	
			MultiplierNextRow #(
				.WIDTH(N)
			) row2(
				.m			(mout[0]),				  //Input 1.1 ("m")
				.sumin	({PPi[0], sumAry[0]}), //Input 1.2 (carry out concatenated with sum from corresponding element + 1 of first row)
				.q			(q[2]),					  //Input 2 ("q")
				.sum		(P[4:2]),				  //Sum directly connects to "P" (multiplication result) 
				.cout		(P[5]),     			  //Carry out becomes msb of "P" (multiplication result)
				.mout		(mout[1])
			);
			
		end else if(N > 3) begin //Only if N > 3 generate instances in a loop
			//First Row instance
			MultiplierFirstRow #(
				.WIDTH(N)
			) MultiplierFirstRow_inst(
				.m		(m),
				.q		(q[1:0]),
				.mout	(mout[0]),
				.sum	({sumAry[0], P[1]}),
				.cout	(PPi[0])
			);	
			//Generation when N >= 4 is split into 3 sections: First Instance, Last Instance and all other instances
			for (i = 0; i < N-2; i = i + 1) begin : loop_name    
				if(i==0)begin //First instance inputs always connect to MultiplierFirstRow_inst
					MultiplierNextRow #(
						.WIDTH(N)
					) MultiplierNextRow_inst(
						.m			(mout[0]),
						.sumin	({PPi[0], sumAry[0]}),
						.q			(q[2]),
						.sum		({sumAry[1], P[2]}),
						.cout		(PPi[1]),
						.mout		(mout[1])
					);
				end else if (i < N-3) begin //All other instances are internal connections with exeption of 1st bit of sum out 
					MultiplierNextRow #(
						.WIDTH(N)
					) MultiplierNextRow_inst(
						.m			(mout[i]),
						.sumin	({PPi[i], sumAry[i]}),   //Concatenate carry out (msb) of previous row with sum of previous row (without bit 0) to input of current row
						.q			(q[i+2]),
						.sum		({sumAry[i+1], P[i+2]}),
						.cout		(PPi[i+1]),
						.mout		(mout[i+1])
					);
				end else begin //Last instance outputs always connect to output ports (P)
					MultiplierNextRow #(
						.WIDTH(N)
					) MultiplierNextRow_inst(
						.m			(mout[i]),								//Input 1 ("m") last bit (msb)
						.sumin	({PPi[i], sumAry[i]}),				//Concatenate carry out (msb) of previous row with sum of previous row (without bit 0) to input of current row
						.q			(q[N-1]),								//Last bit of input 2 ("q")
						.sum		(P[(N*2)-2:(((N*2)-2)-(N-1))]),	//Sum of last row directly connects to "P" (multiplication result)
						.cout		(P[(N*2)-1]),							//Carry out of last row becomes MSB of "P" (multiplication result)
						.mout		()
					);
				end
			end
		end
	endgenerate
	
	assign P[0] = m[0] & q[0];		//First bit of output will always be an and gate for all values of N

endmodule