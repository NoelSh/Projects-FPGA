module SevenSegDisplay #(
	parameter WIDTH = 3
)(
	input bcdEnable,
	input [(4*WIDTH)-1:0] valueNumber,
	output [(7*WIDTH)-1:0] displayNumber
);

	reg [(4*WIDTH)-1:0] displayDigits;

	genvar i; //Generate variable to be used in the for loop 
	generate 
		for (i = 0; i < WIDTH; i = i + 1) begin : loop_name 
			SevenSegDriver digit (
			  .number  (~displayDigits[(4*(i+1))-1:4*i]),
			  .segment (displayNumber[(7*(i+1))-1:7*i])
			);
		end 	
	endgenerate 
	
   // Register to temporarily hold bcd bits
   reg [23:0] bcd;
   integer j;
   
   always @(valueNumber)
   begin
		if(bcdEnable == 1'b0) begin
			displayDigits = valueNumber;
		end else if (bcdEnable == 1'b1) begin
			// Clear previous number and store new number in shift register
			bcd = 0;
			bcd[11:0] = valueNumber;
			// Loop twelve times
			for (j=0; j<12; j=j+1) begin
				if (bcd[15:12] >= 5) begin
					bcd[15:12] = bcd[15:12] + 3;
				end	
				if (bcd[19:16] >= 5) begin
					bcd[19:16] = bcd[19:16] + 3;
				end	
				if (bcd[23:20] >= 5) begin
					bcd[23:20] = bcd[23:20] + 3;
				end
				// Shift entire register left once
				bcd = bcd << 1;
			end

			displayDigits = bcd[23:12];
		end
   end

endmodule