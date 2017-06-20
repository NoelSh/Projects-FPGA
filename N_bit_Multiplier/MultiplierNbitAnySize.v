module MultiplierNbitAnySize #(
	parameter N = 6
)(
	input	[N-1:0] m,
	input [N-1:0] q,
	output [(N*2)-1:0] P
);

	wire PPi[N-2:0];
	wire [N-1:0]mout[N-3:0];	
	wire [N-2:0] sumAry[N-1:0];

	MultiplierFirstRow #(
		.WIDTH(N)
	)MultiplierFirstRow_inst(
		.m		(m),
		.q		(q[1:0]),
		.mout	(mout[0]),
		.sum	({sumAry[0], P[1]}),
		.cout	(PPi[0])
	);

	genvar i; //Generate variable to be used in the for loop 

	generate 

		for (i = 0; i < N-2; i = i + 1) begin : loop_name    
			if(i==0)begin
				MultiplierNextRow #(
					.WIDTH(N)
				)
				MultiplierNextRow_inst(
					.m			(mout[0]),
					.sumin	({PPi[0], sumAry[0]}),
					.q			(q[2]),
					.sum		({sumAry[1], P[2]}),
					.cout		(PPi[1]),
					.mout		(mout[1])
				);
			end else if (i < N-3) begin
				MultiplierNextRow #(
					.WIDTH(N)
				)
				MultiplierNextRow_inst(
					.m			(mout[i]),
					.sumin	({PPi[i], sumAry[i]}),
					.q			(q[i+2]),
					.sum		({sumAry[i+1], P[i+2]}),
					.cout		(PPi[i+1]),
					.mout		(mout[i+1])
				);
			end else begin
				MultiplierNextRow #(
					.WIDTH(N)
				)
				MultiplierNextRow_inst(
					.m			(mout[i]),
					.sumin	({PPi[i], sumAry[i]}),
					.q			(q[N-1]),
					.sum		(P[(N*2)-2:(((N*2)-2)-(N-1))]),
					.cout		(P[(N*2)-1]),
					.mout		()
				);
			end
		end 
		
	endgenerate 
	
	assign P[0] = m[0] & q[0];

endmodule