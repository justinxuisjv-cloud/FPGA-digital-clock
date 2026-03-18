module clock (
  input CLOCK_50,
  input KEY0, // decrement
  input KEY1, // increment
  input [2:0] SW,
  output [6:0] HEX0, HEX1,
  output reg [1:0] edit_mode
);
  wire tick_inc, tick_dec;
  wire [5:0] secs;
  wire flash_en;

  // Button processing
  IFAdvance #(.LONG(25_000_000), .PERIOD(5_000_000)) up_press (
    .clk(CLOCK_50), .in(~KEY1), .out(tick_inc)
  );

  IFAdvance #(.LONG(25_000_000), .PERIOD(5_000_000)) down_press (
    .clk(CLOCK_50), .in(~KEY0), .out(tick_dec)
  );

  // second counter
  Counter #(.MAX(59), .WIDTH(6)) sec_counter (
    .clk(CLOCK_50),
    .enable(0), 
    .plus(tick_inc),
    .minus(tick_dec),
    .cnt(secs)
  );

  wire [3:0] digit1 = secs / 10;
  wire [3:0] digit0 = secs % 10;
  wire [6:0] hex1_raw, hex0_raw;

  SSeg disp1 (.digit(digit1), .sseg(hex1_raw));
  SSeg disp0 (.digit(digit0), .sseg(hex0_raw));

  Flasher flash_gen (.clk(CLOCK_50), .flash_en(flash_en));

  // Display second temporarily
  assign HEX1 = (edit_mode == 1 && !flash_en) ? 7'b1111111 : hex1_raw;
  assign HEX0 = (edit_mode == 1 && !flash_en) ? 7'b1111111 : hex0_raw;
endmodule