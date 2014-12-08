module main_control(input  [5:0] opcode, // instruction [31:26]
                    output reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead,
					           MemWrite, Branch,Jump,
					output reg [1:0] ALUOp);

// match the instruction[31:26] with the following parameter
    parameter R_type = 6'd0;
    parameter LW     = 6'd35;
    parameter SW     = 6'd43;
    parameter BEQ    = 6'd4;
	parameter JUMP   = 6'd2;
	parameter ADDI   = 6'd8;
	
always @(opcode)
    begin
        case (opcode)
		  LW :     {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b0011110000;
		  
          SW :     {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b0x1x001000;
		  
		  R_type : {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b0100100010;
          
          BEQ :    {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b0x0x000101;
		  
		  JUMP :   {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b1xxx0x0xxx;
		  
		  ADDI :    {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'b0010100000;
		  
          default: {Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp}=10'bxxxxxxxxx;
		  
        endcase
    end
endmodule

