`timescale 1ns / 1ps



module tb;

reg clk = 0, wea = 0;  // program memory will always be read hence write enable will always be zero 
reg [10:0] addr;
reg [31:0] din;
wire [31:0] dout;

reg [31:0] mem [15:0];
//blk_mem_gen_0 dut (clk, wea, addr, din, dout);

initial begin
$readmemh("data.mem",mem);
end

reg [31:0] IR;

always #5 clk = ~clk;

integer count = 0;

integer delay = 0;

always@(posedge clk)
begin
    if(delay < 4)
    begin
        addr <= count;
        IR <= dout;
        delay <= delay + 1;
    end
    
    else
    begin
        count <= count + 1;
        delay <= 0;
    end
end

always@(*)
begin
IR = mem[count];
end
endmodule

