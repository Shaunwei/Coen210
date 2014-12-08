module alu_ctl(input [1:0] ALUOp, 
               input [5:0] Funct,
          output reg [3:0]ALUOperation); // Clt for ALU
		  
		     
	// Parameters for ALU Operations
    parameter ALU_add = 4'b0010;
    parameter ALU_sub = 4'b0110;
    parameter ALU_and = 4'b0000;
    parameter ALU_or  = 4'b0001;
    parameter ALU_slt = 4'b0111;
   
    // Parameters for Functionfield instruction[5:0]
    parameter Funct_add = 6'd32;
    parameter Funct_sub = 6'd34;
    parameter Funct_and = 6'd36;
    parameter Funct_or  = 6'd37;
    parameter Funct_slt = 6'd42;



	always @(ALUOp or Funct) // match the ALUop from the main control unit
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;  // load word and store word
            2'b01 : ALUOperation = ALU_sub;  // beq
            2'b10 : case (Funct)             // R_type and Funct=Instruction[5:0] decide the R-type algorithm
        
   		  Funct_add   : ALUOperation = ALU_add;
          Funct_sub   : ALUOperation = ALU_sub;
          Funct_and   : ALUOperation = ALU_and;
          Funct_or    : ALUOperation = ALU_or;
          Funct_slt   : ALUOperation = ALU_slt;
          default : ALUOperation = 4'bxxxx;
                    endcase
            default ALUOperation = 4'bxxxx;
        endcase
    end
endmodule

