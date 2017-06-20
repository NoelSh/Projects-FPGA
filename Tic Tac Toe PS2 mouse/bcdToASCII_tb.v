module bcdToASCII_tb;

parameter BCDNUMBERLENGTH = 3;

	reg asciiEnable;
	reg [(4*BCDNUMBERLENGTH)-1:0] bcdInput;
	wire [(8*BCDNUMBERLENGTH)-1:0] acsiiOutput;


integer i;
integer j;
integer k;

bcdToASCII #(
	.BCD_NUMBER_LENGTH(BCDNUMBERLENGTH)
) DUT (
	.asciiEnable(asciiEnable),
	.bcdInput(bcdInput),
	.acsiiOutput(acsiiOutput)
);


initial begin

	$display("\tTime,\asciiEnable,\bcdInput,\acsiiOutput");
	$monitor("%d,\t%b,\t%b,\t%b",$time,asciiEnable,bcdInput,acsiiOutput);
	
	#20;
	asciiEnable = 1;
	for(i=0; i < 10; i=i+1) begin
		for(j=0; j < 10; j=j+1) begin
			for(k=0; k < 10; k=k+1) begin
				bcdInput[3:0] = k;
				bcdInput[7:4] = k;
				bcdInput[11:8] = k;
				#20;
			end
		end
	end

end

endmodule