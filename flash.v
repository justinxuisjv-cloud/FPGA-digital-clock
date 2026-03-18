module Flasher (
  input clk,
  output reg flash_en
);
  parameter PERIOD = 25_000_000;
  parameter ON_TIME = 20_000_000;

  reg [24:0] count = 0;

  always @(posedge clk) begin
    if (count < PERIOD - 1)
      count <= count + 1;
    else
      count <= 0;

    flash_en <= (count < ON_TIME);
  end
endmodule