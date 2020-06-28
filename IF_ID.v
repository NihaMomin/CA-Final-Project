module IF_ID(

  input clk, reset,
  input [31:0] instruction,
  input [63:0] PC_Out,
  output reg [31:0] IFID_instruction,
  output reg [63:0] IFID_PC_Out

  );

  always @(posedge clk)
  begin
    if(reset)
      begin
        IFID_instruction = 0;
        IFID_PC_Out = 0;
      end
    else
      begin
        IFID_instruction = instruction;
        IFID_PC_Out = PC_Out;
        
      end
  end
endmodule      
    