`timescale 1ns/1ps

module data_memory(
    output reg [31:0] data_out,
    input [31:0] data_in,
    input [31:0] address,
    input MemWrite,
    input MemRead,
    input clk
);
    
    reg [7:0] memory [0:1023];  // 1KB memory
    integer i;
    
    initial begin
        for (i = 0; i < 1024; i = i + 1) 
            memory[i] = 8'b0;
    end
    
    always @ (posedge clk) begin
        if (MemWrite) begin
            memory[address] <= data_in[7:0];
            memory[address + 1] <= data_in[15:8];
            memory[address + 2] <= data_in[23:16];
            memory[address + 3] <= data_in[31:24];
        end
    end
    
    always @ (*) begin
        if (MemRead) begin
            data_out = {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]};
        end else begin
            data_out = 32'b0;
        end
    end
    
endmodule
