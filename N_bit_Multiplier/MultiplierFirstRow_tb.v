`timescale 1ns/1ns


module MultiplierFirstRow_tb;

	parameter N = 4;
	
	integer i;
	
	reg [N-1:0] m;
	reg [1:0] q;
	wire [N-1:0] mout;
	wire [N-1:0] sum;
	wire cout;
	
	wire d0;
	
	assign d0 = m[0] & q[0];


	MultiplierFirstRow #(
		.WIDTH(N)
	) DUT(
		.m(m),
		.q(q),
		.mout(mout),
		.sum(sum),
		.cout(cout)
	);
	
	
	initial begin
		$display("\tTime,\m,\q,\mout,\sum,\cout");
		$monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time,m,q,mout,sum,cout);
		
		for(i=0; i<= ((2**(N+2))-1); i=i+1) begin: loop_name
			#20;
			q = i[1:0];
			m = i[N+2:2];
		end
		#20;
		
	end

	
	
	

endmodule







