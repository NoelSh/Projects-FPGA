`timescale 1ns/1ns

module MultiplierNbitAnySize_tb;

	parameter N = 3;

	reg [N-1:0] m_test;
	reg [N-1:0] q_test;
	wire [(N*2)-1:0] P_test;

	integer i;

	MultiplierNbitAnySize #(.N(N)) DUT
	(
		.m(m_test),
		.q(q_test),
		.P(P_test)	
	);

	initial begin
		$display("\tTime,\m_test,\q_test,\P_test");
		$monitor("%d,\t%b,\t%b,\t%b",$time,m_test,q_test,P_test);
		
		for(i=0; i<=((2**(N*2))-1); i=i+1) begin: loop_name
			#20;
			m_test = i[N-1:0];
			q_test = i[(N*2)-1:N];
		end
		#20;
		
	end
	
endmodule