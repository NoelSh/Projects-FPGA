module hexToBcd_tb;

parameter NIBBLESIZE = 2;
parameter BCDSIZE = (NIBBLESIZE<5) ? (NIBBLESIZE+1)*4 : (NIBBLESIZE<10) ? (NIBBLESIZE+2)*4 : (NIBBLESIZE+3)*4;


reg bcdEnable;
reg [(4*NIBBLESIZE)-1:0] hexValue;
wire [BCDSIZE-1:0] bcdValue;


integer i;

hexToBcd #(
	.NIBBLE_SIZE(NIBBLESIZE)
) DUT (
	.bcdEnable(bcdEnable),
	.hexValue(hexValue),
	.bcdValue(bcdValue)
);


initial begin

	$display("\tTime,\bcdEnable,\hexValue,\bcdValue");
	$monitor("%d,\t%b,\t%b,\t%b",$time,bcdEnable,hexValue,bcdValue);
	
	#20;
	bcdEnable = 1;
	for(i=0; i < (2**(4*NIBBLESIZE))-1; i=i+1) begin
		hexValue = i;
		#20;
	end

end

endmodule