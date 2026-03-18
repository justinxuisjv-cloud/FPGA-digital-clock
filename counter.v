module Counter
  #(parameter MAX = 59, WIDTH = 6, UP = 1)(
    input clk,
    input enable,
    input plus,
    input minus,
    output reg [WIDTH - 1:0] cnt
  );

  initial cnt = 0;

  reg [WIDTH - 1:0] next_cnt;

  always @(posedge clk)
    cnt <= next_cnt;

  always @(*) begin
    if (plus && !minus)
      next_cnt = (cnt == MAX) ? 0 : cnt + 1;
    else if (!plus && minus)
      next_cnt = (cnt == 0) ? MAX : cnt - 1;
    else if (enable && !plus && !minus)
      next_cnt = (UP == 1) ? ((cnt == MAX) ? 0 : cnt + 1) : ((cnt == 0) ? MAX : cnt - 1);
    else
      next_cnt = cnt;
  end
endmodule