`timescale 1ns/1ps
module control_unit(Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, opcode);
input [6:0] opcode;
output reg Branch;
output reg MemRead;
output reg MemtoReg;
output reg [1:0] ALUOp;
output reg MemWrite;
output reg ALUSrc;
output reg RegWrite;

always @(*)
begin
    {Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite} = 8'b0;

    case(opcode)
        7'b0110011: begin //r type
            ALUOp = 2'b10;
            RegWrite = 1'b1;
        end
        7'b0000011: begin //i type (load)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            RegWrite = 1'b1;
        end
        7'b0100011: begin // s type (store)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
        end
        7'b1100011: begin
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            RegWrite = 1'b1;
        end
        7'b0100011: begin
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
        end
        7'b1100011: begin
            ALUOp = 2'b01;
            Branch = 1'b1;
        end
    endcase
end
endmodule 

            



