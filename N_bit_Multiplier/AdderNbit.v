module AdderNbit #(
	parameter N = 8 //Number of bits in adder (default 8)
)( 
	input [N-1:0] a,
	input [N-1:0] b,
	input cin,
	output [N-1:0] sum,
	output cout
); 

	wire carry[N-2:0];

	genvar i; //Generate variable to be used in the for loop 

	generate 

		for (i = 0; i < N; i = i + 1) begin : loop_name 
		//Instantiate "N" FullAdder modules         
			
			if(i==0)begin
				FullAdder inst ( 
					.cin(cin), 
					.a(a[i]),
					.b(b[i]),
					.sum(sum[i]),
					.cout(carry[i])
				); 
			end else if (i < N-1)begin
				FullAdder inst ( 
					.cin(carry[i-1]), 
					.a(a[i]),
					.b(b[i]),
					.sum(sum[i]),
					.cout(carry[i])
				); 
			end else begin
				FullAdder inst ( 
					.cin(carry[i-1]), 
					.a(a[i]),
					.b(b[i]),
					.sum(sum[i]),
					.cout(cout)
				);
			end
			
		end 
		
	endgenerate 

endmodule