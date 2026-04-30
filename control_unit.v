`timescale 1ns/1ps

module control_unit(
    input [6:0] opcode,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @(*) begin
    // Default values (all control signals to 0)
    {Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite} = 6'b0;
    ALUOp = 2'b00;
    
    case(opcode)
        7'b0110011: begin // R-type (ADD, SUB, AND, OR)
            ALUOp = 2'b10;
            RegWrite = 1'b1;
        end
        
        7'b0000011: begin // I-type (LW - Load Word)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            RegWrite = 1'b1;
        end
        
        7'b0100011: begin // S-type (SW - Store Word)
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
        end
        
        7'b1100011: begin // B-type (BEQ - Branch if Equal)
            ALUOp = 2'b01;
            Branch = 1'b1;
        end
        
        default: begin
            // All signals already 0
        end
    endcase
end

endmodule
