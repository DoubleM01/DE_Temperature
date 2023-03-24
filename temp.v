module temp (clk,rst,cs,din,dataout,en,rs,rw,sclk,led,r,g,doutb,db,do);
input rst;
input clk;
input db;
output wire  cs;
output wire  din;
 output wire led;
  reg ll;
output wire r;
  output wire g;
  //input wire[7:0] doutb;
//output reg sclk;
//reg index;
output sclk;
 inout reg doutb;//input [3:0] cols;
//output [3:0] rows;
output rs,rw,en;
wire [7:0] data;
//wire [3:0] key;
output [7:0] dataout;
inout reg [7:0] do;
//wire strobe,strobe_s;
//keypad_enc i0 (clk,rst,cols,key,rows,strobe);
//ADC i0(clk,cs,din,led,doutb,en,den,rstc1,rstc2);
MCP i0(db,clk,cs,sclk,din,doutb,led,do);

always @(*) begin

if(do > 8'b00100101)
begin
     ll = 1'b1;
end
 else
begin
ll = 1'b0;
end
end
leddemux i1(ll,1'b1,r,g);
//dec4_8 i1 (key, key_mode);
//debouncer i3 (strobe,clk,rst,strobe_s);
lcd_state i4(data,clk,rst,rs,rw,en,dataout);
//end
endmodule