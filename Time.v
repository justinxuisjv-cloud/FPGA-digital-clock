module Time (input clk, output [4:0] hours, output [5:0] mins, secs);
  localparam N = 50_000_000;
  localparam BW = $clog2(N);
  wire [BW-1:0] tick;

  Counter #(.MAX(N - 1), .WIDTH(BW))
    divider (.clk(clk), .enable(1'b1), .cnt(tick));

  Counter #(.MAX(59), .WIDTH(6))
    cs (.clk(clk), .enable(tick == 0), .cnt(secs));

  Counter #(.MAX(59), .WIDTH(6))
    cm (.clk(clk), .enable((secs == 0) && (tick == 0)), .cnt(mins));
  
  Counter #(.MAX(23), .WIDTH(5))
    ch (.clk(clk), .enable((mins == 0) && (secs == 0) && (tick == 0)), .cnt(hours));

endmodule