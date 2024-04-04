/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_couchand_chacha (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg  [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  core core_instance (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .addr(addr),
    .write_n(write_n),
    .round_n(round_n),
    .data_out(data_out),
    .round_count(round_count)
  );

  assign uio_out = 8'b0;
  assign uio_oe = 8'b0;

  reg [31:0] data_in;
  reg [3:0] addr;
  reg write_n;
  reg round_n;
  wire [31:0] data_out;
  wire [7:0] round_count;

  always @(posedge clk) begin
    if (!rst_n) begin
      data_in <= 32'b0;
      addr <= 4'b0;
      write_n <= 0;
      round_n <= 0;
    end else begin
      addr <= ui_in[3:0];
      data_in <= data_out;
      write_n <= !write_n;
      round_n <= !round_n;

      uo_out <= data_out[7:0];
    end
  end


endmodule
