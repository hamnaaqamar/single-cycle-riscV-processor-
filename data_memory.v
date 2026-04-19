module data_memory(data_out, data_in, address, MemWrite, MemRead, clk);
input clk;
input [31:0] data_in;
input [31:0] address;
input MemRead, MemWrite;

output reg [31:0] data_out;

reg [7:0] datamemory [31:0];
integer i;

initial for (i=0; i<64; i = i+1) memory[i] = 0;

always @ (posedfe clk)
begin
    if(MemWrite)
    begin
        memory[address] <= data_in [7:0];
        memory[address + 1]<= data_in[15:8];
        memory[address + 2] <= data_in[23:16];
        memory[address + 3]<= data_in[31:24];
    end
    else if (MemRead)
    data_out <= {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]};
end
endmodule
