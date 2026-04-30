`timescale 1ns/1ps

module PC(pc_out, pc_in, reset, clk);
    input [31:0] pc_in;
    input clk;
    input reset;
    output reg [31:0] pc_out;
    
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 32'b0;
        end
        else begin
            if (pc_in != pc_out + 4 && pc_in != pc_out) begin
                $display(">>> BRANCH TAKEN: PC from %0d to %0d", pc_out, pc_in);
            end
            pc_out <= pc_in;
        end
    end
endmodule
