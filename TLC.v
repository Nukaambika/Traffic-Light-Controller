`timescale 1ns/1ps


`define true  1
`define false 0
`define y2rdelay 3
`define r2gdelay 2
 
module TLC(hwy,cntry,x,clock,clear);

input x,clock,clear;
output reg [1:0] hwy,cntry;

reg [2:0] state,next_state;

parameter S0=3'd0,
          S1=3'd1,
          S2=3'd2,
          S3=3'd3,
          S4=3'd4,
          red=2'd0,
          yellow=2'd1,
          green=2'd2;

always @(posedge clock)
  if(clear)
    state<=S0;
  else
    state<=next_state;

always@(state)
  begin
    hwy=green;
    cntry=red;
    case(state)
      S0: ;
      S1: hwy=yellow;
      S2: hwy=red;
      S3:
        begin
          hwy=red;
          cntry=green;
        end
      S4:
         begin
           hwy=red;
           cntry=yellow;
         end
    endcase
  end
always @ (state or x )
   begin
     case(state)
       S0: if(x)
             next_state=S1;
           else
             next_state=S0;
       S1: 
         begin
           repeat(`y2rdelay) @(posedge clock) next_state=S1;
           next_state=S2;
         end
       S2: 
         begin
           repeat(`r2gdelay) @ (posedge clock) next_state=S2;
           next_state=S3;
         end
       S3: if(x)
             next_state=S3;
           else
             next_state=S4;
       S4: 
         begin
           repeat(`y2rdelay) @ (posedge clock) next_state=S4;
           next_state=S0;
         end
       default: next_state=S0;
     endcase
   end
endmodule
