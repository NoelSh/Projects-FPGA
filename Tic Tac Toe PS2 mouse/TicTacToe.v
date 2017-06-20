/*============================================================
This is a Tic-tac-toe game Logic block with layer showing below:

			+---+---+---+
			| 0 | 1 | 2 |
			+---+---+---+
			| 3 | 4 | 5 |
			+---+---+---+
			| 6 | 7 | 8 |
			+---+---+---+
			
*	Logic is done internally by the status with 9 bit data;
	Status is changed by sending 4bit coodinate to a registor;

*	State machine is uesd to pick the side to make move;

*	A signal blocker is used to stop player in both side to 
	make move in some specific situations;
==============================================================
*/
module TicTacToe (
	input 				clock,
	input 				reset,
	input 				o_signal,
	input 				x_signal,
	input 		[3:0] o_coodinate,
	input 		[3:0] x_coodinate,
	
	output reg 	[8:0] o_status_check,
	output reg 	[8:0] x_status_check,
	output reg 	[1:0] win_status=2'b00,		/* 0: gaming;
															1: o wins;
															2: x wins;
															3: draw; */
															
	output 		[1:0] game_state_t,			/* 1'b00: o's turn;
															1'b01: x's turn;*/	
	output 				click_t
	);
	

	wire 			[1:0] game_state;
	wire 			[8:0] o_status_link;
	wire 			[8:0] x_status_link;
	wire 			[8:0] all_status_link;
	wire 					win_signal;
	wire 					o_signal_1;
	wire 					x_signal_1;
	wire 					o_status_ack;
	wire 					x_status_ack;
	wire 					click;
	wire 					o_win_link;
	wire 					x_win_link;
	
	assign 				win_signal		 =	|win_status;
	assign 				game_state_t	 =	game_state;
	assign 				all_status_link =	o_status_link|x_status_link;
	assign 				click				 =	~((~o_signal_1)||(~x_signal_1));
	assign 				click_t			 = click;
	
	game_state_machine M1 (
		.clock				(clock),
		.reset				(reset),
		.win_signal 		(win_signal),
		.click				(click),
		.o_status_ack		(o_status_ack),
		.x_status_ack		(x_status_ack),
		.z						(game_state)
	);
		
	signal_blocker #(
		.player				(1'b00)
	) o_blocker (
		.signal_in			(o_signal),
		.coodinate			(o_coodinate),
		.all_status_check	(all_status_link),
		.game_state			(game_state),
		.win_signal			(win_signal),
		.signal_out			(o_signal_1)
	);
	
	signal_blocker #(
		.player				(1'b01)
	) x_blocker (
		.signal_in			(x_signal),
		.coodinate			(x_coodinate),
		.all_status_check	(all_status_link),
		.game_state			(game_state),
		.win_signal			(win_signal),
		.signal_out			(x_signal_1)
	);
	
	status_reg o_reg (
		.reset				(reset),
		.signal				(o_signal_1),
		.coodinate			(o_coodinate),
		.opp_status			(x_status_link),
		.status				(o_status_link),
		.status_ack			(o_status_ack)
	);
	
	status_reg x_reg (
		.reset				(reset),
		.signal				(x_signal_1),
		.coodinate			(x_coodinate),
		.opp_status			(o_status_link),
		.status				(x_status_link),
		.status_ack			(x_status_ack)
	);
		
	win_teller o_teller(
		.reset				(reset),
		.status				(o_status_link),
		.signal				(o_signal),
		.win_signal			(o_win_link)
	);
	
	win_teller x_teller(
		.reset				(reset),
		.status				(x_status_link),
		.signal				(x_signal),
		.win_signal			(x_win_link)
	);
	
	always @( negedge o_signal or negedge x_signal ) begin
			o_status_check [8:0] = o_status_link [8:0];
			x_status_check [8:0] = x_status_link [8:0];
	end		

	
	always @(negedge o_signal or negedge x_signal) begin
			win_status[0] = o_win_link || (&all_status_link);
			win_status[1] = x_win_link || (&all_status_link);
	end
	
	
			
endmodule 