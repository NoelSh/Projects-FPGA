`timescale 1ns/1ns

module AdderNbit_tb;

	parameter WIDTH = 6;

	reg [WIDTH-1:0] a_test;
	reg [WIDTH-1:0] b_test;
	reg cin_test;
	wire [WIDTH-1:0] sum_test;
	wire cout_test;
	
	integer i;

	AdderNbit #(.N(WIDTH)) DUT
	(
		.a(a_test),
		.b(b_test),
		.cin(cin_test),
		.sum(sum_test),
		.cout(cout_test)		
	);

	initial begin
		$display("\tTime,\a_test,\b_test,\cin_test,\sum_test\cout_test");
		$monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time,a_test,b_test,cin_test,sum_test,cout_test);
		
		for(i=0; i<=((2**((WIDTH*2)+1))-1); i=i+1) begin: loop_name
			#20;
			cin_test =  i[0];
			a_test = i[WIDTH:1];
			b_test = i[WIDTH*2:WIDTH+1];
		end
		#20;
		
	end
	
endmodule