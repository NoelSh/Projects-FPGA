module welcome_gen_test2 # (
		parameter 			Timing = 80,
		parameter 			s1_time = 20,
		parameter 			s2_time = 80,
		parameter 			s3_time = 96,
		parameter 			Speed	 = (240+32)/(Timing-s1_time)

)(
		input 				globalReset,
		input 				clock,
		input 	[9:0]		xAddLCD,
		input		[8:0] 	yAddLCD,
		output	[15:0]	pixelData,
		
		output reg triggerImperialMarch
		
);


wire [16:0] address1;
wire [16:0] address2;
wire [16:0] address3;

wire [15:0] pixelData1;
wire [15:0] pixelData2;
wire [15:0] pixelData3;

wire [15:0] pixelData1_1;
wire [15:0] pixelData2_1;
wire [15:0] pixelData3_1;

reg  [30:0] timer_fast=0;
reg  [10:0] timer_slow=0;

Text1ROM  (
	.address	(address1),
	.clock	(clock),
	.q			(pixelData1)
);	
Text2ROM  (
	.address	(address2),
	.clock	(clock),
	.q			(pixelData2)
);	

backgound_gen (
	.address	(address3),
	.clock	(clock),
	.q			(pixelData3)
);


always @ (posedge clock) begin
	if (globalReset == 1) begin
		timer_fast = 0;
		timer_slow = 0;
	end else begin
		timer_fast = timer_fast +1'b1 ;
		if (timer_fast> 23'b10011000100101101000000) begin
			timer_slow=timer_slow+1;
			timer_fast =0;
		end 
	end
end


always @ (timer_slow) begin
	if(timer_slow == 11'd20) begin
		triggerImperialMarch <= 1'b1;
	end else begin
		triggerImperialMarch <= 1'b0;
	end
end

assign address1 = (299 - yAddLCD) + 280 * (xAddLCD - 90) ;
assign pixelData1_1 = (yAddLCD <= 299 && yAddLCD >=20 && xAddLCD>=90 && xAddLCD <=149) ? pixelData1 : 16'b0000000000000000;	

assign address2 = (267 - yAddLCD) + 217 * (xAddLCD -(-(timer_slow-s1_time)* Speed + 240)) ;
assign pixelData2_1 = (yAddLCD<=267 && yAddLCD >=51 && xAddLCD >= (-(timer_slow-s1_time)* Speed + 240) && xAddLCD <=(-(timer_slow-s1_time)* Speed + 240)+ 31) ? pixelData2 : 16'b0000000000000000;	

assign address3 = (319 - yAddLCD) + 320 * xAddLCD;
assign pixelData3_1 = (yAddLCD <159 + (timer_slow-s2_time)*10 && yAddLCD >= 160 -(timer_slow-s2_time)*10)? pixelData3 : 16'b0000000000000000;

assign pixelData = (timer_slow <= s1_time ) ? pixelData1_1 : (timer_slow <= s2_time)? pixelData2_1: (timer_slow <= s3_time )?pixelData3_1 : pixelData3;

endmodule 