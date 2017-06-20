module asciitest_tb;

reg clk;
wire [7:0] value;

integer i;

asciitest DUT (
	.clk(clk),
	.value(value)
);

initial begin

	$display("\tTime,\clk,\value");
	$monitor("%d,\t%b,\t%b",$time,clk,value);
	
	#20;
	clk = 0;
	for(i=0; i<10000; i=i+1) begin
		clk = ~clk;
		#20;
	end

end

endmodule

