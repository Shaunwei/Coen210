module DM(
    input [31:0] addr, write_data;
    output [31:0] read_data;
    input clk;
    input MemWrite, MemRead;);

    reg [31:0] data_mem [0:255];

    always @(posedge clk) begin
        if (MemWrite) 
            data_mem[addr] = write_data;
    end

    always @(posedge clk) begin
        if (MemRead)
            read_data = data_mem[addr];
    end

endmodule