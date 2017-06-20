module level_to_pulse (
	input 			clock,
	input				globalReset,
	input 			level,
	output	reg	pulse
);

	reg			[1:0] state			=2'b00;
	reg 			[1:0] next_state	=2'b00;	
	localparam 	 		S1				=2'b00;
	localparam 			S2				=2'b01;
	localparam			S3				=2'b11;
	
	always @ (posedge clock) begin 
		if (globalReset == 1) begin
			pulse = 0;
			next_state = S1;
		end else begin
			case (state) 
				S1 : begin
					pulse = 0;
					if	(level == 1) begin
						next_state = S2;
					end else begin
						next_state = S1;
					end
				end
				
				S2 : begin
					pulse = 1;
					if (level == 1) begin
						next_state = S3;
					end else begin
						next_state = S1;
					end
				end
				
				S3 : begin
					pulse = 0;
					if (level == 1) begin 
						next_state = S3;
					end else begin 
						next_state = S1;
					end
				end
				default : begin
					next_state = S1;
				end
			endcase
		end
	end
	
	always @(posedge clock) begin
		if (globalReset == 1) begin
			state <= S1;
		end else begin
			state <= next_state;
		end
	end
	
endmodule 			
		