module uarttx(
  input clk,
  input newDataReady,
  input [7:0] newData, 
  output reg ready,
  output reg tx = 1'b1 //bad style?
);

wire baudClk;
//clock gate baud gen?
baudgen b(clk, baudClk);

//state declaration
localparam 
  //IDLE = 'd0,
  START = 2'd1,
  SEND = 2'd2,
  STOP = 2'd3;

reg [1:0] state = STOP;
reg [1:0] nextState; //wire
always@(posedge clk) if(baudClk) state <= nextState; 

reg [2:0] counter = 3'd0;

reg [7:0] data;

reg dataWaiting = 1'd0; //flag 
             
//next state calc
always@(*) begin
  nextState = state; //default to stay in current
  case(state)
    START: nextState = SEND;
    SEND: if(counter==7) nextState = STOP;
    STOP: if(dataWaiting) nextState = START; 
    default: nextState = 2'bxx;
  endcase
end

//output calc
always@(posedge clk) begin
  if(baudClk)
    case(state)
      START: tx <= 1'b0;
      SEND: tx <= data[counter]; 
      STOP: tx <= 1'b1; 
      default: tx <= 1'bx;
    endcase    
end

//counter calc
always@(posedge clk) begin
  if(baudClk)
    if(state==SEND) counter <= counter + 3'd1;
    else counter <= 3'd0;
end

//ready calc
always@(posedge clk) begin
  if(baudClk)
    if(state==STOP && !dataWaiting) ready<=1'b1;
    else ready<=1'b0;
end


//data capture
always@(posedge clk) begin
  if(state==STOP && newDataReady) begin
    data<=newData;
    dataWaiting<=1'b1;
  end else begin
    data<=data;
    if(state==STOP) dataWaiting<=dataWaiting; //ugly and implied?
    else dataWaiting <= 1'b0;
  end
end

endmodule
