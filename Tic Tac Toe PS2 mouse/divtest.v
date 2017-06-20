module divtest (
	input clk,
	output [7:0] result,
	output [8:0] Count
);

reg [8:0] count = 0;

always @(posedge clk) begin
	count <= count + 1;
end

assign result = count / 7;
assign Count = count;

endmodule

