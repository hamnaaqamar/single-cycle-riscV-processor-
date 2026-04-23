`timescale 1ns/1ps
module riscv_single_cycle(
    input clk,
    input reset
);

// PC signals
wire [31:0] pc_current, pc_next, pc_plus_4, pc_branch_target;
wire pc_src;

// Instruction memory
wire [31:0] instruction;

// Control signals
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

// Register file signals
wire [31:0] read_data1, read_data2, write_data_reg;

// Immediate
wire [31:0] imm;

// ALU signals
wire [3:0] alu_control_sig;
wire [31:0] alu_src, alu_result;
wire zero;

// Data memory
wire [31:0] data_mem_out;

// PC + 4 adder
adder4 pc_adder(
    .sum(pc_plus_4),
    .a(pc_current),
    .b(4'd4)
);

// PC register
PC pc_reg(
    .pc_out(pc_current),
    .pc_in(pc_next),
    .reset(reset),
    .clk(clk)
);

// Instruction memory
instruction_memory instr_mem(
    .instruction_code(instruction),
    .pc(pc_current),
    .reset(reset)
);

// Control unit
control_unit ctrl(
    .opcode(instruction[6:0]),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

// Register file
Reg_file reg_file(
    .read_data1(read_data1),
    .read_data2(read_data2),
    .read_reg1(instruction[19:15]),
    .read_reg2(instruction[24:20]),
    .write_reg(instruction[11:7]),
    .write_data(write_data_reg),
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite)
);

// Immediate generator
imm_gen imm_gen_inst(
    .immediate_output(imm),
    .instruction(instruction)
);

// ALU control
alu_control alu_ctrl(
    .ALUOp(ALUOp),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .alu_control_sig(alu_control_sig)
);

// ALU source mux
alu_src_mux alu_mux(
    .read_data2(read_data2),
    .imm(imm),
    .ALUSrc(ALUSrc),
    .alu_src(alu_src)
);

// ALU
alu alu_inst(
    .a(read_data1),
    .b(alu_src),
    .alu_control(alu_control_sig),
    .result(alu_result),
    .zero(zero)
);

// Data memory
data_memory data_mem(
    .data_out(data_mem_out),
    .data_in(read_data2),
    .address(alu_result),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .clk(clk)
);

// Writeback mux
writeback_mux wb_mux(
    .alu_result(alu_result),
    .read_data(data_mem_out),
    .MemtoReg(MemtoReg),
    .write_data(write_data_reg)
);

// Branch adder
branch_adder br_adder(
    .pc(pc_current),
    .imm(imm),
    .branch_target(pc_branch_target)
);

// Branch AND
branch_and br_and(
    .branch(Branch),
    .zero(zero),
    .pc_src(pc_src)
);

// PC mux
pc_mux pc_mux_inst(
    .pc_plus_4(pc_plus_4),
    .branch_target(pc_branch_target),
    .pc_src(pc_src),
    .pc_next(pc_next)
);

endmodule