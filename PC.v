`timescale 1ns/1ps
module PC (pc_out, pc_in, reset, clk);
input [31:0] pc_in;
input clk;
input reset;
output reg [31:0] pc_out;

always @ (posedge clk or posedge reset)
begin
    if (reset)
    pc_out <= 32'b0;
    else
    begin
        pc_out<=pc_in;
    end
end
endmodule