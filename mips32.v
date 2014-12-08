module mips32(input clk, reset);
    // instruction bus
    wire [31:0] instr;
    // break down important fields from instruction
    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] jumpoffset;
	wire [31:0] jumpaddress;
	
    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign funct = instr[5:0];
    assign immed = instr[15:0];
    assign jumpoffset = instr[25:0];
  
	// sign-extender
    assign extend_immed = { {16{immed[15]}}, immed };
    
    // branch offset shifter
    assign b_offset = extend_immed << 2;

    // datapath signals
    wire [4:0] wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out,
                b_tgt, pc_nexta,pc_nextb, pc, pc_incr, br_add_out, 
                datamem_rdata;
    
    // control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, 
         MemWrite, ALUSrc, Zero;
    wire [1:0] ALUOp;
    wire [3:0] Operation;
	
	assign jumpaddress = {pc_incr[31:28],instr[25:0],2'b00};
// module instantiations

//next pc logic
    PC_reg32	PC(clk, reset, pc_nextb, pc);
    rom32 	Instr_MEM(pc, instr);
    add32 	PC_adder(pc, 32'd4, pc_incr);
	mux2 	PCMUX           (PCSrc, pc_incr, b_tgt, pc_nexta);
//register file logic
    mux2 	RegFileMUX (RegDst, rt, rd, wn);
    reg_file	REG_FILE(clk, RegWrite, 
	                  rs, rt, wn, 
					  rfile_wd,
					  rfile_rd1, rfile_rd2);
//ALU logic					  
    mux2 	ALUMUX (ALUSrc, rfile_rd2, extend_immed, alu_b);
    alu 	ALU    (Operation, rfile_rd1, alu_b, alu_out, Zero);
	and		Branch_AND(PCSrc, Branch, Zero);
	
//Data memory logic
    mem32 	Data_MEM(clk, MemRead, MemWrite, alu_out, rfile_rd2, 
  			     datamem_rdata);
    mux2 	WriteRegFileMUX (MemtoReg, alu_out, datamem_rdata, rfile_wd);
    
    add32 	Branch_adder(pc_incr, b_offset, b_tgt); 
	mux2 	JumpMUX         (Jump, pc_nexta, jumpaddress, pc_nextb);
    
    main_control MainCTL(.opcode(opcode), .RegDst(RegDst), 
                       .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), 
                       .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp));

    alu_ctl 	ALUCTL(ALUOp, funct, Operation);
endmodule

