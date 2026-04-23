`timescale 1ns/1ps

module Reg_file(
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input clk,
    input reset,
    input RegWrite,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    
    reg [31:0] regfile [31:0];
    integer i;
    
    assign read_data1 = regfile[read_reg1];
    assign read_data2 = regfile[read_reg2];
    
    always @ (posedge clk or posedge reset) begin
        if(reset) begin
            for(i=0; i<32; i=i+1) 
                regfile[i] <= 32'b0;
            
            // Initialize some test values
            regfile[8]  <= 32'd10;   // x8 = s0 = 10
            regfile[9]  <= 32'd20;   // x9 = s1 = 20  
            regfile[10] <= 32'd30;   // x10 = s2 = 30
            regfile[11] <= 32'd5;    // x11 = s3 = 5
            regfile[12] <= 32'd2;    // x12 = s4 = 2
            regfile[13] <= 32'd4;    // x13 = s5 = 4
            regfile[14] <= 32'd8;    // x14 = s6 = 8
            regfile[15] <= 32'd3;    // x15 = s7 = 3
        end
        else if(RegWrite) 
            regfile[write_reg] <= write_data;
    end
endmodule
