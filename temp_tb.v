`timescale 1ns/1ps 
module temp_tb ();  
reg clk, rst; 
wire  led;
wire r,g;
wire  [7:0] dataout;
wire cs;
wire din;
wire sclk;
reg db;
wire doutb;
wire do;
//wire dataout;
//reg en;
wire rs,rw,en;
temp t(clk,rst,cs,din,dataout,en,rs,rw,sclk,led,r,g,doutb,db,do);
initial
    begin
        
//forever #50 clk=~clk;
//begin
//end
assign db = "1";
assign db = "0";
assign db = "1";
assign db = "1";
assign db = "0";
assign db = "0";
assign db = "1";
assign db = "0";
//initial begin
 //rst = 1;
 //#120
 //rst = 0;
//end
end
endmodule