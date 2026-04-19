module Reg_file(read_data1, read_data2, read_reg1, read_reg2, write_reg, write_data, clk, reset, RegWrite);
input [4:0] read_reg1;
input [4:0] read_reg2;
input [4:0] write_reg;
input [31:0] write_data;
output [31:0] read_data1;
output [31:0] read_data2;

reg [31:0] regfile [31:0];
integer i;

assign read_data1 = regfile[read_reg1];
assign read_data2 = regfile[read_reg2];

always @ (posedge clk)
begin
    if(reset) for(i=0; i<12; i=i+1) regfile[i] <= 32'b0;
    else if(RegWrite) regfile[write_reg] <= write_data;
end
endmodule