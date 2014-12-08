module add32(input [31:0] a, b, 
             output [31:0] sum); 
assign sum = a + b; // There is no carry in and carry out
endmodule