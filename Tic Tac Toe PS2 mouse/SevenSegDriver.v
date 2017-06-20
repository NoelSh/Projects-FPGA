module SevenSegDriver(
	input 		[3:0] number,
	output reg	[6:0]	segment
);
	always@(number)
	begin
		case(number)
			4'b1111: begin //0
				segment = 7'b1000000; end
			4'b1110: begin	//1
				segment = 7'b1111001; end
			4'b1101: begin	//2
				segment = 7'b0100100; end
			4'b1100: begin	//3
				segment = 7'b0110000; end
			4'b1011: begin	//4
				segment = 7'b0011001; end
			4'b1010: begin	//5
				segment = 7'b0010010; end
			4'b1001: begin	//6
				segment = 7'b0000010; end
			4'b1000: begin	//7
				segment = 7'b1111000; end
			4'b0111: begin	//8
				segment = 7'b0000000; end
			4'b0110: begin	//9
				segment = 7'b0010000; end
			4'b0101: begin	//A
				segment = 7'b0001000; end
			4'b0100: begin	//B
				segment = 7'b0000011; end
			4'b0011: begin	//C
				segment = 7'b1000110; end
			4'b0010: begin	//D
				segment = 7'b0100001; end
			4'b0001: begin	//E
				segment = 7'b0000110; end
			4'b0000: begin	//F
				segment = 7'b0001110; end
			default: begin //display nothing
				segment = 7'b1111111; end
		endcase
	end
endmodule