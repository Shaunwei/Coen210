//    A simple 32-bit by 32-word read-only memory model
module rom32(input     [31:0] address, 
             output reg[31:0]data_out);

  reg [31:0] rom_arrray [0:31];
  wire [4:0] rom_offset = address[6:2]; // the number of rom unit ( from 0 to 32 )

   initial
  begin
  rom_arrray [0]={ 6'd8, 5'd0, 5'd6, 16'd0 };   //addi $6,$0,0 $6=0
  rom_arrray [1]={ 6'd8, 5'd0, 5'd7, 16'd1 };   //addi $7,$0,1 $7=1   
  rom_arrray [2]={ 6'd35, 5'd0, 5'd1, 16'd0 };  //lw $1,mem[0] $1=1
  rom_arrray [3]={ 6'd4, 5'd1, 5'd7, 16'd1 };  //beq $1,$7,1
  rom_arrray [4]={ 6'd8, 5'd6, 5'd6, 16'd1 };   //addi $6,$6,1 $6=$6+1   
  rom_arrray [5]={ 6'd35, 5'd0, 5'd2, 16'd4 };  //lw $2,mem[1] $2=0
  rom_arrray [6]={ 6'd4, 5'd2, 5'd7, 16'd1 };  //beq $2,$7,1
  rom_arrray [7]={ 6'd8, 5'd6, 5'd6, 16'd1 };   //addi $6,$6,1 $6=$6+1  
  rom_arrray [8]={ 6'd35, 5'd0, 5'd3, 16'd8 };  //lw $3,mem[2] $3=0
  rom_arrray [9]={ 6'd4, 5'd3, 5'd7, 16'd1 }; //beq $3,$0,3
  rom_arrray [10]={ 6'd8, 5'd6, 5'd6, 16'd1 };   //addi $6,$6,1 $6=$6+1  
  rom_arrray [11]={ 6'd35, 5'd0, 5'd4, 16'd12 };  //lw $4,mem[3] $3=1
  rom_arrray [12]={ 6'd4, 5'd4, 5'd7, 16'd1 }; //beq $4,$0,3
  rom_arrray [13]={ 6'd8, 5'd6, 5'd6, 16'd1 };   //addi $6,$6,1 $6=$6+1  
  rom_arrray [14]={ 6'd43, 5'd0, 5'd6, 16'd16 }; //sw, $6,mem[4]  
       /*
	   The programe is designed to counts zeros in a set of data,we initial mem[0]=1,mem[1]=0,mem[2]=0,mem[3]=1.
	   $6 is the count numbers, if mem[i]=0, $6=$6+1, then we store result $6=2 in mem[4].
       */ 
  
  /*
  rom_arrray [0]={ 6'd35, 5'd0, 5'd1, 16'd4 };  //lw $1,mem[1] $1=1
  rom_arrray [1]={ 6'd35, 5'd0, 5'd2, 16'd8 };  //lw $2,mem[2] $2=2
  rom_arrray [2]={ 6'd35, 5'd0, 5'd3, 16'd12 }; //lw $3,mem[3] $3=3
  rom_arrray [3]={ 6'd8, 5'd0, 5'd4, 16'd4 };  //addi $4,$0,4 $4=4
  rom_arrray [4]={ 6'd35, 5'd0, 5'd5, 16'd20 };  //lw $5,mem[5] $5=5
  rom_arrray [5]={ 6'd35, 5'd0, 5'd6, 16'd24 };  //lw $2,mem[6] $6=sel
  rom_arrray [6]={ 6'd4, 5'd6, 5'd0, 16'd3 }; //beq $6,$0,3   +
  rom_arrray [7]={ 6'd4, 5'd6, 5'd1, 16'd4 }; //beq $6,$1,4   -
  rom_arrray [8]={ 6'd4, 5'd6, 5'd2, 16'd5 }; //beq $6,$2,5   *
  rom_arrray [9]={ 6'd4, 5'd6, 5'd3, 16'd10 }; //beq $6,$3,10   or/and
                   //add
  rom_arrray [10]={ 6'd0, 5'd5, 5'd4, 5'd7, 5'd0, 6'd32 }; //add $7,$5,$4
  rom_arrray [11]={ 6'd2, 26'd22 }; // J to array22
                   //sub
  rom_arrray [12]={ 6'd0, 5'd5, 5'd4, 5'd7, 5'd0, 6'd34 }; //sub $7,$5,$4  
  rom_arrray [13]={ 6'd2, 26'd22 }; // J to array22
                  //multiply
  rom_arrray [14]={ 6'd0, 5'd0, 5'd0, 5'd7, 5'd0, 6'd32 }; //add $7,$0,$0
  rom_arrray [15]={ 6'd0, 5'd5, 5'd7, 5'd7, 5'd0, 6'd32 }; //add $7,$7,$5
  rom_arrray [16]={ 6'd0, 5'd4, 5'd1, 5'd4, 5'd0, 6'd34 }; //sub $4,$4,$1
  rom_arrray [17]={ 6'd0, 5'd4, 5'd1, 5'd8, 5'd0, 6'd42 }; //slt $8,$4,$1  $8=($4<1)?1:0
  rom_arrray [18]={ 6'd4, 5'd8, 5'd0, -16'd4 }; //beq $8,$0,-4
  rom_arrray [19]={ 6'd2, 26'd22 }; // J to array 22
                  //and  or
  rom_arrray [20]={ 6'd0, 5'd5, 5'd4, 5'd7, 5'd0, 6'd36 }; //and $7,$5,$4
  rom_arrray [21]={ 6'd0, 5'd5, 5'd4, 5'd9, 5'd0, 6'd37 }; //or  $9,$5,$4
                 //result
  rom_arrray [22]={ 6'd43, 5'd0, 5'd7, 16'd0 }; //sw, $7,mem[0]
  rom_arrray [23]={ 6'd43, 5'd0, 5'd9, 16'd28 }; //sw, $9,mem[7]
  */
  end 
 
/* initial
  begin                                                    // here we should initial mem[1]=2,mem[2]=4,mem[3]=6
  rom_arrray [0]={ 6'd35, 5'd0, 5'd1, 16'd4 };             //lw $1,mem[1]   $1=2
  rom_arrray [1]={ 6'd35, 5'd0, 5'd2, 16'd8 };             //lw $2,mem[2]   $2=4
  rom_arrray [2]={ 6'd35, 5'd0, 5'd3, 16'd12 };            //lw $3,mem[3]   $3=6
  rom_arrray [3]={ 6'd0, 5'd2, 5'd3, 5'd4, 5'd0, 6'd32 };  //add $4,$2,$3   $4=$2+$3=10
  rom_arrray [4]={ 6'd0, 5'd4, 5'd0, 5'd5, 5'd0, 6'd32 };  //sub $5,$4,$0   $5=$4
  rom_arrray [5]={ 6'd0, 5'd5, 5'd1, 5'd5, 5'd0, 6'd34 };  //sub $5,$5,$1   $5=$5-$1=10-2
  rom_arrray [6]={ 6'd0, 5'd5, 5'd2, 5'd6, 5'd0, 6'd42 };  //slt $6,$5,$2   $6=($5<4)? 1 :0
  rom_arrray [7]={ 6'd4, 5'd6, 5'd0, -16'd3 };             //beq $6,$0,-3
  rom_arrray [8]={ 6'd43, 5'd0, 5'd5, 16'd0 };             //sw, $5,mem[0]
  end 
  */
  
  always @(rom_offset) // monitor the change of the rom
    begin
	data_out = rom_arrray [rom_offset];
    $display($time, " reading data: rom32[%h] => %h", address, data_out);
    end
endmodule