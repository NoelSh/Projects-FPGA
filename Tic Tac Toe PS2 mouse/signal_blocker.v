/*============================================================
*		Cooperating with state machine, activate signal is 
		blocked under 4 conditions:
		
		1. Not right player to move;
		2. Overlap chesses;
		3. Someone wins;
		4. Draw;
==============================================================
*/
module signal_blocker #(
		parameter 			player
	)(
		input 		[1:0] game_state,
		input 				signal_in,
		input 		[3:0] coodinate,
		input 		[8:0] all_status_check,
		input 				win_signal,
		output 				signal_out
	);

		assign signal_out=~((~signal_in) && ((player==game_state) ? 1'b1:1'b0)&&((coodinate==15) ? 1'b0:1'b1)&&((all_status_check==9'b111111111)? 1'b0:1'b1) && (~win_signal));
		
endmodule 