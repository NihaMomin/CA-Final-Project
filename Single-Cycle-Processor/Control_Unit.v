module Control_Unit
(
    input [6:0] Opcode,
    output reg [1:0] ALUOp,
    output reg Branch,MemRead,MemtoReg,MemWrite,ALUSrc,Regwrite
);

always @(*)

begin
    case (Opcode)
	
	// R-type (eg: add)
    7'b0110011:
        begin
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Regwrite = 1'b1;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        Branch = 1'b0;
        ALUOp = 2'b10;
        end
	
	// I-Type (lw)
    7'b0000011:
        begin
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        Regwrite = 1'b1;
        MemRead = 1'b1;
        MemWrite = 1'b0;
        Branch = 1'b0;
        ALUOp = 2'b00;
        end
	
	// I-Type (sw)
    7'b0100011:
        begin
        ALUSrc = 1'b1;
        MemtoReg = 1'bx;
        Regwrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b1;
        Branch = 1'b0;
        ALUOp = 2'b00;
        end
	
	// SB-Type (beq/bge)
    7'b1100011:
        begin
        ALUSrc = 1'b0;
        MemtoReg = 1'bx;
        Regwrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        Branch = 1'b1;
        ALUOp = 2'b01;
        end
     
		
	//extra case for add_i
	7'b0_01_00_11 : 
		begin
		ALUSrc = 1;
		MemtoReg = 0;
		Regwrite = 1;
		MemRead = 0;
		MemWrite = 0;
		Branch = 0;
		ALUOp = 2'b00;
		end
    endcase
end
endmodule