`timescale 1ns/1ps

module branch_and(
    input branch,
    input zero,
    output reg pc_src
);

always @(*) begin
    pc_src = branch & zero;
end
endmodule