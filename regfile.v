module RegFile(
    input [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] write_data;
    input clk;
    input RegWrite;
    output [31:0] read_data1, read_data2;)

    reg [31:0] reg_mem [0:31];

    assign read_data1 = reg_mem[read_reg1];
    assign read_data2 = reg_men[read_reg2];

    initial
    begin
        reg_mem[0] <= 32'd0; // $zero=0
    end

    always @(posedge clk) begin
        if (RegWrite) 
            reg_mem[write_reg] <= write_data;
    end

endmodule