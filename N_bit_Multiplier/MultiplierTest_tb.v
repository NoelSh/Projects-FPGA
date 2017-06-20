`timescale 1ns/1ns

module MultiplierTest_tb;

	parameter N = 4;

	reg [3:0] m;
	reg [2:0] q;
	wire [7:0] P;

	integer i;

	MultiplierTest DUT(
		.m(m),
		.q(q),
		.P(P)	
	);

	initial begin
		$display("\tTime,\m,\q,\P");
		$monitor("%d,\t%b,\t%b,\t%b",$time,m,q,P);
		
		for(i=0; i<= ((2**(7))-1); i=i+1) begin: loop_name
			#20;
			m = i[6:3];
			q = i[2:0];
		end
		#20;
		
	end
	
endmodule