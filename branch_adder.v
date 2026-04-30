
`timescale 1ns/1ps

module branch_adder(
    input [31:0] pc,
    input [31:0] imm,
    output reg [31:0] branch_target
);

always @(*) begin
    branch_target = pc + imm;
    $display("BRANCH: pc=%0d, imm=%0d, target=%0d", pc, imm, branch_target);
end

endmodule
