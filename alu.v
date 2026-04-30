
`timescale 1ns/1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

always @(*) begin
    case(alu_control)
        4'b0010: result = a + b;      // ADD (for LW/SW address calculation)
        4'b0110: result = a - b;      // SUBTRACT (for BEQ comparison and R-type SUB)
        4'b0101: result = a & b;      // AND
        4'b0011: result = a | b;      // OR
        default: result = 32'b0;
    endcase
    
    // Zero flag is 1 when result is 0 (used for BEQ)
    zero = (result == 0);
end

endmodule
