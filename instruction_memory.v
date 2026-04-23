`timescale 1ns/1ps
// instruction_memory.v (updated with test programs)
module instruction_memory(instruction_code, pc, reset);
    input [31:0] pc;
    input reset;
    output [31:0] instruction_code;
    
    reg [7:0] memory [0:255];  // Increased memory size
    reg [31:0] instr;
    
    assign instruction_code = {memory[pc+3], memory[pc+2], memory[pc+1], memory[pc]};
    
    always @ (reset) begin
        if (reset == 1) begin
            // Initialize all memory to 0
            for (integer i = 0; i < 256; i = i + 1) 
                memory[i] = 8'h00;
            
            // Test Program 1: Basic arithmetic operations
            // This program demonstrates add, sub, mul, and, or, xor
            
            // Address 0: add x5, x1, x2  (x5 = x1 + x2)
            // add t0, s0, s1
            memory[3] = 8'h00;
            memory[2] = 8'h94;
            memory[1] = 8'h02;
            memory[0] = 8'hb3;
            
            // Address 4: sub x6, x3, x4  (x6 = x3 - x4)
            // sub t1, s2, s3
            memory[7] = 8'h41;
            memory[6] = 8'h39;
            memory[5] = 8'h03;
            memory[4] = 8'h33;
            
            // Address 8: mul x7, x5, x6  (x7 = x5 * x6)
            // mul t2, s4, s5
            memory[11] = 8'h02;
            memory[10] = 8'h5a;
            memory[9] = 8'h02;
            memory[8]  = 8'hb3;
            
            // Address 12: and x8, x7, x6  (x8 = x7 & x6)
            // and t3, s6, s7
            memory[15] = 8'h01;
            memory[14] = 8'h7b;
            memory[13] = 8'h4e;
            memory[12] = 8'h33;
            
            // Address 16: or x9, x8, x7   (x9 = x8 | x7)
            // or t4, s8, s9
            memory[19] = 8'h01;
            memory[18] = 8'h9c;
            memory[17] = 8'h1e;
            memory[16] = 8'hb3;
            
            // Address 20: xor x10, x9, x8 (x10 = x9 ^ x8)
            // xor t5, s10, s11
            memory[23] = 8'h01;
            memory[22] = 8'hbd;
            memory[21] = 8'h5f;
            memory[20] = 8'h33;
            
            // Address 24: sll x11, x10, x9 (x11 = x10 << x9[4:0])
            // sll t6, a2, a3
            memory[27] = 8'h00;
            memory[26] = 8'hd6;
            memory[25] = 8'h7f;
            memory[24] = 8'hb3;
            
            // Address 28: srl x12, x11, x10 (x12 = x11 >> x10[4:0])
            // srl a7, a4, a5
            memory[31] = 8'h00;
            memory[30] = 8'hf7;
            memory[29] = 8'h68;
            memory[28] = 8'h33;
            
            $display("Instruction memory initialized with test program");
            $display("Program includes: add, sub, mul, and, or, xor, sll, srl");
        end
    end
endmodule