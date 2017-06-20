module mouse_pos_convertor (

	 input 	[7:0]			mouse_xpos,
	 input	[8:0]			mouse_ypos,
	 output 	reg [3:0]			chesspos
);

always @(mouse_xpos or mouse_ypos) begin
		if (		    mouse_ypos < 119 &&	mouse_ypos >41	&& mouse_xpos <78) begin
			chesspos = 2;
		end else if (mouse_ypos > 121 && mouse_ypos <199&& mouse_xpos <78) begin
			chesspos = 1;
		end else if (mouse_ypos > 201 && mouse_ypos <279&& mouse_xpos <78) begin
			chesspos = 0;
		end else if (mouse_ypos < 119 &&	mouse_ypos >41		&& mouse_xpos >80	&& mouse_xpos <158) begin
			chesspos = 5;
		end else if (mouse_ypos > 121 && mouse_ypos <199&& mouse_xpos >80	&& mouse_xpos <158) begin
			chesspos = 4;
		end else if (mouse_ypos > 201 && mouse_ypos <279&& mouse_xpos >80	&& mouse_xpos <158) begin
			chesspos = 3;
		end else if (mouse_ypos < 119 &&	mouse_ypos >41		&& mouse_xpos >160) begin
			chesspos = 8;
		end else if (mouse_ypos > 121 && mouse_ypos <199&& mouse_xpos >160) begin
			chesspos = 7;
		end else if (mouse_ypos > 201 && mouse_ypos <279&& mouse_xpos >160) begin
			chesspos = 6;
		end else begin
			chesspos = 15;
		end
end
		
		

endmodule 