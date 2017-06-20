`timescale 1ns/1ns

module NbitMultiplier_tb;

	parameter N = 4;
	parameter DISPLAY_WIDTH = 3;

	reg [N-1:0] m;
	reg [N-1:0] q;
	wire [(7*DISPLAY_WIDTH)-1:0] displaySeg;

	integer i;

	NbitMultiplier #(
		.N(N),
		.DISPLAY_WIDTH(DISPLAY_WIDTH)
	) DUT (
		.m(m),
		.q(q),
		.displaySeg(displaySeg)	
	);

	initial begin
		$display("\tTime,\m,\q,\displaySeg");
		$monitor("%d,\t%b,\t%b,\t%b",$time,m,q,displaySeg);
		//Test all possible multilier input combinations
		for(i=0; i<=((2**(N*2))-1); i=i+1) begin: loop_name
			#20;
			m = i[N-1:0];
			q = i[(N*2)-1:N];
		end
		#20;
	end
	
endmodule