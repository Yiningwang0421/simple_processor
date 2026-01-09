`timescale 1ns/1ps

module tb_regfile_8x8;

  reg         clk;
  reg         rst_n;
  reg  [2:0]  ra, rb, wa;
  reg         we;
  reg  [7:0]  wd;
  wire [7:0]  rd_a, rd_b;

  regfile_8x8 dut (
    .clk(clk),
    .rst_n(rst_n),
    .ra(ra),
    .rb(rb),
    .wa(wa),
    .we(we),
    .wd(wd),
    .rd_a(rd_a),
    .rd_b(rd_b)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst_n = 1;
    we = 0;
    ra = 0; rb = 0; wa = 0; wd = 0;

    $display("[%0t] INIT rst_n=%0d", $time, rst_n);

    #20;
    @(posedge clk);
    $display("[%0t] BEFORE RESET ASSERT rst_n=%0d", $time, rst_n);
    $display("[%0t] READ ra=%0d rd_a=%02h", $time, ra, rd_a);

    rst_n = 0;
    $display("[%0t] RESET ASSERTED rst_n=%0d", $time, rst_n);
    
    #20;
    @(posedge clk);
    rst_n = 1;

    #20;
    @(posedge clk);
    $display("[%0t] TRY WRITE: we=%0d wa=%0d wd=%02h rst_n=%0d",
             $time, we, wa, wd, rst_n);

    we = 1;
    wa = 3;
    wd = 8'h55;

    #20;
    @(posedge clk);
    $display("[%0t] WRITE EDGE: we=%0d wa=%0d wd=%02h rst_n=%0d",
             $time, we, wa, wd, rst_n);

    we = 0;

    #1;
    ra = 3;
    #1;
    $display("[%0t] READ ra=%0d rd_a=%02h", $time, ra, rd_a);

    if (rd_a !== 8'h55)
      $display("ERROR: R3 = %h, expected 55", rd_a);
    else
      $display("PASS: R3 = %h", rd_a);

    #20;
    $finish;
  end

endmodule