module imperialMarchTone #(
	parameter CLOCK_FREQUENCY = 50000000,
	parameter ADDRESS_BITS = 7
)(
	input clock,
	input reset,
	input enable,
	input trigger,
	output sound
);

	reg [25:0] count = 0;
	wire [20:0] toneFrequency;
	reg tnClock = 1'b0;

	reg toneEnable = 1'b0;
	reg [29:0] toneCount = 0;
	reg [1:0] toneState;


	reg [ADDRESS_BITS-1:0] keyAddress = 0;
	reg [ADDRESS_BITS-1:0] timeAddress = 1;

	wire [15:0] keyOutput;
	wire [15:0] timeOutput;

	reg [ADDRESS_BITS-1:0] toneLength;

	imperialMarchROM (
		.address_a(keyAddress),
		.address_b(timeAddress),
		.clock(clock),
		.q_a(keyOutput),
		.q_b(timeOutput)
	);

	keyNoteFrequency # (
		.CLOCK_FREQUENCY(50000000)
	) keyNoteFrequency (
		.key(keyOutput [6:0]),
		.frequencyCount(toneFrequency)
	);

	always @ (posedge clock) begin
		if (reset == ~1'b1) begin
			toneState <= 2'd1;
			toneCount <= 0;
			toneEnable <= 0;
			keyAddress <= 0;
			timeAddress <= 1;	
		end else if (enable == 1'b1) begin
			case (toneState)
				2'd0: begin
					toneState <= 2'd1;
					toneCount <= 0;
					toneEnable <= 0;
					keyAddress <= 0;
					timeAddress <= 1;	
				end
				2'd1: begin
					if(trigger == ~1'b1) begin
						toneLength <= keyOutput[6:0];
						keyAddress <= 2;
						timeAddress <= 3;
						toneState <= 2'd2;
						toneCount <= 0;
						toneEnable <= 0;
					end
				end
				2'd2: begin
					if(toneLength > 0) begin
						if(keyOutput [6:0] > 0) begin
							toneEnable <= 1;
						end else begin
							toneEnable <= 0;
						end
						if(toneCount < ((CLOCK_FREQUENCY/1000)*timeOutput)) begin
							toneCount <= toneCount + 1;
							toneState <= 2'd2;
						end else begin
							toneState <= 2'd3;
							toneCount <= 0;
						end
					end else begin
						toneState <= 2'd0;
					end
				end
				2'd3: begin
					keyAddress <= keyAddress + 7'd2;
					timeAddress <= timeAddress + 7'd2;
					toneState <= 2'd2;
					toneLength <= toneLength - 1;
					toneCount <= 0;
				end
			endcase
		end
	end

	always @ (posedge clock) begin
		if(toneEnable == 1'b1) begin
			if(count < (toneFrequency/2)) begin
				count <= count + 1;
			end else begin
				count <= 0;
				tnClock <= ~tnClock;
			end
		end else begin
			count <= 0;
			tnClock <= 0;
		end
	end

	assign sound = tnClock;

endmodule
