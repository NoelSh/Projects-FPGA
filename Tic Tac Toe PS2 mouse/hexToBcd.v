module hexToBcd #(
	parameter NIBBLE_SIZE = 2,
	parameter BCD_SIZE = (NIBBLE_SIZE<5) ? (NIBBLE_SIZE+1)*4 : (NIBBLE_SIZE<10) ? (NIBBLE_SIZE+2)*4 : (NIBBLE_SIZE+3)*4
)(
	input bcdEnable,
	input [(4*NIBBLE_SIZE)-1:0] hexValue,
	output [BCD_SIZE-1:0] bcdValue
);

		
	reg [BCD_SIZE-1:0] bcdValueReg;
	reg [(2*BCD_SIZE)-1:0] bcdValueConversion;
	
	integer bcd_loop;
	
	always @(hexValue) begin
		bcdValueConversion = 0;
		bcdValueConversion[(4*NIBBLE_SIZE)-1:0] = hexValue;
		
		for(bcd_loop = 0; bcd_loop < (4*NIBBLE_SIZE); bcd_loop = bcd_loop + 1) begin
				if (bcdValueConversion[(4*NIBBLE_SIZE)+3:4*NIBBLE_SIZE] >= 5) begin
					bcdValueConversion[(4*NIBBLE_SIZE)+3:4*NIBBLE_SIZE] = bcdValueConversion[(4*NIBBLE_SIZE)+3:4*NIBBLE_SIZE] + 3;
				end
				if (bcdValueConversion[(4*NIBBLE_SIZE)+7:(4*NIBBLE_SIZE)+4] >= 5) begin
					bcdValueConversion[(4*NIBBLE_SIZE)+7:(4*NIBBLE_SIZE)+4] = bcdValueConversion[(4*NIBBLE_SIZE)+7:(4*NIBBLE_SIZE)+4] + 3;
				end	
				if (NIBBLE_SIZE > 1) begin //2 or higher
					if (bcdValueConversion[(4*NIBBLE_SIZE)+11:(4*NIBBLE_SIZE)+8] >= 5) begin
						bcdValueConversion[(4*NIBBLE_SIZE)+11:(4*NIBBLE_SIZE)+8] = bcdValueConversion[(4*NIBBLE_SIZE)+11:(4*NIBBLE_SIZE)+8] + 3;
					end
				end
				if (NIBBLE_SIZE > 2) begin //3 or higher
					if (bcdValueConversion[(4*NIBBLE_SIZE)+15:(4*NIBBLE_SIZE)+12] >= 5) begin
						bcdValueConversion[(4*NIBBLE_SIZE)+15:(4*NIBBLE_SIZE)+12] = bcdValueConversion[(4*NIBBLE_SIZE)+15:(4*NIBBLE_SIZE)+12] + 3;
					end
				end
				if (NIBBLE_SIZE > 3) begin //4 or higher
					if (bcdValueConversion[(4*NIBBLE_SIZE)+19:(4*NIBBLE_SIZE)+16] >= 5) begin
						bcdValueConversion[(4*NIBBLE_SIZE)+19:(4*NIBBLE_SIZE)+16] = bcdValueConversion[(4*NIBBLE_SIZE)+19:(4*NIBBLE_SIZE)+16] + 3;
					end
				end
				if (NIBBLE_SIZE > 4) begin //5 or higher
					if (bcdValueConversion[(4*NIBBLE_SIZE)+23:(4*NIBBLE_SIZE)+20] >= 5) begin
						bcdValueConversion[(4*NIBBLE_SIZE)+23:(4*NIBBLE_SIZE)+20] = bcdValueConversion[(4*NIBBLE_SIZE)+23:(4*NIBBLE_SIZE)+20] + 3;
					end
					if (bcdValueConversion[(4*NIBBLE_SIZE)+27:(4*NIBBLE_SIZE)+24] >= 5) begin
						bcdValueConversion[(4*NIBBLE_SIZE)+27:(4*NIBBLE_SIZE)+24] = bcdValueConversion[(4*NIBBLE_SIZE)+27:(4*NIBBLE_SIZE)+24] + 3;
					end
				end
			bcdValueConversion = bcdValueConversion << 1;
		end		
		
		bcdValueReg = bcdValueConversion[(2*BCD_SIZE)-1:4*NIBBLE_SIZE];
		
	end
	
	assign bcdValue = bcdEnable ? bcdValueReg : 1'bz;

endmodule
