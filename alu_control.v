module alu_control(
    input [1:0] ALUOp,
    input [14:12] funct3,
    input [31:25] funct7,
    output reg [3:0] alu_control_sig
);

always @(*) begin
    case(ALUOp)
        2'b00: alu_control_sig = 4'b0010; // add for loads/stores
        2'b01: alu_control_sig = 4'b0110; // subtract for branches
        2'b10: begin // R-type
            case(funct3)
                3'b000: alu_control_sig = (funct7[5]) ? 4'b0110 : 4'b0010; // sub or add
                3'b001: alu_control_sig = 4'b0001; // sll
                3'b010: alu_control_sig = 4'b0111; // slt
                3'b011: alu_control_sig = 4'b1000; // sltu
                3'b100: alu_control_sig = 4'b0100; // xor
                3'b101: alu_control_sig = (funct7[5]) ? 4'b1011 : 4'b1001; // srl or sra
                3'b110: alu_control_sig = 4'b0011; // or
                3'b111: alu_control_sig = 4'b0101; // and
                default: alu_control_sig = 4'b0010;
            endcase
        end
        default: alu_control_sig = 4'b0010;
    endcase
end
endmodule