`timescale 1ns/1ps
module imm_gen(
    input  [31:0] instruction,
    output reg [31:0] immediate_output
);

wire [6:0] opcode = instruction[6:0];

// I-type: bits [31:20]
wire [11:0] i_imm = instruction[31:20];

// S-type: bits [31:25] | [11:7]
wire [11:0] s_imm = {instruction[31:25], instruction[11:7]};

// B-type: assemble the 13-bit signed offset directly with bit[0]=0
//   imm[12]   = inst[31]
//   imm[11]   = inst[7]
//   imm[10:5] = inst[30:25]
//   imm[4:1]  = inst[11:8]
//   imm[0]    = 0  (all branch targets are 2-byte aligned)

wire [12:0] b_imm = {instruction[31], instruction[7],
                     instruction[30:25], instruction[11:8], 1'b0};

always @(*) begin
    case (opcode)
        7'b0000011: begin  // LW  (I-type)
            immediate_output = {{20{i_imm[11]}}, i_imm};
            $display("IMM_GEN: LW imm=%0d (0x%h)", immediate_output, immediate_output);
        end

        7'b0100011: begin  // SW  (S-type)
            immediate_output = {{20{s_imm[11]}}, s_imm};
            $display("IMM_GEN: SW imm=%0d (0x%h)", immediate_output, immediate_output);
        end

        7'b1100011: begin  // BEQ (B-type)
            // b_imm is already 13 bits with the implicit *2 baked in (bit0 = 0).
            // Just sign-extend from bit 12 — do NOT append another 1'b0.
            immediate_output = {{19{b_imm[12]}}, b_imm};
            $display("IMM_GEN: BEQ imm=%0d (0x%h)", immediate_output, immediate_output);
        end

        7'b0110011: begin  // R-type (no immediate)
            immediate_output = 32'b0;
        end

        default: begin
            immediate_output = 32'b0;
        end
    endcase
end

endmodule