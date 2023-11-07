module fifo #(parameter DEPTH=8, DATA_WIDTH=16) (
  input clk, rst_n,
  input w_en, r_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output full, empty
);
  
  reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
  reg [DATA_WIDTH-1:0] fifo[DEPTH];
  
  // Set Default values on reset.
  always@(posedge clk) 
  begin
      if(!rst_n) 
      begin
          w_ptr <= 0; r_ptr <= 0;
          data_out <= 0;
      end
      else 
      begin

          // To read data from FIFO
          if(w_en & !full)begin
              fifo[w_ptr] <= data_in;
              w_ptr <= w_ptr + 1;
          end

          // To read data from FIFO
          if(r_en & !empty) begin
              data_out <= fifo[r_ptr];
              r_ptr <= r_ptr + 1;
          end
      end
  end

  assign full = ((w_ptr+1'b1) == r_ptr);
  assign empty = (w_ptr == r_ptr);
endmodule
