module mem32(input clk, mem_read, mem_write, 
             input      [31:0]address, data_in, 
             output reg [31:0]data_out);
  

  reg [31:0] mem_array [0:31];
  wire [4:0] mem_offset = address[6:2]; // the number of mem_array (from 0 to 32)
 
  always @(mem_read or mem_offset or mem_array[mem_offset])
  begin

    if (mem_read )
    begin
      data_out = mem_array[mem_offset];
      $display($time, " reading data: Mem[%h] => %h", address, data_out);//monitor the mem change
    end
      else data_out = 32'hxxxxxxxx;
  end
always @(posedge clk)
  begin
    if (mem_write)
    begin
      $display($time, " writing data: Mem[%h] <= %h", address,data_in);
      mem_array[mem_offset] <= data_in;
    end
  end
// preload some data into memory
  initial 
  begin
    mem_array[0] = 1;
	mem_array[1] = 0;
	mem_array[2] = 0;
	mem_array[3] = 1;
  end
endmodule
