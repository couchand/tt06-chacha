`define default_netname none

module core (
    input  wire clk,
    input  wire rst_n,
    input  wire [31:0] data_in,
    input  wire [3:0] addr,
    input  wire write_n,
    input  wire round_n,
    output wire [31:0] data_out,
    output reg [7:0] round_count
);

  reg [31:0] cells[15:0];

  assign data_out = cells[addr];

  wire [31:0] a0_in = cells[0];
  wire [31:0] b0_in = round_count[0] ? cells[5] : cells[4];
  wire [31:0] c0_in = round_count[0] ? cells[10] : cells[8];
  wire [31:0] d0_in = round_count[0] ? cells[15] : cells[12];

  wire [31:0] a0_out;
  wire [31:0] b0_out;
  wire [31:0] c0_out;
  wire [31:0] d0_out;

  qr qr0(
    .a_in(a0_in),
    .b_in(b0_in),
    .c_in(c0_in),
    .d_in(d0_in),
    .a_out(a0_out),
    .b_out(b0_out),
    .c_out(c0_out),
    .d_out(d0_out)
  );

/*
  wire [31:0] a1_in = cells[1];
  wire [31:0] b1_in = round_count[0] ? cells[6] : cells[5];
  wire [31:0] c1_in = round_count[0] ? cells[11] : cells[9];
  wire [31:0] d1_in = round_count[0] ? cells[12] : cells[13];

  wire [31:0] a1_out;
  wire [31:0] b1_out;
  wire [31:0] c1_out;
  wire [31:0] d1_out;

  qr qr1(
    .a_in(a1_in),
    .b_in(b1_in),
    .c_in(c1_in),
    .d_in(d1_in),
    .a_out(a1_out),
    .b_out(b1_out),
    .c_out(c1_out),
    .d_out(d1_out)
  );

  wire [31:0] a2_in = cells[2];
  wire [31:0] b2_in = round_count[0] ? cells[7] : cells[6];
  wire [31:0] c2_in = round_count[0] ? cells[8] : cells[10];
  wire [31:0] d2_in = round_count[0] ? cells[13] : cells[14];

  wire [31:0] a2_out;
  wire [31:0] b2_out;
  wire [31:0] c2_out;
  wire [31:0] d2_out;

  qr qr2(
    .a_in(a2_in),
    .b_in(b2_in),
    .c_in(c2_in),
    .d_in(d2_in),
    .a_out(a2_out),
    .b_out(b2_out),
    .c_out(c2_out),
    .d_out(d2_out)
  );

  wire [31:0] a3_in = cells[3];
  wire [31:0] b3_in = round_count[0] ? cells[4] : cells[7];
  wire [31:0] c3_in = round_count[0] ? cells[9] : cells[11];
  wire [31:0] d3_in = round_count[0] ? cells[14] : cells[15];

  wire [31:0] a3_out;
  wire [31:0] b3_out;
  wire [31:0] c3_out;
  wire [31:0] d3_out;

  qr qr3(
    .a_in(a3_in),
    .b_in(b3_in),
    .c_in(c3_in),
    .d_in(d3_in),
    .a_out(a3_out),
    .b_out(b3_out),
    .c_out(c3_out),
    .d_out(d3_out)
  );
*/

  always @(posedge clk) begin
    if (!rst_n) begin
      round_count <= 8'b0;
      for (int i = 0; i < 16; i++) begin
        cells[i] <= 32'b0;
      end
    end else if (!write_n) begin
      cells[addr] <= data_in;
    end else if (!round_n) begin
      if (!round_count[0]) begin
        cells[0] <= a0_out;
/*
        cells[1] <= a1_out;
        cells[2] <= a2_out;
        cells[3] <= a3_out;
*/
        cells[4] <= b0_out;
/*
        cells[5] <= b1_out;
        cells[6] <= b2_out;
        cells[7] <= b3_out;
*/
        cells[8] <= c0_out;
/*
        cells[9] <= c1_out;
        cells[10] <= c2_out;
        cells[11] <= c3_out;
*/
        cells[12] <= d0_out;
/*
        cells[13] <= d1_out;
        cells[14] <= d2_out;
        cells[15] <= d3_out;
*/
/*
      end else begin
        cells[0] <= a0_out;
        cells[1] <= a1_out;
        cells[2] <= a2_out;
        cells[3] <= a3_out;
        cells[5] <= b0_out;
        cells[6] <= b1_out;
        cells[7] <= b2_out;
        cells[4] <= b3_out;
        cells[10] <= c0_out;
        cells[11] <= c1_out;
        cells[8] <= c2_out;
        cells[9] <= c3_out;
        cells[15] <= d0_out;
        cells[12] <= d1_out;
        cells[13] <= d2_out;
        cells[14] <= d3_out;
*/
      end
      round_count <= round_count + 1;
    end
  end

endmodule
