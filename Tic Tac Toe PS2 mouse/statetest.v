module statetest (
	input clock,
	input reset,
	output [3:0] state,
	output [7:0] Timer
);

reg [7:0] timer;

localparam S1 = 4'b0001;
localparam S2 = 4'b0010;
localparam S3 = 4'b0100;
localparam S4 = 4'b1000;

reg [3:0] y;
reg [3:0] Y = S1;



always @ (posedge clock) begin
	
	case (y)
		
		S1: begin
			timer = 0;
			Y = S2;
		end
		
		S2: begin
			if(timer < 8'b01111111) begin
				timer = timer + 1;
			end else begin
				Y = S3;
				timer = 0;
			end
		end
		
		S3: begin
		
		end
	endcase

end



always @(posedge clock) begin
	if(reset == 1) begin
		y = S1;
	end else begin
		y = Y;
	end	
end


assign state = y;
assign Timer=timer;

endmodule


