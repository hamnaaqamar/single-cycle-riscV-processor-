`timescale 1n/1ps   


//modules to create

//pc
//Instruction memory
// control unit (generates control signals from opcode)
//register file
//immediate generator 
//alu control (decides exact alu operation)
//alu
//data memory
//muxes: alu source mux, write back mux, pc mux
//adders: pc+4, branch target adder


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

module instruction_memory(instruction_code, pc, reset);
input [31:0] pc;
input reset;
output [31:0] instruction_code;

reg [7:0] memory [31:0];
assign instruction_code = {memory[pc+3], memory[pc+2], memory[pc+1], memory[pc]};

always @ (reset)
begin
    if (reset == 1)
    begin
        // Setting 32-bit instruction: add t1, s0,s1
        Memory[3] = 8'h00;
        Memory[2] = 8'h94;
        Memory[1] = 8'h03;
        Memory[0] = 8'h33;
        // Setting 32-bit instruction: sub t2, s2, s3
        Memory[7] = 8'h41;
        Memory[6] = 8'h39;
        Memory[5] = 8'h03;
        Memory[4] = 8'hb3;
        // Setting 32-bit instruction: mul t0, s4, s5
        Memory[11] = 8'h03;
        Memory[10] = 8'h5a;
        Memory[9] = 8'h02;
        Memory[8] = 8'hb3;
        // Setting 32-bit instruction: xor t3, s6, s7
        Memory[15] = 8'h01;
        Memory[14] = 8'h7b;
        Memory[13] = 8'h4e;
        Memory[12] = 8'h33;
        / Setting 32-bit instruction: sll t4, s8, s9
        Memory[19] = 8'h01;
        Memory[18] = 8'h9c;
        Memory[17] = 8'h1e;
        Memory[16] = 8'hb3;
        // Setting 32-bit instruction: srl t5, s10, s11
        Memory[23] = 8'h01;
        Memory[22] = 8'hbd;
        Memory[21] = 8'h5f;
        Memory[20] = 8'h33;
        // Setting 32-bit instruction: and t6, a2, a3
        Memory[27] = 8'h00;
        Memory[26] = 8'hd6;
        Memory[25] = 8'h7f;
        Memory[24] = 8'hb3;
        / Setting 32-bit instruction: or a7, a4, a5
        Memory[31] = 8'h00;
        Memory[30] = 8'hf7;
        Memory[29] = 8'h68;
        Memory[28] = 8'hb3;
    end
end
endmodule

module adder4(sum, a, b);
input [31:0] a;
input [3:0] b;
output reg [31:0] sum;

always @ (*)
begin
    sum <= a + b;
end
endmodule

