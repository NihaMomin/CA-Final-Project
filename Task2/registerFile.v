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
    Registers[0] = 64'd 1;
    Registers[1] = 64'd 2;
    Registers[2] = 64'd 3;
    Registers[3] = 64'd 4;
    Registers[4] = 64'd 5;
    Registers[5] = 64'd 6;
    Registers[6] = 64'd 7;
    Registers[7] = 64'd 8;
    Registers[8] = 64'd 9;
    Registers[9] = 64'd 10;
    Registers[10] = 64'd 11;
    Registers[11] = 64'd 12;
    Registers[12] = 64'd 13;
    Registers[13] = 64'd 14;
    Registers[14] = 64'd 15;
    Registers[15] = 64'd 16;
    Registers[16] = 64'd 17;
    Registers[17] = 64'd 18;
    Registers[18] = 64'd 19;
    Registers[19] = 64'd 20;
    Registers[20] = 64'd 21;
    Registers[21] = 64'd 22;
    Registers[22] = 64'd 23;
    Registers[23] = 64'd 24;
    Registers[24] = 64'd 25;
    Registers[25] = 64'd 26;
    Registers[26] = 64'd 27;
    Registers[27] = 64'd 28;
    Registers[28] = 64'd 29;
    Registers[29] = 64'd 30;
    Registers[30] = 64'd 31;
    Registers[31] = 64'd 32;
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