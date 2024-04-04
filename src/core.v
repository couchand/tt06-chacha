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

  always @(posedge clk) begin
    if (!rst_n) begin
      round_count <= 8'b0;
      for (int i = 0; i < 16; i++) begin
        cells[i] <= 32'b0;
      end
    end else if (!write_n) begin
      cells[addr] <= data_in;
    //end else if (!round_n) begin
    end
  end

endmodule
