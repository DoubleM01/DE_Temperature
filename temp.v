module temp (clk,rst,cs,din,dataout,en,rs,rw,sclk,led,r,g);
input rst;
input clk;

output wire  cs;
output wire  din;
inout wire led;
output wire r;
  output wire g;
//output reg sclk;
//reg index;
output sclk;
//input reg doutb;//input [3:0] cols;
//output [3:0] rows;
output rs,rw,en;
wire [7:0] data;
//wire [3:0] key;
output [7:0] dataout;
//wire strobe,strobe_s;
//keypad_enc i0 (clk,rst,cols,key,rows,strobe);
//ADC i0(clk,cs,din,led,doutb,en,den,rstc1,rstc2);
MCP i0(clk,cs,sclk,din,doutb,led);
leddemux i1(led,1'b1,r,g);
//dec4_8 i1 (key, key_mode);
//debouncer i3 (strobe,clk,rst,strobe_s);
lcd_state i4(data,clk,rst,rs,rw,en,dataout);
endmodule