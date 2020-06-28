module ALU_Control
(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
);
always@(*)
begin
    case(ALUOp)
        2'b00:
            begin
		Operation = 4'b0010; // addi
            end
        2'b01:
            begin
            Operation = 4'b0110;
            end
        2'b10:
            begin
            case(Funct)
            4'b0000: //add
                begin
                Operation = 4'b0010;
                end
            4'b1000: // xor
                begin
                Operation = 4'b0110;
                end
            4'b0111: // and 
                begin
                Operation = 4'b0000;
                end
            4'b0110: // or
                begin
                Operation = 4'b0001;
                end
            endcase
            end
    endcase
end
endmodule
