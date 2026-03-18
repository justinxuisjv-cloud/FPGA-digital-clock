`timescale 1ns / 1ns

module test;
  reg clk = 0;
  wire [5:0] mins, secs;

  Time t (.clk(clk), .hours(hours), .mins(mins), .secs(secs));

  initial forever #1 clk = ~clk;  // 50 MHz → Adjust for 50 Hz during fast sim

  initial begin
    $display("Time  | hours  | mins | secs");
    repeat(13000) begin
      #100 $display("%t | %d | %d | %d", $time, hours, mins, secs);
    end
    $stop;
  end
endmodule