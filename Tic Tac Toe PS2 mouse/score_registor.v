module score_registor #(
	parameter player = 0
)(
	input 					globalReset,
	input			[1:0]		win_signal,
	output reg	[4:0] 	score = 5'b00000
);

	wire winSig;

	always @(posedge globalReset or posedge winSig) begin
			if (globalReset == 1'b1) begin
				score = 5'b00000;
			end else begin
				score = score + 1'b1;
			end
	end
	
	assign winSig = (~(win_signal[1]&&win_signal[0]))&&win_signal[player];	
	
endmodule
