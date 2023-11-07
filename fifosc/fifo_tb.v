`include "fifo.v"
//`include "fifo_netlist.v"

module fifo_tb;

  // Inputs
  reg clk;
  reg rst_n;
  reg w_en;
  reg r_en;
  reg [16:0] data_in;
  reg SI;
  reg TM;

  // Outputs
  wire [16:0] data_out;
  wire full;
  wire empty;
  wire SO;

  reg [16:0] captured_data_out;

  // Instantiate the FIFO module
  fifo dut (
    .clk(clk),
    .rst_n(rst_n),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .SI(SI),
    .TM(TM),
    .SO(SO)
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

  // Dump
  initial begin
      $dumpfile("waves.vcd");
      $dumpvars();
  end

  // Write test
  initial begin

    w_en = 0;
    r_en = 0;
    data_in = 0;
    SI = 0;
    TM = 0;


    // Write some data to the FIFO
    repeat (10) @(posedge clk);
    w_en = 1;
    for (int i = 0; i < 7; i++) begin
      data_in = i;
      @(posedge clk);
      $display("WRITING: %d, FULL: %0d, EMPTY: %0d", i, full, empty);
    end
    w_en = 0;


    //// Read some data from the FIFO
    //repeat (10) @(posedge clk);
    //r_en = 1;
    //@(posedge clk);
    //for (int i = 0; i < 8; i++) begin
    //    @(posedge clk);
    //    $display("READING: %d, FULL: %0d, EMPTY: %0d", data_out, full, empty);
    //    if (data_out !== i) begin
    //        $error("Data mismatch: expected %d, actual %d", i, data_out);
    //    end
    //end
    //r_en = 0;
    //repeat (10) @(posedge clk);

    //////////////////////////// Now Use Scan //////////////////////////
    

    //////////// 1. Scan In first
    
    @(posedge clk);
    TM = 1;
    
    // load data in reverse binary (we're not writing though)
    repeat(17) begin
        @(posedge clk) SI = 1;
    end

    // load write pointer(to 5) in reverse binary (we're not writing though)
    @(posedge clk) SI = 1;
    @(posedge clk) SI = 0;
    @(posedge clk) SI = 1;

    // load read pointer(to 2) in reverse binary (we're reading)
    @(posedge clk) SI = 0;
    @(posedge clk) SI = 1;
    @(posedge clk) SI = 0;

    // load write enable
    @(posedge clk) SI = 0;

    // load read enable
    @(posedge clk) SI = 1;

    //////////// 2. Let the output get captured on output FFs
    
    @(posedge clk);
    TM = 0;


    //////////// 3. Scan out the captured output 
    
    @(posedge clk);
    TM = 1;
    SI = 0;

    repeat(17) begin
        @(posedge clk);
        captured_data_out[16] <= SO;
        captured_data_out[15] <= captured_data_out[16];
        captured_data_out[14] <= captured_data_out[15];
        captured_data_out[13] <= captured_data_out[14];
        captured_data_out[12] <= captured_data_out[13];
        captured_data_out[11] <= captured_data_out[12];
        captured_data_out[10] <= captured_data_out[11];
        captured_data_out[9]  <= captured_data_out[10];
        captured_data_out[8]  <= captured_data_out[9];
        captured_data_out[7]  <= captured_data_out[8];
        captured_data_out[6]  <= captured_data_out[7];
        captured_data_out[5]  <= captured_data_out[6];
        captured_data_out[4]  <= captured_data_out[5];
        captured_data_out[3]  <= captured_data_out[4];
        captured_data_out[2]  <= captured_data_out[3];
        captured_data_out[1]  <= captured_data_out[2];
        captured_data_out[0]  <= captured_data_out[1];
    end

    @(posedge clk);
    $display("Captured: %b", captured_data_out); // Error if != 2 (because we loaded 2 to the 2nd index of FIFO during Scan In)


    if(captured_data_out != 2) begin
        $error("Caught error: expected read = %d, got read = %d", 2, captured_data_out);
    end
    else begin
        $display("No error: expected read = %d, got read = %d", 2, captured_data_out);
    end

    $finish;

  end

endmodule

