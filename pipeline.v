module pipeline(
  
input clk,reset

);  



// Adder 1 with Pc and mux 1 inputs
wire [63:0] out1;  ///// OUTPUT OF ADDER1 to MUX1
wire PCSrc;       //////  SEL of MUX 1
wire [63:0] b;      
assign b = 64'd4;


///// Mux1
wire [63:0] data_out;   ////// OUTPUT OF MUX 1 to PC

//// PC COUNTER
wire [63:0] PC_Out; ///// Output of PC to Adder 1 and Inst memory


///// INSTRUCTION MEMORY
wire [31:0] Instruction;  ///// Output of Instruction memory

////// IFID
wire [31:0] IFID_instruction;   //// OUTPUT OF IFID 
wire [63:0] IFID_PC_Out;


/////// INSTRUCTION PARSER
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] func3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] func7;


//////////// REGISTER FILE

wire [63:0] ReadData1;
wire [63:0] ReadData2;
wire [63:0] data_out3;  // output of mux3 to register file(writedata)



///////// IMM GEN
wire [63:0] data;   ///////OUPUT OF IMMGEN


///// Control Unit 
wire [1:0] ALUOp;  // Output of control unit and input of ALU_Control
wire Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;

/////// ID/EX
wire [3:0] inst1;
wire [4:0] inst2;
wire IDEX_Branch, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_ALUSrc, IDEX_RegWrite;
wire [1:0] IDEX_ALUOp;
wire [63:0] IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_imm_data;
wire [3:0] IDEX_inst1;
wire [4:0] IDEX_inst2;



assign inst1 = {IFID_instruction[30] ,IFID_instruction[14:12]};



////////// Adder 2
wire [63:0] b1;   ///// 
assign b1 = IDEX_imm_data << 1;
wire [63:0] out2; /// OUTPUT OF Adder 2

//////// mux 2

wire [63:0] data_out2;

////////ALU CONTROL
wire [3:0] Operation;

/////// ALU 64

wire ZERO;
wire [63:0] Result;

///////// EXMEM

wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemtoReg, EXMEM_MemWrite, EXMEM_ALUSrc, EXMEM_RegWrite;
wire [1:0] EXMEM_ALUOp;
wire EXMEM_ZERO;
wire [63:0] EXMEM_Result;
wire [63:0] EXMEM_ReadData2, EXMEM_out;
wire [4:0] EXMEM_inst2;
assign PCSrc = EXMEM_Branch & EXMEM_ZERO;
////// DATA MEMORY
wire [63:0] Read_Data;



/////// MEM/WB

wire MEMWB_Branch, MEMWB_MemRead, MEMWB_MemtoReg, MEMWB_MemWrite, MEMWB_ALUSrc, MEMWB_RegWrite;
wire [1:0] MEMWB_ALUOp;
wire [63:0] MEMWB_Read_Data;
wire [63:0] MEMWB_Result;
wire [4:0] MEMWB_inst2;


/////// Mux 3  wire declared in Reguister file







/////////////////////////////////////////////////////////////////////////////////////////////////
mux1 muxAdder(.a(out1),.b(EXMEM_out),.sel(PCSrc),.data_out(data_out));
pc_counter pc(.PC_In(data_out),.reset(reset),.clk(clk),.PC_Out(PC_Out));
adder adder1(.a(PC_Out),.b(b),.out(out1));
instruction_memory  ins_mem(.Inst_Address(PC_Out),.Instruction(Instruction));
IF_ID IFID(.clk(clk),.reset(reset),.instruction(Instruction),.PC_Out(PC_Out),.IFID_instruction(IFID_instruction),.IFID_PC_Out(IFID_PC_Out));

