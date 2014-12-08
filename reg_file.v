module reg_file (input clk, RegWrite,
                 input [4:0] RN1, RN2, WN,
                 input [31:0] WD, 
                 output [31:0] RD1, RD2);
				
  reg [31:0] file_array [31:0];
  //read regfile
  assign RD1 = file_array [RN1];
  assign RD2 = file_array [RN2];
  
  initial 
  begin
  file_array[0]=32'd0; // $zero=0
  end
// write to the regfile
  always @(posedge clk) 
    if (RegWrite && (WN != 0))
    begin
      file_array[WN] <= WD;
    end
endmodule
