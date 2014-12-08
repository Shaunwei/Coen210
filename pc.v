module PC(
    input rst, clk;
    input [31:0] PCin;
    output reg [31:0] PCout);

    always @(posedge clk) begin
        if (rst) begin
            // reset
            PCout <= 0;
        end
        else begin
            PCout <= PCin + 4;
        end
    end
endmodule