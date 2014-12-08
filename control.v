module control(
    input [5:0] op;
    output reg reg_dst, reg_write;
    output reg mem_to_reg, mem_read, mem_write;
    output reg branch;
    output reg alu_src;
    output reg [1:0] alu_op);
    
    always @(*) begin
        case(op)
            6'b000000: begin // R-type
                {reg_dst, mem_to_reg, reg_write, mem_read, mem_write, branch}<=7'b1001000;
                alu_op <= 2'b10;
            end
            6'b100011: begin // lw
                {reg_dst, mem_to_reg, reg_write, mem_read, mem_write, branch}<=7'b0111100;
                alu_op <= 2'b00;
            end
            6'b101011: begin // sw
                {reg_dst, mem_to_reg, reg_write, mem_read, mem_write, branch}<=7'b0100010;
                alu_op <= 2'b00;
            end
            6'b000100: begin // beq
                {reg_dst, mem_to_reg, reg_write, mem_read, mem_write, branch}<=7'b0000001;
                alu_op <= 2'b01;
            end
        endcase
    end

endmodule