`timescale 1ns/1ps

module testbench;

reg clk, reset;

processor cpu (
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, testbench);

    clk   = 0;
    reset = 1;
    #15 reset = 0;

    #500; // enough for all instructions + 4-iteration BEQ loop

    $display("\n================================================");
    $display("  FINAL RESULTS");
    $display("================================================");
    $display("  Reg   Got    Expected  Status");
    $display("  ---   ---    --------  ------");

    $display("  x5    %-6d  30        %s", cpu.reg_file_inst.regfile[5],
             (cpu.reg_file_inst.regfile[5]  ==  30) ? "PASS" : "FAIL");
    $display("  x6    %-6d  25        %s", cpu.reg_file_inst.regfile[6],
             (cpu.reg_file_inst.regfile[6]  ==  25) ? "PASS" : "FAIL");
    $display("  x7    %-6d  0         %s", cpu.reg_file_inst.regfile[7],
             (cpu.reg_file_inst.regfile[7]  ==   0) ? "PASS" : "FAIL");
    $display("  x8    %-6d  3         %s", cpu.reg_file_inst.regfile[8],
             (cpu.reg_file_inst.regfile[8]  ==   3) ? "PASS" : "FAIL");
    $display("  x18   %-6d  300       %s", cpu.reg_file_inst.regfile[18],
             (cpu.reg_file_inst.regfile[18] == 300) ? "PASS" : "FAIL");
    $display("  x20   %-6d  26        %s", cpu.reg_file_inst.regfile[20],
             (cpu.reg_file_inst.regfile[20] ==  26) ? "PASS" : "FAIL");
    $display("  x23   %-6d  26        %s", cpu.reg_file_inst.regfile[23],
             (cpu.reg_file_inst.regfile[23] ==  26) ? "PASS" : "FAIL");
    $display("  x24   %-6d  24        %s", cpu.reg_file_inst.regfile[24],
             (cpu.reg_file_inst.regfile[24] ==  24) ? "PASS" : "FAIL");
    $display("  x25   %-6d  3         %s", cpu.reg_file_inst.regfile[25],
             (cpu.reg_file_inst.regfile[25] ==   3) ? "PASS" : "FAIL");

    $display("================================================\n");
    $finish;
end

endmodule