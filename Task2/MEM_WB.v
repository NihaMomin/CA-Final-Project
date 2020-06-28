module MEM_WB(
input [1:0] EXMEM_ALUOp,
input Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,clk,reset,
input [63:0] Read_Data,
input [63:0] EXMEM_Result,
input [4:0] EXMEM_inst2,
output reg MEMWB_Branch, MEMWB_MemRead, MEMWB_MemtoReg, MEMWB_MemWrite, MEMWB_ALUSrc, MEMWB_RegWrite,
output reg [1:0] MEMWB_ALUOp,
output reg [63:0] MEMWB_Read_Data,
output reg [63:0] MEMWB_Result,
output reg [4:0] MEMWB_inst2

);





always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
                MEMWB_Result = 0;
                MEMWB_Read_Data = 0;
                MEMWB_inst2 = 0;
                MEMWB_Branch = 0;
                MEMWB_MemRead = 0;
                MEMWB_MemWrite = 0;
                MEMWB_ALUSrc = 0;
                MEMWB_RegWrite = 0;
                MEMWB_ALUOp = 0;
                MEMWB_MemtoReg = 0;
            end
        else
            begin
                
                MEMWB_Result = EXMEM_Result;
                MEMWB_Read_Data = Read_Data;
                MEMWB_inst2 = EXMEM_inst2;
                MEMWB_Branch = Branch;
                MEMWB_MemRead = MemRead;
                MEMWB_MemWrite = MemWrite;
                MEMWB_ALUSrc = ALUSrc;
                MEMWB_RegWrite = RegWrite;
                MEMWB_ALUOp = EXMEM_ALUOp;
                MEMWB_MemtoReg = MemtoReg;

            end
    end


endmodule