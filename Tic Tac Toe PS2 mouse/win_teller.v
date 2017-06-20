/*============================================================
*	8 possible ways to win. Displayed below:

			+---+---+---+			+---+---+---+			+---+---+---+
			| x | x | x |        |   |   |   |			|   |   |   |
			+---+---+---+        +---+---+---+			+---+---+---+
			|   |   |   |			| x | x | x |			|   |   |   |
			+---+---+---+			+---+---+---+			+---+---+---+
			|   |   |   |			|   |   |   |			| x | x | x |
			+---+---+---+			+---+---+---+			+---+---+---+
			
			
			+---+---+---+			+---+---+---+			+---+---+---+
			| x |   |   |        |   | x |   |			|   | x |   |
			+---+---+---+        +---+---+---+			+---+---+---+
			| x |   |   |			|   | x |   |			|   | x |   |
			+---+---+---+			+---+---+---+			+---+---+---+
			| x |   |   |			|   | x |   |			|   | x |   |
			+---+---+---+			+---+---+---+			+---+---+---+
			


			+---+---+---+			+---+---+---+
			| x |   |   |        |   |   | x |
			+---+---+---+        +---+---+---+
			|   | x |   |			|   | x |   |
			+---+---+---+			+---+---+---+
			|   |   | x |			| x |   |   |
			+---+---+---+			+---+---+---+	
			
*	All condition is specified in always block; 
	Win signal = 1 when any of it satisfired 

============================================================*/
module win_teller (
	input 					reset,
	input 		[8:0] 	status,
	input 					signal,
	
	
	output reg 				win_signal
	);
	reg 			[7:0] 	win_cdt;


	always @* begin
		win_cdt[0] = & status[2:0];
		win_cdt[1] = & status[5:3];
		win_cdt[2] = & status[8:6];
		win_cdt[3] = &{status[0],status[3],status[6]};
		win_cdt[4] = &{status[1],status[4],status[7]};
		win_cdt[5] = &{status[2],status[5],status[8]};
		win_cdt[6] = &{status[0],status[4],status[8]};
		win_cdt[7] = &{status[2],status[4],status[6]};
		win_signal = |win_cdt;
	end
	
endmodule 