module EX_MEM(

input [63:0] out,
input ZERO,clk,reset,
input [63:0] Result,
input [63:0] IDEX_ReadData2,
input [4:0] IDEX_inst2,
input [1:0] IDEX_ALUOp,
input Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,
output reg EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg, EXMEM_MemWrite, EXMEM_ALUSrc, EXMEM_RegWrite,
output reg [1:0] EXMEM_ALUOp,
output reg EXMEM_ZERO,
output reg [63:0] EXMEM_Result,
output reg [63:0] EXMEM_ReadData2, EXMEM_out,
output reg [4:0] EXMEM_inst2




);


always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
                EXMEM_out = 0;
                EXMEM_Result = 0;
                EXMEM_ZERO = 0;   
                EXMEM_ReadData2 = 0;
                EXMEM_inst2 = 0;
                EXMEM_Branch = 0;
                EXMEM_MemRead = 0;
                EXMEM_MemWrite = 0;
                EXMEM_ALUSrc = 0;
                EXMEM_RegWrite = 0;
                EXMEM_ALUOp = 0;
                EXMEM_MemtoReg = 0;

            end
        else
            begin

                EXMEM_out = out;
                EXMEM_Result = Result;
                EXMEM_ZERO = ZERO;
                EXMEM_ReadData2 = IDEX_ReadData2;
                EXMEM_inst2 = IDEX_inst2;
                EXMEM_Branch = Branch;
                EXMEM_MemRead = MemRead;
                EXMEM_MemWrite = MemWrite;
                EXMEM_ALUSrc = ALUSrc;
                EXMEM_RegWrite = RegWrite;
                EXMEM_ALUOp = IDEX_ALUOp;
                EXMEM_MemtoReg = MemtoReg;

                
            end
    end



endmodule