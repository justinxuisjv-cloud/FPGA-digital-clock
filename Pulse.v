module PulseGen
#(parameter CYCLES = 9, WIDTH = $clog2(CYCLES + 1)) (input clk,input in,output reg out);
	reg [WIDTH-1:0] count;

	always @(posedge clk) begin
		if (!in) begin
		count <= 0;
		out <= 0;
	end else begin
		if (count == 0) begin
			out <= 1;
			count <= CYCLES;
		end else begin
			out <= 0;
			count <= count - 1;
		end
	end
end

endmodule