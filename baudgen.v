module baudgen(input clk, output reg baudclk);

  //TODO parametrize to support other baud rates and clocks
  localparam MAX = 16'd10_416; //100_000_000/9_600; 
  reg [15:0] counter = 16'd0;

  always@(posedge clk) begin
    if(counter==MAX) begin
      baudclk <= 1'b1;
      counter <= 16'd0;
    end else begin
      baudclk <= 1'b0;
      counter <= counter + 1'b1;
    end
  end
  

endmodule
