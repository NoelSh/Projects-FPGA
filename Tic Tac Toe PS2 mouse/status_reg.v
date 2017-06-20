module status_reg (
	input 				reset,
	input 				signal,
	input			[3:0] coodinate,
	input 		[8:0]	opp_status,
	
	
	output reg 	[8:0] status,
	output reg 			status_ack = 1'b0
	);
	
	reg 			[8:0] status_reg = 9'b000000000;
	
	always @(negedge signal or negedge reset) begin
	
		if (reset==0) begin  /* reset: clear the buffer */
			status_reg 	= 8'b00000000;
		end else if (opp_status [coodinate] == 0 && status[coodinate] == 0)begin
		
		/* ========================================================================
			If the cooresponding coodinate dosen't have any chess taking its place 
			a return value is sent back (i.e. status_ack =1)
			
			status_ack is used to prevent the state machine from changing when
			overlap coodinate is used.
		========================================================================*/
		
			status_ack 	= 1'b1;
			status_reg [coodinate] 	= 1'b1;
		end else begin
			status_ack 	= 1'b0;
		end
		
			status=status_reg;
	end

endmodule