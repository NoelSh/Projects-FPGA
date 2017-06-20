module Multiplier4x4(
	input	[3:0] m,
	input [3:0] q,
	output [7:0] P
);

	wire [2:0] sumAry [1:0];
	wire [1:0] PPi;

	MultiplierFirstRow #(
		.WIDTH(4)
	) FirstRow(
		.m(m),
		.q(q[1:0]),
		.mout(),
		.sum({sumAry[0], P[1]}),
		.cout(PPi[0])
	);
	
	MultiplierNextRow #(
		.WIDTH(4)
	)
	Row2(
		.m(m),
		.sumin({PPi[0], sumAry[0]}),
		.q(q[2]),
		.sum({sumAry[1], P[2]}),
		.cout(PPi[1]),
		.mout()
	);
	
	MultiplierNextRow #(
		.WIDTH(4)
	)
	Row3(
		.m(m),
		.sumin({PPi[1], sumAry[1]}),
		.q(q[3]),
		.sum(P[6:3]),
		.cout(P[7]),
		.mout()
	);
	
	assign P[0] = m[0] & q[0];


endmodule