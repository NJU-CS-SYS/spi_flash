module test;
  reg[0:0] io_flash_en = 0;
  reg[0:0] io_flash_write = 0;
  reg[3:0] io_quad_io = 0;
  reg[23:0] io_flash_addr = 0;
  reg[31:0] io_flash_data_in = 0;
  reg[31:0] io_flash_data_out = 0;
  wire[11:0] io_state_to_cpu;
  wire[31:0] io_buffer_to_cpu;
  wire[0:0] io_SI;
  wire[0:0] io_tri_si;
  wire[0:0] io_cs;
  reg clk = 0;
  reg reset = 1;
  integer clk_len;
  always #clk_len clk = ~clk;
  reg vcdon = 0;
  reg [1023:0] vcdfile = 0;
  reg [1023:0] vpdfile = 0;

  /*** DUT instantiation ***/
  SPIFlashModule SPIFlashModule(
    .clk(clk),
    .reset(reset),
    .io_flash_en(io_flash_en),
    .io_flash_write(io_flash_write),
    .io_quad_io(io_quad_io),
    .io_flash_addr(io_flash_addr),
    .io_flash_data_in(io_flash_data_in),
    .io_flash_data_out(io_flash_data_out),
    .io_state_to_cpu(io_state_to_cpu),
    .io_buffer_to_cpu(io_buffer_to_cpu),
    .io_SI(io_SI),
    .io_tri_si(io_tri_si),
    .io_cs(io_cs));

  initial begin
    clk_len = `CLOCK_PERIOD;
    $init_clks(clk_len);
    $init_rsts(reset);
    $init_ins(io_flash_en, io_flash_write, io_quad_io, io_flash_addr, io_flash_data_in, io_flash_data_out);
    $init_outs(io_state_to_cpu, io_buffer_to_cpu, io_SI, io_tri_si, io_cs);
    $init_sigs(SPIFlashModule);
    /*** VCD & VPD dump ***/
    if ($value$plusargs("vcdfile=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, SPIFlashModule);
      $dumpoff;
      vcdon = 0;
    end
    if ($value$plusargs("vpdfile=%s", vpdfile)) begin
      $vcdplusfile(vpdfile);
      $vcdpluson(0);
      $vcdplusautoflushon;
    end
    if ($test$plusargs("vpdmem")) begin
      $vcdplusmemon;
    end
  end

  always @(negedge clk) begin
    $tick();
    if (vcdfile && (reset)) begin
      $dumpoff;
      vcdon = 0;
    end
    else if (vcdfile && !vcdon) begin
      $dumpon;
      vcdon = 1;
    end
  end

endmodule
