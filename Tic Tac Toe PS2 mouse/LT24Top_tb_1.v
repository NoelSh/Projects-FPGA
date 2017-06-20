module LT24Top_tb_1;


reg 			clock;
reg 			globalReset;
wire 			resetApp;
wire 			LT24_WRn;
wire 			LT24_RDn;
wire 			LT24_CSn;
wire 			LT24_RS;
wire 			LT24_RESETn;
wire [15:0] LT24_D;
wire        LT24_LCD_ON;
wire 			ps2d;
wire 			ps2c;
wire [9:0] 	leds;
wire [41:0] SevenSeg;
reg pause;

integer i;

LT24Top DUT (
	.clock(clock),
	.globalReset(globalReset),
	.resetApp(resetApp),
	.LT24_WRn(LT24_WRn),
	.LT24_RDn(LT24_RDn),
	.LT24_CSn(LT24_CSn),
	.LT24_RS(LT24_RS),
	.LT24_RESETn(LT24_RESETn),
	.LT24_D(LT24_D),
	.LT24_LCD_ON(LT24_LCD_ON),
	.ps2d(ps2d), 
	.ps2c(ps2c),
	.leds(leds),
	.SevenSeg(SevenSeg),
	.pause(pause)
);

initial begin

	$display("\tTime,\clock,\globalReset,\resetApp,\LT24_WRn,\LT24_RDn,\LT24_CSn,\LT24_RS,\LT24_RESETn,\LT24_D,\LT24_LCD_ON,\ps2d,\ps2c,\leds,\SevenSeg,\pause");
	$monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b",$time,clock,globalReset,resetApp,LT24_WRn,LT24_RDn,LT24_CSn,LT24_RS,LT24_RESETn,LT24_D,LT24_LCD_ON,ps2d,ps2c,leds,SevenSeg,pause);
	
	#20;
	pause = 0;
	globalReset = 0;
	clock = 0;
	for(i=0; i<((320*240)*2)*60; i=i+1) begin
		clock = ~clock;
		#20;
	end

end


endmodule
