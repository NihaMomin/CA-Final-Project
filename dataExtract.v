module dataExtract
(
    input [31:0]instruction,
    output reg [63:0]imm_data
);

always @ (*)
begin
case({instruction[6], instruction[5]})
    2'b00 : imm_data = {{52{instruction[31]}}, instruction[31:20]};
    2'b01 : imm_data = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
    default : imm_data = {{52{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
endcase
end

endmodule