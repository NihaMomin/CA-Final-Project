module Data_Memory(

	input [63:0] Mem_Addr, 
	input [63:0] Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0] Read_Data
);

reg [7:0] memory [63:0];

initial 
begin
	memory[0] = 64'd1;
	memory[1] = 64'd2;
	memory[2] = 64'd3;
	memory[3] = 64'd4;
	memory[4] = 64'd5;
	memory[5] = 64'd6;
	memory[6] = 64'd7;
	memory[7] = 64'd8;
	memory[8] = 64'd9;
	memory[9] = 64'd10;
	memory[10] = 64'd11;
	memory[11] = 64'd12;
	memory[12] = 64'd13;
	memory[13] = 64'd14;
	memory[14] = 64'd15;
	memory[15] = 64'd16;
	memory[16] = 64'd17;
	memory[17] = 64'd18;
	memory[18] = 64'd19;
	memory[19] = 64'd20;
	memory[20] = 64'd21;
	memory[21] = 64'd22;
	memory[22] = 64'd23;
	memory[23] = 64'd24;
	memory[24] = 64'd25;
	memory[25] = 64'd26;
	memory[26] = 64'd27;
	memory[27] = 64'd28;
	memory[28] = 64'd29;
	memory[29] = 64'd30;
	memory[30] = 64'd31;
	memory[31] = 64'd32;
	memory[32] = 64'd33;
	memory[33] = 64'd34;
	memory[34] = 64'd35;
	memory[35] = 64'd36;
	memory[36] = 64'd37;
	memory[37] = 64'd38;
	memory[38] = 64'd39;
	memory[39] = 64'd40;
	memory[40] = 64'd41;
	memory[41] = 64'd42;
	memory[42] = 64'd43;
	memory[43] = 64'd44;
	memory[44] = 64'd45;
	memory[45] = 64'd46;
	memory[46] = 64'd47;
	memory[47] = 64'd48;
	memory[48] = 64'd49;
	memory[49] = 64'd50;
	memory[50] = 64'd51;
	memory[51] = 64'd52;
	memory[52] = 64'd53;
	memory[53] = 64'd54;
	memory[54] = 64'd55;
	memory[55] = 64'd56;
	memory[56] = 64'd57;
	memory[57] = 64'd58;
	memory[58] = 64'd59;
	memory[59] = 64'd60;
	memory[60] = 64'd61;
	memory[61] = 64'd62;
	memory[62] = 64'd63;
	memory[63] = 64'd64;
	memory[64] = 64'd0;

end






always @(posedge clk)
begin
	if (MemWrite)
	begin
		memory[Mem_Addr] = Write_Data[7:0];
		memory[Mem_Addr + 1] = Write_Data[15:8]; 
		memory[Mem_Addr + 2] = Write_Data[23:16];
		memory[Mem_Addr + 3] = Write_Data[31:24];
		memory[Mem_Addr + 4] = Write_Data[39:32];
		memory[Mem_Addr + 5] = Write_Data[47:40];
		memory[Mem_Addr + 6] = Write_Data[55:48];
		memory[Mem_Addr + 7] = Write_Data[63:56];
		
	end
end	

always @(Mem_Addr, MemRead,memory)
begin
	if (MemRead)
	begin
		Read_Data[7:0] = memory[Mem_Addr];
		Read_Data[15:8] = memory[Mem_Addr + 1];
		Read_Data[23:16] = memory[Mem_Addr + 2];
		Read_Data[31:24] = memory[Mem_Addr + 3];
		Read_Data[39:32] = memory[Mem_Addr + 4];
		Read_Data[47:40] = memory[Mem_Addr + 5];
		Read_Data[55:48] = memory[Mem_Addr + 6];
		Read_Data[63:56] = memory[Mem_Addr + 7];
	end
end	
 
	
endmodule