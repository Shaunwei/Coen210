module alu(input	  [3:0]ctl,
           input	  [31:0]a, b, 
           output reg [31:0]result,
           output reg zero);

  always @(a or b or ctl)
  begin
    case (ctl)
      4'b0000 : result = a & b; // AND
      4'b0001 : result = a | b; // OR
      4'b0010 : result = a + b; // ADD
      4'b0110 : result = a - b; // SUBTRACT
      4'b0111 : if (a < b) result = 32'd1; 
               else result = 32'd0; //SLT      
      default : result = 32'hxxxx;
   endcase
   if (result == 32'd0) zero = 1;
   else zero = 0;
 end
endmodule
