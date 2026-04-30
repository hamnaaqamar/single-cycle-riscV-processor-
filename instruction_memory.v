`timescale 1ns/1ps
module instruction_memory(instruction_code, pc, reset);
input [31:0] pc;
input reset;
output [31:0] instruction_code;
reg [31:0] memory [0:255];

initial begin
    for (integer i = 0; i < 256; i = i + 1) begin
        memory[i] = 32'h00000000;
    end

    // ============================================================
    // TEST PROGRAM  (no ADDI — x28=4 and x29=16 pre-loaded in reg_file)
    // ============================================================

    // --- PART 1: Arithmetic (R-type) ---
    // ADD x5,  x8,  x9   -> 10+20 = 30
    memory[0]  = 32'h009402b3;
    // SUB x6,  x10, x11  -> 30-5  = 25
    memory[1]  = 32'h40b50333;
    // AND x7,  x12, x13  ->  8&3  =  0
    memory[2]  = 32'h00d673b3;
    // OR  x8,  x14, x15  ->  1|2  =  3
    memory[3]  = 32'h00f76433;

    // --- PART 2: Load / Store ---
    // LW  x16, 100(x0)   -> x16 = mem[100] = 100
    memory[4]  = 32'h06402803;
    // LW  x17, 104(x0)   -> x17 = mem[104] = 200
    memory[5]  = 32'h06802883;
    // ADD x18, x16, x17  -> x18 = 300
    memory[6]  = 32'h01180933;
    // SW  x18, 108(x0)   -> mem[108] = 300
    memory[7]  = 32'h07202623;

    // --- PART 3: Sum-array loop (4 iterations, step = 4 bytes) ---
    // ADD x19, x0,  x0   -> counter = 0
    memory[8]  = 32'h000009b3;
    // ADD x20, x0,  x0   -> sum     = 0
    memory[9]  = 32'h00000a33;
    // ADD x21, x0,  x29  -> loop limit = x29 = 16   (x29 pre-loaded = 16)
    memory[10] = 32'h01d00ab3;
    // LW  x22, 200(x19)  -> load array element
    memory[11] = 32'h0c89ab03;
    // ADD x20, x20, x22  -> accumulate
    memory[12] = 32'h016a0a33;
    // ADD x19, x19, x28  -> counter += 4            (x28 pre-loaded = 4)
    memory[13] = 32'h01c989b3;
    // BEQ x19, x21, -12  -> if counter==16, exit loop  (PC=56 -> target=44)
    memory[14] = 32'hff598ae3;
    // SW  x20, 300(x0)   -> store sum=26 to mem[300]
    memory[15] = 32'h13402623;
    // LW  x23, 300(x0)   -> x23 = mem[300] = 26
    memory[16] = 32'h12c02b83;

    // --- PART 4: Final verification ---
    // AND x24, x5,  x6   -> 30 & 25 = 24
    memory[17] = 32'h0062fc33;
    // OR  x25, x7,  x8   ->  0 |  3 =  3
    memory[18] = 32'h0083ecb3;
    // SUB x26, x18, x20  -> 300 - 26 = 274
    memory[19] = 32'h41490d33;

    $display("\n========================================");
    $display("INSTRUCTION MEMORY LOADED");
    $display("========================================");
    $display("Arithmetic : ADD, SUB, AND, OR");
    $display("Memory     : LW, SW");
    $display("Branch     : BEQ (loop 4 iterations)");
    $display("========================================\n");
end

wire [7:0] word_addr = pc[9:2];
assign instruction_code = memory[word_addr];

endmodule