module instruction_memory(

	input [63:0] Inst_Address,
	output reg [31:0] Instruction

);
reg [7:0]inst_mem[79:0];

initial {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h20000513; //addi x10, x0, 0x200 # a = User Input

initial {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00400593; // addi x11, x0, 4 # len = User Input

initial {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h04b68463; // beq x13, x11, Exit

initial {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00d00733; // add x14, x0, x13 # j = i

initial {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h01400ab3; // add x21, x0, x20

initial {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h02b70863; // beq x14, x11, Loop2Exit

initial {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h00aa0c33; // add x24, x20, x10  # x20 now has address of a[i]

initial {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00aa8cb3; // add x25, x21, x10  # x20 now has address of a[j]

initial {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h000C3b03; // lw x22, 0(x24) # x22 = a[i]

initial {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h000CBB83; // lw x23, 0(x25) # x21 = a[j]

initial {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h008a8a93; // addi x21, x21, 4

initial {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h00170713; // addi x14, x14, 1 # j += 1

initial {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'hff6bd2e3; // bge x23, x22, Loop2

initial {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h016007b3; // add x15, x0, x22 # temp = a[i]

initial {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h017c3023; // sw x23, 0(x24) # a[i] = a[j]

initial {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00FCB023; // sw x15, 0(x25) # a[j] = temp

initial {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'hfc000ae3; // beq x0, x0, Loop2 # loop repeat

initial {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h008a0a13; // addi x20, x20, 4

initial {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h00168693; // addi x13, x13, 1 # i += 1

initial {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'hfa000ee3; // beq x0, x0, Loop # loop repeat



always @(*)
	begin
	Instruction = {inst_mem[Inst_Address + 3], inst_mem[Inst_Address + 2], inst_mem[Inst_Address + 1], inst_mem[Inst_Address]};
	end

endmodule