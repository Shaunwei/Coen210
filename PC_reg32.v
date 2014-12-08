module PC_reg32 (input clk, reset,
                 input     [31:0] d_in, 
                 output reg[31:0]d_out);
   
    always @(posedge clk)
    begin
        if (reset) d_out <= 0;
        else d_out <= d_in;
    end

endmodule
