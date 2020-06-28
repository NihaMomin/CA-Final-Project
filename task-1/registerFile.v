module registerFile(

	input [63:0] WriteData,
	input [4:0] RS1,
	input [4:0] RS2,
	input [4:0] RD,
	input RegWrite, clk, reset,
	output reg [63:0] ReadData1,
	output reg [63:0] ReadData2
		
);

reg [63:0] Registers [31:0];

initial
    begin
    Registers[0] = 64'd 0;
    Registers[1] = 64'd 0;
    Registers[2] = 64'd 0;
    Registers[3] = 64'd 0;
    Registers[4] = 64'd 0;
    Registers[5] = 64'd 0;
    Registers[6] =64'd 0;
    Registers[7] = 64'd 0;
    Registers[8] = 64'd 0;
    Registers[9] = 64'd 0;
    Registers[10] = 64'd 0;
    Registers[11] = 64'd 0; // length of array 
    Registers[12] = 64'd 0;
    Registers[13] = 64'd 0; // i
    Registers[14] = 64'd 0; // j
    Registers[15] = 64'd 0;
    Registers[16] = 64'd 0;
    Registers[17] = 64'd 0;
    Registers[18] = 64'd 0;
    Registers[19] = 64'd 0;
    Registers[20] = 64'd 0; // offset of i
    Registers[21] = 64'd 0; // offset of j
    Registers[22] = 64'd 0;
    Registers[23] = 64'd 0;
    Registers[24] = 64'd 0;
    Registers[25] = 64'd 0;
    Registers[26] = 64'd 0;
    Registers[27] = 64'd 0;
    Registers[28] = 64'd 0;
    Registers[29] = 64'd 0;
    Registers[30] = 64'd 0;
    Registers[31] = 64'd 0;
	
    end
	
always @(posedge clk)
    if(RegWrite)
        begin
        Registers[RD] = WriteData;
        end
always @(RS1 or RS2 or reset or Registers)
    if(reset)
        begin
        ReadData1 = 64'b0;
        ReadData2 = 64'b0;
        end
    else
        begin
        ReadData1 = Registers[RS1];
        ReadData2 = Registers[RS2];
        end
endmodule