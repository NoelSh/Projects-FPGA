module Multiplier4x4Man(
	input	[3:0] m,
	input [3:0] q,
	output [7:0] P
);

	wire [3:0] Row0Carry;
	wire [3:0] Row0Sum;
	
	wire [3:0] Row1Carry;
	wire [3:0] Row1Sum;
	
	wire [3:0] Row2Carry;
	wire [3:0] Row2Sum;
	
	wire [2:0] m0Out;
	wire [2:0] m1Out;
	wire [2:0] m2Out;
	wire [2:0] m3Out;
	

	/***************** FIRST ROW *****************/
	
	MultiplierFirst Row0Bit0 (
		.m({1'b0, m[0]}),
		.q(q[1:0]),
		.cin(1'b0),
		.sum(Row0Sum[0]),
		.cout(Row0Carry[0]),
		.mout(m0Out[0])
	);
	
	MultiplierFirst Row0Bit1 (
		.m({1'b0, m[1]}),
		.q(q[1:0]),
		.cin(Row0Carry[0]),
		.sum(Row0Sum[1]),
		.cout(Row0Carry[1]),
		.mout(m1Out[0])
	);
	
	MultiplierFirst Row0Bit2 (
		.m({1'b0, m[2]}),
		.q(q[1:0]),
		.cin(Row0Carry[1]),
		.sum(Row0Sum[2]),
		.cout(Row0Carry[2]),
		.mout(m2Out[0])
	);
	
	MultiplierFirst Row0Bit3 (
		.m({1'b0, m[3]}),
		.q(q[1:0]),
		.cin(Row0Carry[2]),
		.sum(Row0Sum[3]),
		.cout(Row0Carry[3]),
		.mout(m3Out[0])
	);
	
	
	/***************** SECOND ROW *****************/
	
	MultiplierNext Row1Bit0 (
		.m(m0Out[0]),
		.sumin(Row0Sum[1]),
		.q(q[2]),
		.cin(1'b0),
		.sum(Row1Sum[0]),
		.cout(Row1Carry[0]),
		.mout(m0Out[1])
	);
	
	MultiplierNext Row1Bit1 (
		.m(m1Out[0]),
		.sumin(Row0Sum[2]),
		.q(q[2]),
		.cin(Row1Carry[0]),
		.sum(Row1Sum[1]),
		.cout(Row1Carry[1]),
		.mout(m1Out[1])
	);
	
	MultiplierNext Row1Bit2 (
		.m(m2Out[0]),
		.sumin(Row0Sum[3]),
		.q(q[2]),
		.cin(Row1Carry[1]),
		.sum(Row1Sum[2]),
		.cout(Row1Carry[2]),
		.mout(m2Out[1])
	);
	
	MultiplierNext Row1Bit3 (
		.m(m3Out[0]),
		.sumin(Row0Carry[3]),
		.q(q[2]),
		.cin(Row1Carry[2]),
		.sum(Row1Sum[3]),
		.cout(Row1Carry[3]),
		.mout(m3Out[1])
	);
	
	
	/***************** THIRD ROW *****************/
	
	MultiplierNext Row2Bit0 (
		.m(m0Out[1]),
		.sumin(Row1Sum[1]),
		.q(q[3]),
		.cin(1'b0),
		.sum(Row2Sum[0]),
		.cout(Row2Carry[0]),
		.mout()
	);
	
	MultiplierNext Row2Bit1 (
		.m(m1Out[1]),
		.sumin(Row1Sum[2]),
		.q(q[2]),
		.cin(Row2Carry[0]),
		.sum(Row2Sum[1]),
		.cout(Row2Carry[1]),
		.mout()
	);
	
	MultiplierNext Row2Bit2 (
		.m(m2Out[1]),
		.sumin(Row1Sum[3]),
		.q(q[3]),
		.cin(Row2Carry[1]),
		.sum(Row2Sum[2]),
		.cout(Row2Carry[2]),
		.mout()
	);
	
	MultiplierNext Row2Bit3 (
		.m(m3Out[1]),
		.sumin(Row1Carry[3]),
		.q(q[3]),
		.cin(Row2Carry[2]),
		.sum(Row2Sum[3]),
		.cout(Row2Carry[3]),
		.mout()
	);
	
	
	assign P[0] = m[0] & q[0];
	assign P[1] = Row0Sum[0];
	assign P[2] = Row1Sum[0];
	assign P[3] = Row2Sum[0];
	assign P[4] = Row2Sum[1];
	assign P[5] = Row2Sum[2];
	assign P[6] = Row2Sum[3];
	assign P[7] = Row2Carry[3];
	
	

endmodule