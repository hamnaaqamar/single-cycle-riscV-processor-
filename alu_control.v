`timescale 1ns/1ps

module alu_control(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_control_sig
);

always @(*) begin
    case(ALUOp)
        2'b00: alu_control_sig = 4'b0010; // ADD for LW/SW address calculation
        2'b01: alu_control_sig = 4'b0110; // SUBTRACT for BEQ comparison
        2'b10: begin // R-type instructions
            case(funct3)
                3'b000: begin  // ADD or SUB
                    if (funct7[5] == 1'b1)
                        alu_control_sig = 4'b0110;  // SUB
                    else
                        alu_control_sig = 4'b0010;  // ADD
                end
                3'b111: alu_control_sig = 4'b0101;  // AND
                3'b110: alu_control_sig = 4'b0011;  // OR
                default: alu_control_sig = 4'b0010;
            endcase
        end
        default: alu_control_sig = 4'b0010;
    endcase
end

endmodule
