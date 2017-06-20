module asciitest(
	input clk,
	output [7:0] value
);

localparam width = 8;

reg [(8*8)-1:0]string = "abcABC!?";

reg [2:0] count = 0;

reg [7:0] valueR;


always @ (posedge clk) begin
	count <= count + 1;
	//valueR = string[((count+1)*8)-1:count*8];
	valueR = string[(((count+1)*width)-1) -:width];
end

assign value = valueR;


endmodule


