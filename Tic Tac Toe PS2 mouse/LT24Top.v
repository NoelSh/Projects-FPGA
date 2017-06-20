module LT24Top (
    input              clock,
    input              globalReset,
    output             resetApp, // - Application Reset - for debug

    // LT24 Interface
    output             LT24_WRn,
    output             LT24_RDn,
    output             LT24_CSn,
    output             LT24_RS,
    output             LT24_RESETn,
    output [     15:0] LT24_D,
    output             LT24_LCD_ON,

	 //PS2 Interface
	 inout wire ps2d, ps2c,
	 output [7:0]  mouse_xpos,
	 output [8:0]  mouse_ypos,
	 output [9:0] leds,
	 output [41:0] SevenSeg,
	 output 			mouse_click,
	
	//Game Interface 
	 input 	[4:0]	o_score,
	 input	[4:0] x_score,
	 input 	[8:0] o_status,
	 input	[8:0] x_status,
	 input   [1:0] game_state,
	 
	 //
	 output [3:0] currentState,
	 
	 //Audio trigger(s)
	 output triggerImperialMarch
);

	//These can be edited
	
	
	localparam MOUSE_COLOUR_INT = 16'b1111111111111111;
	localparam MOUSE_COLOUR_EXT = 16'b0000000000000000;
	localparam TEXT_COLOUR = 16'b0000011111111111;
	localparam BORDER_COLOUR = 16'b1111100000011111;
	localparam CIRCLE_COLOUR = 16'b0000000000011111;
	localparam CROSS_COLOUR = 16'b0000011111100000;
	localparam BACKGROUND_COLOUR = 16'h324C;
	
	
	//End



	//LT24 
	reg  [ 7:0] xAddr      ;
	reg  [ 8:0] yAddr      ;
	wire [15:0] pixelData  ;
	reg  [15:0] pixelDataT  ;
	reg  [15:0] pixelDataM;
	wire [15:0] pixelDataW;
	wire [15:0] pixelDataBack;
	wire			Mouse_enable;
	wire        pixelReady ;
	localparam WIDTH = 240;
	localparam HEIGHT = 320;
	localparam MAX_TEXT_WIDTH = 45;
	localparam BITS_WIDTH = 8;
	localparam BITS_HEIGHT = 9;
	localparam FONT_WIDTH = 5;
	localparam FONT_HEIGHT = 7;
	localparam FONT_SPACE = 2;
	
	reg [25:0] clkCounter;
	
	wire m_done_tick;
	wire [2:0] btnm;
   wire [8:0] xm;
	wire [8:0] ym;
   
	reg [7:0] m_xPos;
	reg [8:0] m_yPos;
	assign mouse_xpos [7:0] = m_xPos [7:0];
	assign mouse_ypos [8:0] = m_yPos [8:0];
	assign mouse_click = (btnm[0]==1) ? 1'b0 : 1'b1;
	
	wire [8:0] m_xNext;
	wire [8:0] m_yNext;	
	
	wire textEN;	
	reg [7:0] binCount;
	wire [15:0] scoreASCII;

	wire targetDraw;
	wire targetHit;
	
	wire o_enable;
	wire x_enable;
	
	reg textEnable = 1'b0;
	
	
	wire [4:0] score;

	LT24Display #(
		 .WIDTH       (240        ),
		 .HEIGHT      (320        ),
		 .CLOCK_FREQ  (50000000   )
	) Display (
		 .clock       (clock      ),
		 .globalReset (globalReset),
		 .resetApp    (resetApp   ),
		 .xAddr       (xAddr      ),
		 .yAddr       (yAddr      ),
		 .pixelData   (pixelData  ),
		 .pixelWrite  (1'b1       ),
		 .pixelReady  (pixelReady ),
		 .pixelRawMode(1'b0       ),
		 .cmdData     (8'b0       ),
		 .cmdWrite    (1'b0       ),
		 .cmdDone     (1'b0       ),
		 .cmdReady    (           ),
		 .LT24_WRn    (LT24_WRn   ),
		 .LT24_RDn    (LT24_RDn   ),
		 .LT24_CSn    (LT24_CSn   ),
		 .LT24_RS     (LT24_RS    ),
		 .LT24_RESETn (LT24_RESETn),
		 .LT24_D      (LT24_D     ),
		 .LT24_LCD_ON (LT24_LCD_ON)
	);

   // instantiation
   mouse mouse_unit(
		.clk			 (clock), 
		.reset		 (globalReset), 
		.ps2d			 (ps2d),
		.ps2c			 (ps2c),
      .xm			 (xm),
		.ym			 (ym),
		.btnm			 (btnm),
      .m_done_tick (m_done_tick)
	);
	
	
/*SevenSegDisplay #(
	.WIDTH(3)
) xPos_Seg_Display(
	.bcdEnable(1'b1),
	.valueNumber({4'b0, m_xPos}),
	.displayNumber(SevenSeg[20:0])
);

SevenSegDisplay #(
	.WIDTH         (3)
) yPos_Seg_Display(
	.bcdEnable     (1'b1),
	.valueNumber   ({3'b0, m_yPos}),
	.displayNumber (SevenSeg[41:21])
);*/
	
textGenerator #(	
	.WIDTH			 (WIDTH),
	.HEIGHT			 (HEIGHT),
	.BITS_WIDTH 	 (BITS_WIDTH),
	.BITS_HEIGHT 	 (BITS_HEIGHT),
	.FONT_WIDTH 	 (FONT_WIDTH),
	.FONT_HEIGHT 	 (FONT_HEIGHT),
	.FONT_SPACE 	 (FONT_SPACE),
	.MAX_TEXT_WIDTH (MAX_TEXT_WIDTH)
) textGen (
	.clock		  (clock),
	.enable		  (textEnable),
	.xAddLCD		  (xAddr),
	.yAddLCD		  (yAddr),
	.xAddText	  (xPosString),
	.yAddText	  (yPosString), 
	.textString	  (stringBuffer),
	.stringLength (strLen),
	.textPixEN	  (textEN)
);


binaryToASCII #(
	.NIBBLE_SIZE (2)
) binaryToASCII (
	.enable      (1'b1),
	.binaryInput ({3'd0, score}),
	.acsiiOutput (scoreASCII)
);

interactionArea #(
	.SCREEN_WIDTH       (WIDTH),
	.SCREEN_HEIGHT      (HEIGHT),
	.BITS_SCREEN_WIDTH  (BITS_WIDTH),
	.BITS_SCREEN_HEIGHT (BITS_HEIGHT)
) targetArea (
	.clock			(clock),
	.enable			(1'b0),
	.positionCheck (btnm[0]),
	.xAddLCD		   (xAddr),
	.yAddLCD		   (yAddr),
	.xPos			   (180),
	.yPos   		   (200),
	.xLength		   (10),
	.yLength		   (20),
	.xPosPointer   (m_xPos),
	.yPosPointer   (m_yPos),
	.insideArea    (targetDraw),
	.areaActive	   (targetHit)
);

example_o_figure_generator #(
	.SCREEN_WIDTH       (WIDTH),
	.SCREEN_HEIGHT      (HEIGHT),
	.BITS_SCREEN_WIDTH  (BITS_WIDTH),
	.BITS_SCREEN_HEIGHT (BITS_HEIGHT)
) o_figure (
	.clock			(clock),
	.xAddLCD			(xAddr),
	.yAddLCD			(yAddr),
	.o_status		(o_status),
	.o_enable		(o_enable)
);

example_x_figure_generator #(
	.SCREEN_WIDTH       (WIDTH),
	.SCREEN_HEIGHT      (HEIGHT),
	.BITS_SCREEN_WIDTH  (BITS_WIDTH),
	.BITS_SCREEN_HEIGHT (BITS_HEIGHT)
) x_figure (
	.clock			(clock),
	.xAddLCD			(xAddr),
	.yAddLCD			(yAddr),
	.x_status		(x_status),
	.x_enable		(x_enable)
);

welcome_gen_test2 gg(
	.globalReset				(globalReset),
	.clock						(clock),
	.xAddLCD						(xAddr),
	.yAddLCD						(yAddr),
	.pixelData					(pixelDataW),
	.triggerImperialMarch 	(triggerImperialMarch)
);

background_gen BG (
	.clock			(clock),
	.xAddLCD			(xAddr),
	.yAddLCD			(yAddr),
	.pixelData		(pixelDataBack)
);


localparam S1 = 4'b0000; 
localparam S2 = 4'b0001; 
localparam S3 = 4'b0010;
localparam S4 = 4'b0011;
localparam S5 = 4'b0101;

reg [(MAX_TEXT_WIDTH*8)-1:0] stringBuffer;
reg [5:0] strLen;
reg [7:0] xPosString;
reg [8:0] yPosString;

reg [7*8:1] welcomeString = "WELCOME";

reg [(4*8)-1:1] noel = "NOEL";
reg [(12*8)-1:1] nameNoel = "Noel Shimali";
reg [(9*8)-1:1]  idNoel = "201083726";
reg [(4*8)-1:1] chen = "CHEN";
reg [(12*8)-1:1] nameChen = "Zhichao Chen";
reg [(9*8)-1:1]  idChen = "201012465";

reg [(20*8)-1:1]  info0 = "MSc Embedded Systems";
reg [(40*8)-1:1]  info1 = "ELEC5566M FPGA Design for System-on-chip";
reg [(24*8)-1:1]  info2 = "University of Leeds 2017";
	
always @ (posedge clock) begin
	clkCounter = clkCounter + 1;
end
						 
always @ (posedge clock) begin
	if(m_xNext > WIDTH && m_xNext - m_xPos<200) begin
		m_xPos <= WIDTH-1;
	end else if(m_xNext>WIDTH ) begin
		m_xPos <= 0;
	end else begin
		m_xPos <= m_xNext;
	end
end

always @ (posedge clock) begin
	if(m_yNext > HEIGHT && m_yNext - m_yPos <200) begin
		m_yPos <= HEIGHT-1;
	end else if(m_yNext > HEIGHT) begin
		m_yPos <= 0;
	end else begin	
		m_yPos <= m_yNext;
	end
end

assign m_xNext = (~m_done_tick) ? m_xPos  : m_xPos - {ym[8], ym};    // no activity  // x movement
assign m_yNext = (~m_done_tick) ? m_yPos  : m_yPos - {xm[8], xm};    // no activity  // x movement


// X Counter
always @ (posedge clock or posedge resetApp) begin
    if (resetApp) begin
        xAddr <= 8'b0;
    end else if (pixelReady) begin
        if (xAddr < (WIDTH-1)) begin
            xAddr <= xAddr + 8'd1;
        end else begin
            xAddr <= 8'b0;
        end
    end
end

// Y Counter
always @ (posedge clock or posedge resetApp) begin
    if (resetApp) begin
        yAddr <= 9'b0;
    end else if (pixelReady && (xAddr == (WIDTH-1))) begin
        if (yAddr < (HEIGHT-1)) begin
            yAddr <= yAddr + 9'd1;
        end else begin
            yAddr <= 9'b0;
        end
    end
end



reg [30:0] timer = 0;	//State timer
reg  [3:0] Y = S1;  		//Next state
reg  [3:0] y;   			//Current state

always @ (posedge clock) begin
	case (y)
		S3: begin
			textEnable = 1'b1;
			if((xAddr > 30 && xAddr < 45) && (yAddr > 40 && yAddr < 240)) begin
				stringBuffer <= welcomeString;
				strLen <= 6'd7;
				xPosString <= 35;
				yPosString <= (HEIGHT/2) + (((FONT_WIDTH * strLen) + (FONT_SPACE * (strLen - 1)))/2); // Centers the string
			end else if ((xAddr > 60 && xAddr < 70) && (yAddr > HEIGHT/2 && yAddr < HEIGHT)) begin
				stringBuffer <= nameNoel;
				strLen <= 6'd12;
				xPosString <= 61;
				yPosString <= HEIGHT - 20;
			end else if ((xAddr > 60 && xAddr < 70) && (yAddr > 0 && yAddr < HEIGHT/2)) begin
				stringBuffer <= nameChen;
				strLen <= 6'd12;
				xPosString <= 61;
				yPosString <= (FONT_WIDTH * strLen) + (FONT_SPACE * (strLen - 1)) + 20;
			end else if ((xAddr > 100 && xAddr < 110) && (yAddr > 0 && yAddr < HEIGHT)) begin
				stringBuffer <= info0;
				strLen <= 6'd20;
				xPosString <= 101;
				yPosString <= HEIGHT - 10;
			end else if ((xAddr > 110 && xAddr < 120) && (yAddr > 0 && yAddr < HEIGHT)) begin
				stringBuffer <= info1;
				strLen <= 6'd30;
				xPosString <= 111;
				yPosString <= HEIGHT - 10;
			end else if ((xAddr > 120 && xAddr < 130) && (yAddr > 0 && yAddr < HEIGHT)) begin
				stringBuffer <= info2;
				strLen <= 6'd24;
				xPosString <= 121;
				yPosString <= HEIGHT - 10;
			end
		end
		
		
		S4: begin
			textEnable = 1'b1;
			if((xAddr >= 55 && xAddr < 68) && (yAddr > 1 && yAddr < 50)) begin
				stringBuffer <= noel;
				strLen <= 6'd4;
				xPosString <= 59;
				yPosString <= ((FONT_WIDTH * strLen) + (FONT_SPACE * (strLen - 1))) + 1;
			end else if ((xAddr >= 55 && xAddr < 68) && (yAddr > 50 && yAddr <= HEIGHT)) begin 
				stringBuffer <= chen;
				strLen <= 6'd4;
				xPosString <= 59;
				yPosString <= HEIGHT-1;
			end 
			
			else if ((xAddr >= 68 && xAddr < 70) && (yAddr > 1 && yAddr < 50)) begin 
				stringBuffer <= scoreASCII;
				strLen <= 6'd2;
				xPosString <= 68;
				yPosString <= ((FONT_WIDTH * strLen) + (FONT_SPACE * (strLen - 1))) + 1;
			end 
			
			else if ((xAddr >= 68 && xAddr < 70) && (yAddr > 50 && yAddr <= HEIGHT)) begin 
				stringBuffer <= scoreASCII;
				strLen <= 6'd2;
				xPosString <= 68;
				yPosString <= HEIGHT-1;;
			end 
		end
		
		default: begin
			textEnable = 1'b0;
			stringBuffer <= "";
			strLen <= 6'd0;
			xPosString <= 0;
			yPosString <= 0;
		end
	endcase
end

always @ (posedge clock ) begin
	if (globalReset == 1'b1) begin
		pixelDataT <= 0;
		timer = 0;
		Y <= S1;
	end else begin
		case (y)
			S1: begin
				timer <= 0;
				pixelDataT <= 0;
				Y <= S2;
			end
			S2: begin
				pixelDataT <= pixelDataW;
				if (timer < 30'd 475000000) begin
					timer <= timer + 1;
				end else begin
					Y <= S3;
					timer <= 0;
				end
			end
			
			S3: begin
				pixelDataT <= pixelDataW;
				if (timer < 30'd 150000000) begin
					timer <= timer + 1;
				end else begin
					Y <= S4;
					timer <= 0;
				end
			end
			
			S4: begin
				if ((xAddr == m_xPos && yAddr == m_yPos) || (xAddr >= m_xPos && xAddr <= m_xPos +1 &&  yAddr >= m_yPos -1&& yAddr <= m_yPos) || (xAddr==m_xPos && yAddr==m_yPos-2) || (xAddr==m_xPos+2 && yAddr==m_yPos) || (xAddr==m_xPos+2 && yAddr==m_yPos-2) ||(xAddr==m_xPos+3 && yAddr==m_yPos-3)) begin
						pixelDataM <=  MOUSE_COLOUR_INT;
					end else if((xAddr==m_xPos-1 && yAddr>=m_yPos-4 && yAddr<=m_yPos+1)|| (yAddr==m_yPos+1 && xAddr>=m_xPos-1 && xAddr<=m_xPos+4)|| (yAddr==m_yPos && xAddr==m_xPos+3)||(yAddr==m_yPos-1 && xAddr==m_xPos+2)||(yAddr==m_yPos-2&& (xAddr==m_xPos+1 || xAddr==m_xPos+3))||(yAddr==m_yPos-3&& (xAddr==m_xPos || xAddr==m_xPos+2 ||xAddr==m_xPos+4))||(yAddr==m_yPos-4&& (xAddr==m_xPos+3 || xAddr==m_xPos+4))) begin
						pixelDataM <=  MOUSE_COLOUR_EXT;
					end else if(xAddr >= 78 && xAddr<=80 && yAddr<= 279 && yAddr >=41 || xAddr>= 158 && xAddr <=160 && yAddr<= 279 && yAddr >=41 ||  yAddr >= 119 && yAddr <=121 || yAddr>=199 && yAddr<=201 ) begin
						pixelDataT <=  BACKGROUND_COLOUR;
					end else begin
						pixelDataT <= pixelDataBack;
					end
			 end
		 endcase
	 end
end

always @(posedge clock) begin: State_flipflops
    if (globalReset == 1) begin      // Reset - Clear counter
        y <= S1;
    end else begin
        y <= Y;                 // Advance state
    end
end

assign currentState = y;

assign Mouse_enable=(xAddr == m_xPos && yAddr == m_yPos) || (xAddr >= m_xPos && xAddr <= m_xPos +1 &&  yAddr >= m_yPos -1&& yAddr <= m_yPos) || (xAddr==m_xPos && yAddr==m_yPos-2) || (xAddr==m_xPos+2 && yAddr==m_yPos) || (xAddr==m_xPos+2 && yAddr==m_yPos-2) ||(xAddr==m_xPos+3 && yAddr==m_yPos-3)||((xAddr == m_xPos-1 && yAddr >=m_yPos -4 && yAddr <= m_yPos +1)|| (yAddr == m_yPos +1 && xAddr>= m_xPos-1 && xAddr <=m_xPos+4)|| (yAddr==m_yPos && xAddr == m_xPos+3)||(yAddr==m_yPos-1 && xAddr==m_xPos+2)||(yAddr==m_yPos-2&& (xAddr==m_xPos+1 || xAddr==m_xPos+3))||(yAddr==m_yPos-3&& (xAddr==m_xPos || xAddr==m_xPos+2 ||xAddr==m_xPos+4))||(yAddr==m_yPos-4&& (xAddr==m_xPos+3 || xAddr==m_xPos+4)));
assign pixelData = (Mouse_enable) ? pixelDataM :(textEN) ? TEXT_COLOUR  :targetDraw ? 15'b0000011111100000  : (x_enable) ? CROSS_COLOUR : (o_enable) ? CIRCLE_COLOUR :  pixelDataT;

assign score = (yAddr < (HEIGHT / 2)) ? x_score : o_score ;
//assign score = 5'b10101;

endmodule
