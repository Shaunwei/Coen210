`timescale 1ns/1ns
module testbench (); 
reg clk; 
reg reset; 

initial
begin
reset <= 1; # 22; reset <= 0;
end
always 
begin 
clk <= 1; #5; clk <=0; #5;
end 

mips32 mipstest(clk,reset);

endmodule