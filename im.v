module IM(
    input [31:0] addr;
    input clk;
    output reg [31:0] inst;);

    reg [31:0] mem [0:255];

    initial begin
        //TODO add instructions to project.txt
        $readmemh('project.txt', mem);
    end

    always @(posedge clk) begin
        inst <= mem[addr[31:2]];
    end
endmodule