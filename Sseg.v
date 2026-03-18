module SSeg(input [3:0] digit, output reg [6:0] sseg);
  always @(*) begin
    case (digit)
      4'd0: sseg = 7'b1000000;
      4'd1: sseg = 7'b1111001;
      4'd2: sseg = 7'b0100100;
      4'd3: sseg = 7'b0110000;
      4'd4: sseg = 7'b0011001;
      4'd5: sseg = 7'b0010010;
      4'd6: sseg = 7'b0000010;
      4'd7: sseg = 7'b1111000;
      4'd8: sseg = 7'b0000000;
      4'd9: sseg = 7'b0011000;
      default: sseg = 7'b1111111;
    endcase
  end
endmodule