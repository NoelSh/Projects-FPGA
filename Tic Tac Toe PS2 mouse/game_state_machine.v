module game_state_machine (
	input 					clock,
	input 					reset,
	input 					win_signal,
	input 					click,
	input 					o_status_ack,
	input 					x_status_ack,
	
	output reg 		[1:0] z=2'b01
);

reg 					[1:0] state=2'b00;
reg 					[1:0] next_state;

localparam 					o_turn = 2'b00;
localparam 					x_turn = 2'b01;
localparam 					gameover = 2'b10;

always @(click  or reset)begin

	/* cypher the state */
	if (reset==1'b0) begin
			z = 2'b00;
			next_state = o_turn;
	end else begin
	
			case (state)
			/* give x the move after o moved */
				o_turn: begin
						if (click==0&&o_status_ack==1)begin
								z = 2'b00;
								next_state = x_turn;
						end else begin
								next_state = o_turn;
						end
				end
				
			/* vise versa */
				x_turn: begin
						if ((click==0&&x_status_ack==1))begin
								z = 2'b01;
								next_state = o_turn;
						end else begin
								next_state = x_turn;
						end
				end
				
				default: begin
						next_state = 2'bxx;
				end
			endcase
	end
end
	
always @(posedge clock) begin 
	if (reset==1'b0) begin
			state <= o_turn;
	end else begin
			state <= next_state;
	end
end

endmodule