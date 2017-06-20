module Top_level (
    input              	clock,
	 input					clock1, 				// [New clock]
    input              	globalReset_local,
	 input					regReset_local,
    output             	resetApp, 			// - Application Reset - for debug
    // LT24 Interface
    output             	LT24_WRn,
    output             	LT24_RDn,
    output             	LT24_CSn,
    output             	LT24_RS,
    output             	LT24_RESETn,
    output 		[15:0] 	LT24_D,
    output             	LT24_LCD_ON,

	 //PS2 Interface
	 inout wire ps2d, ps2c,
	 output [9:0] leds,
	 output [41:0] SevenSeg,
	 
	 // Communication
	 input		[3:0] 	oppo_chesspos_rx, // [New input] Through GPIO from other board
	 input					oppo_click_rx,		// [New input] Through GPIO, mouse click from other board
	 input					globalReset_rx,	// [New input] Through GPIO from other board; Reset everything
	 input 					regReset_rx,		// [New input] Through GPIO from other board; just reset the status_reg
	 output		[3:0]		local_chesspos_tx,// [New output] Transmit the coodinate to other board
	 output					local_click_tx,	// [New output] Transmit the click to other board
	 output              globalReset_tx,	// [New output] Transmit GlobalReset signal
	 output 					regReset_tx,			// [New output] Thansmit regReset signal
	 // Used to imitate oppo
	 
	 //Score
	
	 
	 //Audio,
	 output 		audio_pin
	 
);
//	Tx =======================
		assign local_chesspos_tx 	= local_chesspos;
		assign local_click_tx 		= mouse_click;
		assign globalReset_tx		= globalReset_tx_link;
		assign globalReset_tx_link	= globalReset_local;
		assign regReset_tx			= regReset_tx_link;
		assign regReset_tx_link		= regReset_local;
		 
		wire		  globalReset_tx_link;
		wire 		  regReset_tx_link;
// Rx	======================
		assign globalReset 			= globalReset_local || globalReset_rx;
		assign regReset				= regReset_local    || regReset_rx;
		wire		  globalReset;
		wire		  regReset;
		
		
		
		wire [7:0] mouse_xpos;
		wire [8:0] mouse_ypos;
		wire 		  mouse_click; /* Attention this is the positive signal different from keys on the board */
		wire [3:0] local_chesspos;
		wire [8:0] o_status_link;
		wire [8:0] x_status_link;
		wire [1:0] win_status_link;
		wire [1:0] game_state_link;
		wire [4:0] o_score_link;
		wire [4:0] x_score_link;
		wire		  pulse;
		wire		  pulse1;
		wire[3:0] currentState;
		wire  	  ResetforTTT;
		wire imperialMarchEN;
		wire audioImperialMarch;
		wire triggerImperialMarch;
		
		wire winnerToneEN;
		wire triggerWinnerTone;
		wire audioWinnerTone;
		
		
		wire o_win;
		wire x_win;
		
		

		wire winner;
		
LT24Top Display(
	.clock						(clock),
	.globalReset				(globalReset),
	.resetApp					(resetApp),
	.LT24_WRn					(LT24_WRn),
	.LT24_RDn					(LT24_RDn),
	.LT24_CSn					(LT24_CSn),
	.LT24_RS						(LT24_RS),
	.LT24_RESETn				(LT24_RESETn),
	.LT24_D						(LT24_D),
	.LT24_LCD_ON				(LT24_LCD_ON),
	.ps2d							(ps2d),
	.ps2c							(ps2c),
	/*.leds						(leds),*/
	.mouse_xpos					(mouse_xpos),			// [New output port] Transmit mouse position to position convertor
	.mouse_ypos					(mouse_ypos),			// [New output port] Transmit mouse position to position convertor
	.mouse_click				(mouse_click),			// [New output port] Transmit mouse click signal
	.o_score						(o_score_link),		// [New input port] Transmit scores
	.x_score						(x_score_link),		// [New input port] Transmit scores
	.o_status					(o_status_link),		// [New input port] Transmit chess status
	.x_status					(x_status_link),		// [New input port] Transmit chess status
	.game_state					(game_state_link),
	.currentState           (currentState),
	.triggerImperialMarch 	(triggerImperialMarch)
);

mouse_pos_convertor convertor (
	.mouse_xpos			(mouse_xpos),
	.mouse_ypos			(mouse_ypos),
	.chesspos			(local_chesspos)
);

SevenSegDisplay #(
	.WIDTH				(2)
) chesspositon (
	.bcdEnable			(1),
	.valueNumber		({4'b0,local_chesspos[3:0]}),
	.displayNumber		(SevenSeg[13:0])
);

SevenSegDisplay #(
	.WIDTH				(2)
) winstatus (
	.bcdEnable			(1),
	.valueNumber		({6'b0,win_status_link[1:0]}),
	.displayNumber		(SevenSeg[27:14])
);

SevenSegDisplay #(
	.WIDTH				(2)
) gamestate (
	.bcdEnable			(1),
	.valueNumber		({6'b0,o_score_link[1:0]}),
	.displayNumber		(SevenSeg[41:28])
);

TicTacToe GameLogic (
	.clock				(clock1),
	.reset				(ResetforTTT), /*Change '0' to 'reg_reset'*/
	.o_signal			(mouse_click),
	.x_signal			(oppo_click_rx),			/* Swap this in the other device*/
	.o_coodinate		(local_chesspos),
	.x_coodinate		(oppo_chesspos_rx),	
	.o_status_check	(o_status_link),
	.x_status_check   (x_status_link),
	.win_status			(win_status_link),
	.game_state_t		(game_state_link),
);	

score_registor  #
(	.player(0)
)o_score(
	.globalReset		(globalReset),
	.win_signal			(win_status_link),
	.score				(o_score_link),
);

score_registor  #
(	.player(1)
)x_score(
	.globalReset		(globalReset),
	.win_signal			(win_status_link),
	.score				(x_score_link),
);

imperialMarchTone #(
	.CLOCK_FREQUENCY(50000000),
	.ADDRESS_BITS(7)
) imperialMarchTone (
	.clock(clock),
	.reset(~globalReset),
	.enable(imperialMarchEN),
	.trigger(~triggerImperialMarch),
	.sound(audioImperialMarch)
);

winnerTone #(
	.CLOCK_FREQUENCY(50000000),
	.ADDRESS_BITS(7)
) winnerTone (
	.clock(clock),
	.reset(~globalReset),
	.enable(winnerToneEN),
	.trigger(pulse1),
	.sound(audioWinnerTone)
);

level_to_pulse  game_complete_pulse (
	.clock(clock),
	.globalReset(globalReset),
	.level(winner),
	.pulse(pulse)
);

assign local_chesspos_tx = local_chesspos;
assign leds[0] 			 = mouse_click;
assign leds[1] = triggerImperialMarch;
assign leds[2] = o_win;

assign imperialMarchEN = (currentState == 4'b0001) ? 1'b1 : 1'b0;
assign winnerToneEN = (currentState == 4'b0011) ? 1'b1 : 1'b0;
assign ResetforTTT = ~(globalReset || regReset);
assign o_win = (win_status_link == 2'b01) ? 1'b1 : 1'b0;


assign winner = win_status_link[0] || win_status_link[1];



assign pulse1 = (pulse==1 ? 1'b0 : 1'b1);
assign audio_pin = (currentState == 4'b0001) ? audioImperialMarch : (currentState == 4'b0011) ? audioWinnerTone : 1'b0;


endmodule 
