`include "fifo.v"

module fifo_tb;

  // Parameters
  parameter DEPTH = 8;
  parameter DATA_WIDTH = 8;

  // Inputs
  reg clk;
  reg rst_n;
  reg w_en;
  reg r_en;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;

  // Instantiate the FIFO module
  fifo #(
    .DEPTH(DEPTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock generation
  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #10;
    rst_n = 1;
  end

  // Write test
  initial begin
    // Wait for the FIFO to empty
    repeat (10) @(posedge clk);

    // Write some data to the FIFO
    for (int i = 0; i < DEPTH-1; i++) begin
      w_en = 1;
      data_in = i;
      @(posedge clk);
      $display("WRITTEN: %d, FULL: %0d, EMPTY: %0d", i, full, empty);
    end


    // Wait for a while
    repeat (10) @(posedge clk);

    // Disable write enable
    w_en = 0;

    // Wait for a while
    repeat (10) @(posedge clk);

    // Read some data from the FIFO
    for (int i = 0; i < DEPTH-1; i++) begin
        r_en = 1;
        @(posedge clk);
        $display("READING: %d, FULL: %0d, EMPTY: %0d", data_out, full, empty);
        if (data_out !== i) begin
            $error("Data mismatch: expected %d, actual %d", i, data_out);
        end
    end

    // Try to read more data (FIFO should be empty)
    r_en = 1;
    @(posedge clk);

    // Wait for a while
    repeat (10) @(posedge clk);

    // Disable read enable
    r_en = 0;

    // Wait for a while
    repeat (10) @(posedge clk);

    $finish;

  end

endmodule

