`timescale 1ns/1ps 
module temp_tb ();  
reg clk, rst; 
reg led;
wire r,g;
wire  [7:0] dataout;
wire cs;
wire din;
wire sclk;
//wire dataout;
//reg en;
wire rs,rw,en;
temp t(clk,rst,cs,din,dataout,en,rs,rw,sclk,led,r,g);
initial begin
 clk = 0;
forever #50 clk=~clk;
end
//initial begin
 //rst = 1;
 //#120
 //rst = 0;
//end
endmodule