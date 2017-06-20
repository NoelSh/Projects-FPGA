module divcount_tb;

reg clk;
wire [8:0] count;
wire [7:0] result;

integer i;

divtest DUT (
	.clk(clk),
	.result(result),
	.Count(count)
);

initial begin

	$display("\tTime,\clk,\result,\count");
	$monitor("%d,\t%b,\t%b,\t%b",$time,clk,result,count);
	
	#20;
	clk = 0;
	for(i=0; i<10000; i=i+1) begin
		clk = ~clk;
		#20;
	end

end

endmodule

