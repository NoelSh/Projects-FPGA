module keyNoteFrequency # (
	parameter CLOCK_FREQUENCY = 50000000
)(
	input [6:0] key,
	output [20:0] frequencyCount
);

	reg [20:0] freqReg;

	always @ (key) begin
		case (key)
			7'd1: begin
				freqReg <= CLOCK_FREQUENCY / 27.5;
			end
			7'd2: begin
				freqReg <= CLOCK_FREQUENCY / 29.1353;
			end
			7'd3: begin	
				freqReg <= CLOCK_FREQUENCY / 30.8677;
			end
			7'd4: begin
				freqReg <= CLOCK_FREQUENCY / 32.7032;
			end
			7'd5: begin
				freqReg <= CLOCK_FREQUENCY / 34.6479;
			end
			7'd6: begin
				freqReg <= CLOCK_FREQUENCY / 36.7081;
			end
			7'd7: begin
				freqReg <= CLOCK_FREQUENCY / 38.8909;
			end
			7'd8: begin
				freqReg <= CLOCK_FREQUENCY / 41.2035;
			end
			7'd9: begin
				freqReg <= CLOCK_FREQUENCY / 43.6536;
			end
			7'd10: begin
				freqReg <= CLOCK_FREQUENCY / 46.2493;
			end
			7'd11: begin
				freqReg <= CLOCK_FREQUENCY / 48.9995;
			end
			7'd12: begin
				freqReg <= CLOCK_FREQUENCY / 51.913;
			end
			7'd13: begin
				freqReg <= CLOCK_FREQUENCY / 55;
			end
			7'd14: begin
				freqReg <= CLOCK_FREQUENCY / 58.2705;
			end
			7'd15: begin
				freqReg <= CLOCK_FREQUENCY / 61.7354;
			end
			7'd16: begin
				freqReg <= CLOCK_FREQUENCY / 65.4064;
			end
			7'd17: begin
				freqReg <= CLOCK_FREQUENCY / 69.2957;
			end
			7'd18: begin
				freqReg <= CLOCK_FREQUENCY / 73.4162;
			end
			7'd19: begin
				freqReg <= CLOCK_FREQUENCY / 77.7817;
			end
			7'd20: begin
				freqReg <= CLOCK_FREQUENCY / 82.4069;
			end
			7'd21: begin
				freqReg <= CLOCK_FREQUENCY / 87.3071;
			end
			7'd22: begin
				freqReg <= CLOCK_FREQUENCY / 92.4986;
			end
			7'd23: begin
				freqReg <= CLOCK_FREQUENCY / 97.9989;
			end
			7'd24: begin
				freqReg <= CLOCK_FREQUENCY / 103.826;
			end
			7'd25: begin
				freqReg <= CLOCK_FREQUENCY / 110;
			end
			7'd26: begin
				freqReg <= CLOCK_FREQUENCY / 116.541;
			end
			7'd27: begin
				freqReg <= CLOCK_FREQUENCY / 123.471;
			end
			7'd28: begin
				freqReg <= CLOCK_FREQUENCY / 130.813;
			end
			7'd29: begin
				freqReg <= CLOCK_FREQUENCY / 138.591;
			end
			7'd30: begin
				freqReg <= CLOCK_FREQUENCY / 146.832;
			end
			7'd31: begin
				freqReg <= CLOCK_FREQUENCY / 155.563;
			end
			7'd32: begin
				freqReg <= CLOCK_FREQUENCY / 164.814;
			end
			7'd33: begin
				freqReg <= CLOCK_FREQUENCY / 174.614;
			end
			7'd34: begin
				freqReg <= CLOCK_FREQUENCY / 184.997;
			end
			7'd35: begin
				freqReg <= CLOCK_FREQUENCY / 195.998;
			end
			7'd36: begin
				freqReg <= CLOCK_FREQUENCY / 207.652;
			end
			7'd37: begin
				freqReg <= CLOCK_FREQUENCY / 220;
			end
			7'd38: begin
				freqReg <= CLOCK_FREQUENCY / 233.082;
			end
			7'd39: begin
				freqReg <= CLOCK_FREQUENCY / 246.942;
			end
			7'd40: begin
				freqReg <= CLOCK_FREQUENCY / 261.626;
			end
			7'd41: begin
				freqReg <= CLOCK_FREQUENCY / 277.183;
			end
			7'd42: begin
				freqReg <= CLOCK_FREQUENCY / 293.665;
			end
			7'd43: begin
				freqReg <= CLOCK_FREQUENCY / 311.127;
			end
			7'd44: begin
				freqReg <= CLOCK_FREQUENCY / 329.628;
			end
			7'd45: begin
				freqReg <= CLOCK_FREQUENCY / 349.228;
			end
			7'd46: begin
				freqReg <= CLOCK_FREQUENCY / 369.994;
			end
			7'd47: begin
				freqReg <= CLOCK_FREQUENCY / 391.995;
			end
			7'd48: begin
				freqReg <= CLOCK_FREQUENCY / 415.305;
			end
			7'd49: begin
				freqReg <= CLOCK_FREQUENCY / 440;
			end
			7'd50: begin
				freqReg <= CLOCK_FREQUENCY / 466.164;
			end
			7'd51: begin
				freqReg <= CLOCK_FREQUENCY / 493.883;
			end
			7'd52: begin
				freqReg <= CLOCK_FREQUENCY / 523.251;
			end
			7'd53: begin
				freqReg <= CLOCK_FREQUENCY / 554.365;
			end
			7'd54: begin
				freqReg <= CLOCK_FREQUENCY / 587.33;
			end
			7'd55: begin
				freqReg <= CLOCK_FREQUENCY / 622.254;
			end
			7'd56: begin
				freqReg <= CLOCK_FREQUENCY / 659.255;
			end
			7'd57: begin
				freqReg <= CLOCK_FREQUENCY / 698.456;
			end
			7'd58: begin
				freqReg <= CLOCK_FREQUENCY / 739.989;
			end
			7'd59: begin
				freqReg <= CLOCK_FREQUENCY / 783.991;
			end
			7'd60: begin
				freqReg <= CLOCK_FREQUENCY / 830.609;
			end
			7'd61: begin
				freqReg <= CLOCK_FREQUENCY / 880;
			end
			7'd62: begin
				freqReg <= CLOCK_FREQUENCY / 932.328;
			end
			7'd63: begin
				freqReg <= CLOCK_FREQUENCY / 987.767;
			end
			7'd64: begin
				freqReg <= CLOCK_FREQUENCY / 1046.5;
			end
			7'd65: begin
				freqReg <= CLOCK_FREQUENCY / 1108.73;
			end
			7'd66: begin
				freqReg <= CLOCK_FREQUENCY / 1174.66;
			end
			7'd67: begin
				freqReg <= CLOCK_FREQUENCY / 1244.51;
			end
			7'd68: begin
				freqReg <= CLOCK_FREQUENCY / 1318.51;
			end
			7'd69: begin
				freqReg <= CLOCK_FREQUENCY / 1396.91;
			end
			7'd70: begin
				freqReg <= CLOCK_FREQUENCY / 1479.98;
			end
			7'd71: begin
				freqReg <= CLOCK_FREQUENCY / 1567.98;
			end
			7'd72: begin
				freqReg <= CLOCK_FREQUENCY / 1661.22;
			end
			7'd73: begin
				freqReg <= CLOCK_FREQUENCY / 1760;
			end
			7'd74: begin
				freqReg <= CLOCK_FREQUENCY / 1864.66;
			end
			7'd75: begin
				freqReg <= CLOCK_FREQUENCY / 1975.53;
			end
			7'd76: begin
				freqReg <= CLOCK_FREQUENCY / 2093;
			end
			7'd77: begin
				freqReg <= CLOCK_FREQUENCY / 2217.46;
			end
			7'd78: begin
				freqReg <= CLOCK_FREQUENCY / 2349.32;
			end
			7'd79: begin
				freqReg <= CLOCK_FREQUENCY / 2489.02;
			end
			7'd80: begin
				freqReg <= CLOCK_FREQUENCY / 2637.02;
			end
			7'd81: begin
				freqReg <= CLOCK_FREQUENCY / 2793.83;
			end
			7'd82: begin
				freqReg <= CLOCK_FREQUENCY / 2959.96;
			end
			7'd83: begin
				freqReg <= CLOCK_FREQUENCY / 3135.96;
			end
			7'd84: begin
				freqReg <= CLOCK_FREQUENCY / 3322.44;
			end
			7'd85: begin
				freqReg <= CLOCK_FREQUENCY / 3520;
			end
			7'd86: begin
				freqReg <= CLOCK_FREQUENCY / 3729.31;
			end
			7'd87: begin
				freqReg <= CLOCK_FREQUENCY / 3951.07;
			end
			7'd88: begin
				freqReg <= CLOCK_FREQUENCY / 4186.01;
			end
			default: begin
				freqReg <= 0;
			end
		endcase
	end
	
	assign frequencyCount = freqReg;

endmodule

