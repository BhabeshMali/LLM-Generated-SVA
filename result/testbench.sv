//Bhabesh Mali


// Code your testbench here
// or browse Examples
module timer_core_tb;

  // Parameters
  localparam int N = 1;

  // Signals
  reg clk_i;
  reg rst_ni;
  reg active;
  reg [11:0] prescaler;
  reg [7:0] step;
  wire logic tick;
  wire logic [63:0] mtime_d;
  reg [63:0] mtime;
  reg [63:0] mtimecmp [N];
  wire logic [N-1:0] intr;

  // Instance of timer_core
  timer_core #(.N(N)) dut (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .active(active),
    .prescaler(prescaler),
    .step(step),
    .tick(tick),
    .mtime_d(mtime_d),
    .mtime(mtime),
    .mtimecmp(mtimecmp),
    .intr(intr)
  );

  // Clock generation
  initial clk_i = 0;
  always #2 clk_i = !clk_i;  // Generate a clock with a period of 10 time units

  // Reset logic
  initial begin
    rst_ni = 0;
    #5 rst_ni = 1;  // Release reset after some time
  end

  // Stimulus logic
  initial begin
    active = 1;
    prescaler = 7;
    step = 8'd05;
    mtime = 64'd0;
    mtimecmp[0] = 64'd050;
    
    for(int i=0; i<60; i++)begin
      #1
      $display("i: %d, clk_i: %d, rst_ni: %d, tick_count: %d, tick: %d", i, clk_i, rst_ni, dut.tick_count, tick);
    end
    active = 0;
    for(int i=0; i<10; i++)begin
        #1
      $display(" i: %d, clk_i: %d, rst_ni: %d, tick_count: %d, tick: %d", i, clk_i, rst_ni, dut.tick_count, tick);
    end
    
    rst_ni = 0;
    for(int i=0; i<10; i++)begin
        #1
      $display(" i: %d, clk_i: %d, rst_ni: %d, tick_count: %d, tick: %d", i, clk_i, rst_ni, dut.tick_count, tick);
    end
    
    $finish;

  end

//   // Property check
//   property reset_behavior;
//     @(posedge clk_i)
//     (!rst_ni || !active) |-> (dut.tick_count == 0);
//   endproperty

//   assert property (reset_behavior);

  // Simulation control
//   initial begin
//     #100;  // Run the simulation for 1000 time units
//     $finish;
//   end

endmodule