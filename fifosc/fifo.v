



module fifo(
  input clk, rst_n,
  input w_en, r_en,
  input [16:0] data_in,
  output reg [16:0] data_out,
  output full, empty,

  input TM,
  input SI,
  output reg SO
);
  
  reg [2:0] w_ptr, r_ptr;
  reg w_en_reg, r_en_reg;
  reg [16:0] fifo[7:0];
  reg [16:0] data_in_reg;

  
  // Set Default values on reset.
  always@(posedge clk) 
  begin
      if(!rst_n) 
      begin
          w_ptr <= 0; 
          r_ptr <= 0;
          data_out <= 0;
      end
      else 
      begin

          if(!TM) begin
              data_in_reg <= data_in;
              w_en_reg <= w_en;
              r_en_reg <= r_en;
              // To read data from FIFO
              if(w_en_reg & !full)begin
                  fifo[w_ptr] <= data_in_reg;
                  w_ptr <= w_ptr + 1;
              end

              // To read data from FIFO
              if(r_en_reg & !empty) begin
                  data_out <= fifo[r_ptr];
                  r_ptr <= r_ptr + 1;
              end
          end

        else begin

      //$display("FIFO STATUS: %p rd=%d, wr=%d, data_in_reg=%x", fifo, r_ptr, w_ptr, data_in_reg);
           
//$display("r_en_reg  : %b", r_en_reg );
//$display("w_en_reg  : %b", w_en_reg );
//$display("r_ptr[0]  : %b", r_ptr[0] );
//$display("r_ptr[1]  : %b", r_ptr[1] );
//$display("r_ptr[2]  : %b", r_ptr[2] );
//$display("w_ptr[0]  : %b", w_ptr[0] );
//$display("w_ptr[1]  : %b", w_ptr[1] );
//$display("w_ptr[2]  : %b", w_ptr[2] );
//$display("data_in_reg[0]   : %b", data_in_reg[0]  );
//$display("data_in_reg[1]   : %b", data_in_reg[1]  );
//$display("data_in_reg[2]   : %b", data_in_reg[2]  );
//$display("data_in_reg[3]   : %b", data_in_reg[3]  );
//$display("data_in_reg[4]   : %b", data_in_reg[4]  );
//$display("data_in_reg[5]   : %b", data_in_reg[5]  );
//$display("data_in_reg[6]   : %b", data_in_reg[6]  );
//$display("data_in_reg[7]   : %b", data_in_reg[7]  );
//$display("data_in_reg[8]   : %b", data_in_reg[8]  );
//$display("data_in_reg[9]   : %b", data_in_reg[9]  );
//$display("data_in_reg[10]  : %b", data_in_reg[10] );
//$display("data_in_reg[11]  : %b", data_in_reg[11] );
//$display("data_in_reg[12]  : %b", data_in_reg[12] );
//$display("data_in_reg[13]  : %b", data_in_reg[13] );
//$display("data_in_reg[14]  : %b", data_in_reg[14] );
//$display("data_in_reg[15]  : %b", data_in_reg[15] );
//$display("data_in_reg[16]  : %b", data_in_reg[16] );
//$display("data_out[16]  : %b", data_out[16] );
//$display("data_out[15]  : %b", data_out[15] );
//$display("data_out[14]  : %b", data_out[14] );
//$display("data_out[13]  : %b", data_out[13] );
//$display("data_out[12]  : %b", data_out[12] );
//$display("data_out[11]  : %b", data_out[11] );
//$display("data_out[10]  : %b", data_out[10] );
//$display("data_out[9]   : %b", data_out[9]  );
//$display("data_out[8]   : %b", data_out[8]  );
//$display("data_out[7]   : %b", data_out[7]  );
//$display("data_out[6]   : %b", data_out[6]  );
//$display("data_out[5]   : %b", data_out[5]  );
//$display("data_out[4]   : %b", data_out[4]  );
//$display("data_out[3]   : %b", data_out[3]  );
//$display("data_out[2]   : %b", data_out[2]  );
//$display("data_out[1]   : %b", data_out[1]  );
//$display("data_out[0]   : %b", data_out[0]  );
//$display("SO  : %b", SO );
//$display("time:%t", $time);

            // Scan Chain
            
            r_en_reg <= SI;
            w_en_reg <= r_en_reg;
            r_ptr[0] <= w_en_reg;
            r_ptr[1] <= r_ptr[0];
            r_ptr[2] <= r_ptr[1];

            w_ptr[0] <= r_ptr[2];
            w_ptr[1] <= w_ptr[0];
            w_ptr[2] <= w_ptr[1];

            data_in_reg[0]  <= w_ptr[2];
            data_in_reg[1]  <= data_in_reg[0];
            data_in_reg[2]  <= data_in_reg[1];
            data_in_reg[3]  <= data_in_reg[2];
            data_in_reg[4]  <= data_in_reg[3];
            data_in_reg[5]  <= data_in_reg[4];
            data_in_reg[6]  <= data_in_reg[5];
            data_in_reg[7]  <= data_in_reg[6];
            data_in_reg[8]  <= data_in_reg[7];
            data_in_reg[9]  <= data_in_reg[8];
            data_in_reg[10] <= data_in_reg[9];
            data_in_reg[11] <= data_in_reg[10];
            data_in_reg[12] <= data_in_reg[11];
            data_in_reg[13] <= data_in_reg[12];
            data_in_reg[14] <= data_in_reg[13];
            data_in_reg[15] <= data_in_reg[14];
            data_in_reg[16] <= data_in_reg[15];

            data_out[16] <= data_in[16];
            data_out[15] <= data_out[16];
            data_out[14] <= data_out[15];
            data_out[13] <= data_out[14];
            data_out[12] <= data_out[13];
            data_out[11] <= data_out[12];
            data_out[10] <= data_out[11];
            data_out[9]  <= data_out[10];
            data_out[8]  <= data_out[9];
            data_out[7]  <= data_out[8];
            data_out[6]  <= data_out[7];
            data_out[5]  <= data_out[6];
            data_out[4]  <= data_out[5];
            data_out[3]  <= data_out[4];
            data_out[2]  <= data_out[3];
            data_out[1]  <= data_out[2];
            data_out[0]  <= data_out[1];
            SO <= data_out[0];
             
        end
      end
  end

  assign full = ((w_ptr+1'b1) == r_ptr);
  assign empty = (w_ptr == r_ptr);
endmodule
