module ImmGen(
input [31:0] ins,
output reg [63:0] data
);
always @(*)
begin
case (ins[6:5])

	2'b00 : data = {{52{ins[31]}},ins[31:20]};
	
	2'b01 : data = {{52{ins[31]}},{ins[31:25],ins[11:7]}};
	
	default : data = {{52{ins[31]}},{ins[31],ins[7],ins[30:25],ins[11:8]}};
	
	
	
endcase	

end

endmodule