//// After IFID
instruction_parser parser(.ins(IFID_instruction),.opcode(opcode),.rd(rd),.rs1(rs1),.rs2(rs2),.func3(func3),.func7(func7));
registerFile reg_file(.WriteData(data_out3),.RS1(rs1),.RS2(rs2),.RD(MEMWB_inst2),.RegWrite(MEMWB_RegWrite),.clk(clk),.reset(reset),.ReadData1(ReadData1),.ReadData2(ReadData2));
ImmGen Imm(.ins(IFID_instruction),.data(data)); // IDE
Control_Unit ctrl_unit(.Opcode(opcode),.ALUOp(ALUOp),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.Regwrite(RegWrite));
//// IDEX
ID_EX IDEX(.clk(clk),.reset(reset),
.inst1(inst1),.inst2(rd),
.ReadData1(ReadData1),.ReadData2(ReadData2),
.IFID_PC_Out(IFID_PC_Out),
.data(data),
.ALUOp(ALUOp),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),
.IDEX_inst1(IDEX_inst1),.IDEX_inst2(IDEX_inst2),
.IDEX_ALUOp(IDEX_ALUOp),.IDEX_Branch(IDEX_Branch),.IDEX_ALUSrc(IDEX_ALUSrc),.IDEX_imm_data(IDEX_imm_data),
.IDEX_MemRead(IDEX_MemRead),.IDEX_MemtoReg(IDEX_MemtoReg),.IDEX_MemWrite(IDEX_MemWrite),
.IDEX_PC_Out(IDEX_PC_Out),.IDEX_RegWrite(IDEX_RegWrite),
.IDEX_ReadData1(IDEX_ReadData1),.IDEX_ReadData2(IDEX_ReadData2));

/// After IDEX

adder adder2(.a(IDEX_PC_Out),.b(b1),.out(out2));
mux1 mux2(.a(IDEX_ReadData2),.b(IDEX_imm_data),.sel(IDEX_ALUSrc),.data_out(data_out2));
ALU_Control  alu_ctrl(.ALUOp(ALUOp),.Funct(IDEX_inst1),.Operation(Operation));
alu_64 alu64(.a(IDEX_ReadData1),.b(data_out2),.ALUOp(Operation),.Result(Result),.ZERO(ZERO));

//// EX/MEM
EX_MEM EXMEM(.out(out2),.ZERO(ZERO),.Result(Result),.clk(clk),.reset(reset),
.IDEX_ReadData2(IDEX_ReadData2),.IDEX_inst2(IDEX_inst2),.IDEX_ALUOp(IDEX_ALUOp),
.Branch(IDEX_Branch),.MemRead(IDEX_MemRead),.MemtoReg(IDEX_MemtoReg),.MemWrite(IDEX_MemWrite),.ALUSrc(IDEX_ALUSrc),.RegWrite(IDEX_RegWrite),
.EXMEM_Branch(EXMEM_Branch),.EXMEM_MemRead(EXMEM_MemRead),.EXMEM_MemtoReg(EXMEM_MemtoReg),.EXMEM_MemWrite(EXMEM_MemWrite),.EXMEM_ALUSrc(EXMEM_ALUSrc),.EXMEM_RegWrite(EXMEM_RegWrite),
.EXMEM_ALUOp(EXMEM_ALUOp),.EXMEM_ZERO(EXMEM_ZERO),.EXMEM_Result(EXMEM_Result),.EXMEM_ReadData2(EXMEM_ReadData2),
.EXMEM_out(EXMEM_out),.EXMEM_inst2(EXMEM_inst2));


////// AFTER EXMEM

Data_Memory  data_mem(.Mem_Addr(EXMEM_Result),.Write_Data(EXMEM_ReadData2),.clk(clk),.MemWrite(EXMEM_MemWrite),.MemRead(EXMEM_MemRead),.Read_Data(Read_Data));

//// MEM/WB

MEM_WB MEMWB(.EXMEM_ALUOp(EXMEM_ALUOp),.Read_Data(Read_Data),.EXMEM_Result(EXMEM_Result),.EXMEM_inst2(EXMEM_inst2),.clk(clk),.reset(reset),
.Branch(EXMEM_Branch),.MemRead(EXMEM_MemRead),.MemtoReg(EXMEM_MemtoReg),.MemWrite(EXMEM_MemWrite),.ALUSrc(EXMEM_ALUSrc),.RegWrite(EXMEM_RegWrite),
.MEMWB_Branch(MEMWB_Branch),.MEMWB_MemRead(MEMWB_MemRead),.MEMWB_MemtoReg(MEMWB_MemtoReg),.MEMWB_MemWrite(MEMWB_MemWrite),.MEMWB_ALUSrc(MEMWB_ALUSrc),.MEMWB_RegWrite(MEMWB_RegWrite),
.MEMWB_ALUOp(MEMWB_ALUOp),.MEMWB_Read_Data(MEMWB_Read_Data),.MEMWB_Result(MEMWB_Result),.MEMWB_inst2(MEMWB_inst2));


mux1 mux3(.a(MEMWB_Result),.b(MEMWB_Read_Data),.sel(MEMWB_MemtoReg),.data_out(data_out3));

endmodule


///// add wave sim:/tb/risc/reg_file/Registers