module binaryToASCII_tb;

parameter NIBBLESIZE = 3;
parameter BCDNUMBERLENGTH = (NIBBLESIZE<5) ? (NIBBLESIZE+1) : (NIBBLESIZE<10) ? (NIBBLESIZE+2) : (NIBBLESIZE+2);

reg enable_test;
reg [(4*NIBBLESIZE)-1:0] binaryInput_test;
wire [(8*BCDNUMBERLENGTH)-1:0] acsiiOutput_test;


integer i;

binaryToASCII #(
	.NIBBLE_SIZE(NIBBLESIZE)
) DUT (
	.enable(enable_test),
	.binaryInput(binaryInput_test),
	.acsiiOutput(acsiiOutput_test)
);


initial begin

	$display("\tTime,\enable_test,\binaryInput_test,\acsiiOutput_test");
	$monitor("%d,\t%b,\t%b,\t%b",$time,enable_test,binaryInput_test,acsiiOutput_test);
	
	#20;
	enable_test = 1;
	for(i=0; i < (2**(4*NIBBLESIZE)); i=i+1) begin
		binaryInput_test = i;
		#20;
	end

end

endmodule
