// testbench.v
`timescale 1ns/1ps

module testbench;
    reg clk;
    reg reset;
    
    // Instantiate the processor
    riscv_single_cycle cpu(
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation (10ns period = 5ns high, 5ns low)
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        
        // Display header
        $display("=========================================");
        $display("RISC-V Single Cycle Processor Testbench");
        $display("=========================================");
        $display("Time\tPC\tInstruction\tResult");
        $display("-----------------------------------------");
        
        // Apply reset for 2 cycles
        #15 reset = 0;
        
        // Monitor signals
        $monitor("%0t\t%h\t%b\t%d", 
                 $time, cpu.pc_current, cpu.instruction, 
                 cpu.alu_result);
        
        // Dump waveform
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        
        // Run for 500 ns (50 clock cycles)
        #500;
        
        // Display final register contents
        $display("\n=========================================");
        $display("Final Register Values:");
        $display("=========================================");
        
        for (integer i = 0; i < 32; i++) begin
            if (cpu.reg_file.regfile[i] !== 32'b0) begin
                $display("x%0d = %d (0x%h)", i, 
                         cpu.reg_file.regfile[i], 
                         cpu.reg_file.regfile[i]);
            end
        end
        
        $display("=========================================");
        $display("Simulation completed at time %0t", $time);
        $display("=========================================");
        
        $finish;
    end
    
    // Optional: Check for errors
    always @(posedge clk) begin
        // Add assertions here if needed
    end
    
endmodule