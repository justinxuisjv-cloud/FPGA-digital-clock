module IFAdvance
  #(parameter LONG = 25_000_000, PERIOD = 5_000_000) ( // Adjust for clock
    input clk,
    input in,
    output reg out
  );

  localparam BWL = $clog2(LONG + 1);
  localparam BWP = $clog2(PERIOD);

  reg [BWL-1:0] cl = 0, next_cl;
  reg [BWP-1:0] cp = 0, next_cp;

  reg next_out;

  always @(posedge clk)
    {cl, cp, out} <= {next_cl, next_cp, next_out};

  always @(*) begin
    next_cl = cl;
    next_cp = cp;
    next_out = 0;

    if (!in) begin
      next_cl = 0;
      next_cp = 0;
      next_out = 0;
    end else if (cl < LONG) begin
      next_cl = cl + 1;
      if (cl == 0)
        next_out = 1; // Short press output
    end else begin
      next_cp = (cp == PERIOD - 1) ? 0 : cp + 1;
      next_out = (cp == 0) ? 1 : 0; // Fast pulse
    end
  end
endmodule