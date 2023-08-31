`timescale 1ns/1ps

module tlc_tb();
reg clock,clear,x;
wire [1:0]hwy,cntry;

TLC tlc(.hwy(hwy),.cntry(cntry),.clock(clock),.x(x),.clear(clear));

initial 
  begin
    clock=0;
   forever #5 clock=~clock;
  end
initial
  begin
     clear=1;
     #5clear=0;
      x=0;
    #5 x=1; 
    #60 x=0;
    #100 $stop;
  end
endmodule