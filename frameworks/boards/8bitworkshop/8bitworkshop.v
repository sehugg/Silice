`define VERILATOR         1
`define COLOR_DEPTH       1

/*verilator lint_off pinmissing */
/*verilator lint_off undriven */

$$VERILATOR   = 1
$$NUM_LEDS    = 0
$$SIMULATION  = 1
$$color_depth = 1
$$color_max   = 1

`timescale 1ns / 1ps
`default_nettype none

module top(
  // NTSC
  output reg [`COLOR_DEPTH*3-1:0] rgb,
  output hsync,
  output vsync,
  input clk,
  input reset
  );

wire [`COLOR_DEPTH-1:0]  __main_video_r;
wire [`COLOR_DEPTH-1:0]  __main_video_g;
wire [`COLOR_DEPTH-1:0]  __main_video_b;
wire                     __main_video_hs;
wire                     __main_video_vs;

// main

wire   run_main;
assign run_main = 1'b1;
wire done_main;

M_main __main(
  .clock(clk),
  .reset(reset),
`ifdef NTSC
  .out_video_r(__main_video_r),
  .out_video_g(__main_video_g),
  .out_video_b(__main_video_b),
  .out_video_hs(__main_video_hs),
  .out_video_vs(__main_video_vs),
`endif  
  .in_run(run_main),
  .out_done(done_main)
);

assign rgb     = {__main_video_b[0], __main_video_g[0], __main_video_r[0]};
assign hsync    = __main_video_hs;
assign vsync    = __main_video_vs;

endmodule
