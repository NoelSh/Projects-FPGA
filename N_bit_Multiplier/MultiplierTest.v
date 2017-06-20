module MultiplierTest(
	input	[3:0] m,
	input [2:0] q,
	output [6:0] P
);

	wire [2:0] sumAry [1:0];
	wire PPi;

	MultiplierFirstRow #(
		.WIDTH(4)
	) FirstRow(
		.m(m),
		.q(q[1:0]),
		.mout(),
		.sum({sumAry[0], P[1]}),
		.cout(PPi)
	);
	
	MultiplierNextRow #(
		.WIDTH(4)
	)
	Row2(
		.m(m),
		.sumin({PPi, sumAry[0]}),
		.q(q[2]),
		.sum(P[5:2]),
		.cout(P[6]),
		.mout()
	);
	

	
	assign P[0] = m[0] & q[0];


endmodule