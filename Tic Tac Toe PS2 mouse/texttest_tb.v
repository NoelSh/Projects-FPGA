module texttest_tb;

reg clock;
wire [7:0] xAdd;
wire [8:0] yAdd;
wire textEN;


integer i;

texttest DUT (
	.clock(clock),
	.xAdd(xAdd),
	.yAdd(yAdd),
	.textEnable(textEN)
);


initial begin

	$display("\tTime,\clock,\xAdd,\yAdd,\textEN");
	$monitor("%d,\t%b,\t%b,\t%b,\t%b",$time,clock,xAdd,yAdd,textEN);
	
	#20;
	clock = 0;
	for(i=0; i<((320*240)*2); i=i+1) begin
		clock = ~clock;
		#20;
	end

end

endmodule