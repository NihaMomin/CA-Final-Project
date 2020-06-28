module RISC_V_Processor(

	input clk,
	input reset
	
);

// adder
wire [63:0] out;  // adder1 out
wire [63:0] b1;  // input b for adder 2
wire [63:0] out1;  // adder2 out
// alu_control
wire [3:0] Operation;
wire [3:0] functx;
// Control Unit
wire [1:0] ALUOp;  // Output of control unit and input of ALU_Control
wire Branch,MemRead,MemtoReg,MemWrite,ALUSrc,Regwrite;
//Data Memory
wire [63:0] Read_Data;
//ImmGen
wire [63:0] data;  // output of IDE and Input of mux after resgister 
assign b1 = data << 1;
//instruction

// instruction memory 
wire [31:0] Instruction;  //Output of Instruction memory
//  parser
wire [6:0] opcode;   // using in control unit and opcode output
wire [4:0] rd;
wire [2:0] func3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] func7;
// mux
wire sel;
wire [63:0] data_out;  // Input for PC 
wire [63:0] data_out1;  // Output of mux Register (After register File)
// ALU_64
wire [63:0] Result;
wire ZERO;
// Register File
wire [4:0] RS1;
wire [4:0] RS2;
wire [4:0] RD;
wire [63:0] ReadData1;
wire [63:0] ReadData2;
wire [63:0] data_out2;  // output of mux2 to register file(write data) (AFTER DATA memory)
// pc Counter
wire [63:0] PC_Out;   // PC output
wire [63:0] b;               //

assign b = 64'd4;
assign sel = Branch & ZERO;
wire [63:0] imm_data;
assign functx = {Instruction[30] ,Instruction[14:12]};
  
  
  
	adder adder1(
	.a(PC_Out),.b(b),
	.out(out)
	);
	
	mux1 muxAdder(
	.a(out),
	.b(out1),
	.sel(sel),
	.data_out(data_out)
	);
	
	adder adder2(
	.a(PC_Out),
	.b(b1),
	.out(out1)
	);
	
	instruction_memory  ins_mem(
	.Inst_Address(PC_Out),
	.Instruction(Instruction)
	);
	
	instruction_parser ins_par(
	.ins(Instruction),
	.opcode(opcode),
	.rd(rd),
	.func3(func3),
	.rs1(rs1),
	.rs2(rs2),
	.func7(func7)
	);
		
	Control_Unit ctrl_unit(
	.Opcode(opcode),
	.ALUOp(ALUOp),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.Regwrite(Regwrite)
	);
	
	registerFile reg_file(
	.WriteData(data_out2),
	.RS1(rs1),.RS2(rs2),
	.RD(rd),
	.RegWrite(Regwrite),
	.clk(clk),
	.reset(reset),
	.ReadData1(ReadData1),
	.ReadData2(ReadData2)
	);
	
	mux1 muxRegister(
	.a(ReadData2),
	.b(data),
	.sel(ALUSrc),
	.data_out(data_out1)
	);
	
	ALU_Control  alu_ctrl(
	.ALUOp(ALUOp),
	.Funct(functx),
	.Operation(Operation)
	);

	Data_Memory  data_mem(
	.Mem_Addr(Result),
	.Write_Data(ReadData2),
	.clk(clk),.MemWrite(MemWrite),
	.MemRead(MemRead),
	.Read_Data(Read_Data)
	);

	ImmGen Imm(
	.ins(Instruction),
	.data(data)
	); // IDE

	alu_64 alu64(
	.a(ReadData1),
	.b(data_out1),
	.ALUOp(Operation),
	.Result(Result),
	.ZERO(ZERO)
	);

	mux1 mux3(
	.a(Result),
	.b(Read_Data),
	.sel(MemtoReg),
	.data_out(data_out2)
	);

	pc_counter pc(
	.PC_In(
	data_out),
	.reset(reset),
	.clk(clk),
	.PC_Out(PC_Out)
	);

	dataExtract ext(
	.instruction(Instruction),
	.imm_data(imm_data)
	);
	
endmodule