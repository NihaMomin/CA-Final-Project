module tb();
  
reg clk,reset;

pipeline risc(.clk(clk),.reset(reset));




initial
begin
  
  clk = 1'd0;
  reset = 1'd1;
  #10
  reset = 1'd0;
  
end

always #5 clk =~clk;

endmodule  