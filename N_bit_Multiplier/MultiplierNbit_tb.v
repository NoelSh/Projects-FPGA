`timescale 1ns/1ns
module MultiplierNbit_tb;

	parameter N = 6;

	reg [N-1:0] m_test;
	reg [N-1:0] q_test;
	wire [(N*2)-1:0] P_test;
	
	wire [(N*2)-1:0] expected_value; 			//N*2-bit wire to store expected value assign expected_value = m_test*q_test;
	assign expected_value = m_test*q_test; 	//Calculate expected value differently to DUT

	integer i;				//interger to test all combinations of inputs

	MultiplierNbit #(.N(N)) DUT
	(
		.m(m_test),
		.q(q_test),
		.P(P_test)	
	);

	initial begin
		$display("\tTime,\m_test,\q_test,\P_test");
		$monitor("%d,\t%b,\t%b,\t%b",$time,m_test,q_test,P_test);
		
		for(i=0; i<=((2**(N*2))-1); i=i+1) begin: input_test_loop
			#20;
			m_test = i[N-1:0];
			q_test = i[(N*2)-1:N];
			if( expected_value !== P_test)	//Check if DUT output is not as expected and display where error has occured 
				$display("Error when I/P m_test=%b, q_test=%b and O/P P_test=%b", m_test,q_test,P_test);
		end
		#20;
	end
	
endmodule