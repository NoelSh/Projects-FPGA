module bcdToASCII #(
	parameter BCD_NUMBER_LENGTH = 3
)(
	input asciiEnable,
	input [(4*BCD_NUMBER_LENGTH)-1:0] bcdInput,
	output [(8*BCD_NUMBER_LENGTH)-1:0] acsiiOutput
);
	
	reg [(4*BCD_NUMBER_LENGTH)-1:0] bcdInputReg;
	reg [(8*BCD_NUMBER_LENGTH)-1:0] asciiOutputReg;
	
	always @(bcdInput)begin
		bcdInputReg = bcdInput;
		asciiOutputReg[7:0] = {4'b0, bcdInputReg[3:0]} + 8'd48;
		if (BCD_NUMBER_LENGTH > 1) begin
			asciiOutputReg[15:8] = {4'b0, bcdInputReg[7:4]} + 8'd48;
		end
		if (BCD_NUMBER_LENGTH > 2) begin
			asciiOutputReg[23:16] = {4'b0, bcdInputReg[11:8]} + 8'd48;
		end
//		if (BCD_NUMBER_LENGTH > 3) begin
//			asciiOutputReg[31:24] = {4'b0, bcdInputReg[15:12]} + 8'd48;
//		end
//		if (BCD_NUMBER_LENGTH > 4) begin
//			asciiOutputReg[39:32] = {4'b0, bcdInput[19:16]}+ 8'd48;
//		end
	end

	//assign acsiiOutput = asciiEnable ? asciiOutputReg : 1'bz;
	assign acsiiOutput = asciiOutputReg;
	
endmodule

