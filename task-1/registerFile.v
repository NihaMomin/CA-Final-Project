module registerFile (
    input clk, reset, RegWrite,
    input [63:0] WriteData,
    input [4:0] RS1, RS2, RD,
    output [63:0] ReadData1, ReadData2
);

reg [63:0] register [31:0];
integer i;
initial
    begin
		for (i = 0; i < 64; i = i + 1)
			begin
				register[i] = 64'b0;
		end

	end


always @(posedge clk)
    begin
        if (reset == 1'b1)
            begin

                for (i = 0; i < 64; i = i + 1)
                    begin
                        register[i] = 64'b0;
                    end
                    
            end
        else if (RegWrite == 1)
            begin
                register[RD] <= WriteData;
            end
    end



assign ReadData1 = register[RS1];
assign ReadData2 = register[RS2];


endmodule