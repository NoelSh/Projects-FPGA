module statetest_tb;

reg clock;
reg reset;
wire [3:0] state;
wire [7:0] Timer;

integer i;

statetest DUT (
	.clock(clock),
	.reset(reset),
	.state(state),
	.Timer(Timer)
);

initial begin

	$display("\tTime,\clock,\reset,\state,\Timer");
	$monitor("%d,\t%b,\t%b,\t%b",$time,clock,reset,state,Timer);
	
	#20;
	reset = 0;
	clock = 0;
	for(i=0; i<10000; i=i+1) begin
		clock = ~clock;
		#20;
	end

end

endmodule
