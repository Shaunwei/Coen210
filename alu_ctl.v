module AluControl(
    input [1:0] alu_op;
    input [5:0] inst_func;
    output reg [3:0] control_out;);

    always @(*) begin
        case(alu_op)
            2'b00: control_out <= 4'b0010; //ADD
            2'b01: control_out <= 4'b0110; //SUB
            2'b10:
                begin
                    if (inst_func[3:0]==4'b0000) control_out<=4'b0010; //ADD
                    else if (inst_func[3:0]==4'b0010) control_out<=4'b0110; //SUB
                    else if (inst_func[3:0]==4'b0100) control_out<=4'b0000; //AND
                    else if (inst_func[3:0]==4'b1010) control_out<=4'b0111; //BEQ
                end
        endcase
    end

endmodule