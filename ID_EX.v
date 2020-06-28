module ID_EX(
    input clk, reset,
    input [3:0] inst1, 
    input [4:0] inst2,
    input [63:0] ReadData1, ReadData2, IFID_PC_Out, data,
    input [1:0] ALUOp,
    input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [3:0] IDEX_inst1,
    output reg [4:0] IDEX_inst2,
    output reg [63:0] IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_imm_data,
    output reg [1:0] IDEX_ALUOp,
    output reg IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_ALUSrc, IDEX_RegWrite
);

always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
                IDEX_PC_Out = 0;
                IDEX_ReadData1 = 0;
                IDEX_ReadData2 = 0;
                IDEX_imm_data = 0;
                IDEX_inst1 = 0;
                IDEX_inst2 = 0;
                IDEX_Branch = 0;
                IDEX_MemRead = 0;
                IDEX_MemWrite = 0;
                IDEX_ALUSrc = 0;
                IDEX_RegWrite = 0;
                IDEX_ALUOp = 0;
                IDEX_MemtoReg = 0;

            end
        else
            begin

                IDEX_PC_Out = IFID_PC_Out;
                IDEX_ReadData1 = ReadData1;
                IDEX_ReadData2 = ReadData2;
                IDEX_imm_data = data;
                IDEX_inst1 = inst1;
                IDEX_inst2 = inst2;
                IDEX_Branch = Branch;
                IDEX_MemRead = MemRead;
                IDEX_MemWrite = MemWrite;
                IDEX_ALUSrc = ALUSrc;
                IDEX_RegWrite = RegWrite;
                IDEX_ALUOp = ALUOp;
                IDEX_MemtoReg = MemtoReg;

                
            end
    end

endmodule