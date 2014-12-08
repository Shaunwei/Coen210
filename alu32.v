module ALU(
    input [31:0] a, b;
    input [4:0] ALUop;
    output zero;
    output reg [31:0] result);

    assign zero = (result==0);
    always @(ALUop, a, b) begin
        case (ALUop)
            0: result <= a & b; //0000 AND
            1: result <= a | b; //0001 OR
            2: result <= a + b; //0010 ADD
            6: result <= a - b; //0110 SUB
            7: result <= a < b ? b : 0;//0111 SLT
            12: result <= ~(a | b); //1100 NOR
            default: result <= 0;
        endcase
    end