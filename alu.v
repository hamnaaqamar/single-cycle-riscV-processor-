module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

always @(*) begin
    case(alu_control)
        4'b0001: result = a << b[4:0];      // sll
        4'b0010: result = a + b;             // add
        4'b0011: result = a | b;             // or
        4'b0100: result = a ^ b;             // xor
        4'b0101: result = a & b;             // and
        4'b0110: result = a - b;             // sub
        4'b0111: result = (a < b) ? 1 : 0;   // slt
        4'b1000: result = ($unsigned(a) < $unsigned(b)) ? 1 : 0; // sltu
        4'b1001: result = a >> b[4:0];       // srl
        4'b1011: result = $signed(a) >>> b[4:0]; // sra
        default: result = 32'b0;
    endcase
    zero = (result == 0);
end
endmodule