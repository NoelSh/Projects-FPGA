`timescale 1ns/1ns

module FullAdder_tb;

	reg a_test;
	reg b_test;
	reg cin_test;
	wire sum_test;
	wire cout_test;

	FullAdder DUT (
		.a(a_test),
		.b(b_test),
		.cin(cin_test),
		.sum(sum_test),
		.cout(cout_test)		
	);

	initial begin
		$display("\tTime,\a_test,\b_test,\cin_test,\sum_test\cout_test");
		$monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time,a_test,b_test,cin_test,sum_test,cout_test);
		
		#20
		a_test = 		 1'b0;
		b_test = 		 1'b0;
		cin_test = 1'b0;
		#20
		a_test = 		 1'b0;
		b_test = 		 1'b0;
		cin_test = 1'b1;
		#20
		a_test = 		 1'b0;
		b_test = 		 1'b1;
		cin_test = 1'b0;
		#20
		a_test = 		 1'b0;
		b_test = 		 1'b1;
		cin_test = 1'b1;
		
		#20
		a_test = 		 1'b1;
		b_test = 		 1'b0;
		cin_test = 1'b0;
		#20
		a_test = 		 1'b1;
		b_test = 		 1'b0;
		cin_test = 1'b1;
		#20
		a_test = 		 1'b1;
		b_test = 		 1'b1;
		cin_test = 1'b0;
		#20
		a_test = 		 1'b1;
		b_test = 		 1'b1;
		cin_test = 1'b1;
		#20;
	end
endmodule