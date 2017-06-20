module binaryToASCII # (
	parameter NIBBLE_SIZE = 3,
	parameter BCD_NUMBER_LENGTH = (NIBBLE_SIZE<5) ? (NIBBLE_SIZE+1) : (NIBBLE_SIZE<10) ? (NIBBLE_SIZE+2) : (NIBBLE_SIZE+2)
)(
	input enable,
	input [(4*NIBBLE_SIZE)-1:0] binaryInput,
	output [(8*BCD_NUMBER_LENGTH)-1:0] acsiiOutput
);

wire [(4*BCD_NUMBER_LENGTH)-1:0]bcdValueToASCII;

hexToBcd #(
	.NIBBLE_SIZE(NIBBLE_SIZE)
) hexToBcd (
	.bcdEnable(enable),
	.hexValue(binaryInput),
	.bcdValue(bcdValueToASCII)
);

bcdToASCII #(
	.BCD_NUMBER_LENGTH(BCD_NUMBER_LENGTH)
) bcdToASCII (
	.asciiEnable(enable),
	.bcdInput(bcdValueToASCII),
	.acsiiOutput(acsiiOutput)
);

endmodule
