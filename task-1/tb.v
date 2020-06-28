module tb(
    
);

reg clk, reset;

RISC_V_Processor r(
    .clk(clk),
    .reset(reset)

);

initial
begin
clk = 1'b1;
reset = 1'b1;
#8
reset = 1'b0;
end

always
begin
#5 clk = ~clk;
end

endmodule // tb