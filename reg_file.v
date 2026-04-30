`timescale 1ns/1ps
module Reg_file(
    input  [4:0]  read_reg1,
    input  [4:0]  read_reg2,
    input  [4:0]  write_reg,
    input  [31:0] write_data,
    input         clk,
    input         reset,
    input         RegWrite,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] regfile [31:0];
integer i;

assign read_data1 = regfile[read_reg1];
assign read_data2 = regfile[read_reg2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Zero all registers
        for (i = 0; i < 32; i = i + 1)
            regfile[i] <= 32'b0;

        // --- Arithmetic test inputs ---
        regfile[8]  <= 32'd10;   // x8  (s0)
        regfile[9]  <= 32'd20;   // x9  (s1)
        regfile[10] <= 32'd30;   // x10 (a0)
        regfile[11] <= 32'd5;    // x11 (a1)
        regfile[12] <= 32'd8;    // x12 (a2)
        regfile[13] <= 32'd3;    // x13 (a3)
        regfile[14] <= 32'd1;    // x14 (a4)
        regfile[15] <= 32'd2;    // x15 (a5)

        // --- Loop constants (replaces ADDI which is not implemented) ---
        regfile[28] <= 32'd4;    // x28 = byte stride (used as loop increment)
        regfile[29] <= 32'd16;   // x29 = loop limit  (4 elements * 4 bytes)

    end else if (RegWrite) begin
        regfile[write_reg] <= write_data;
        $display(">>> [REG WRITE] x%0d = %0d (0x%8h)",
                 write_reg, write_data, write_data);
    end
end

endmodule