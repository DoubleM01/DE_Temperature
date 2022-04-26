module temp (clk,rst,cs,din,dout,led,count_temp,count_temp2, soutb,en,den,rstc1,rstc2,rs,rw);
//out clk,rst;
input clk,rst;
wire cs;
wire reg  din;
//input donull,
//input dobit;
reg  [7:0] dout;
output reg led;
//output [3:0] count;
reg [3:0] count_temp;
reg [3:0] count_temp2;
input doutb;
output reg en;
output reg den;
input rstc1;
input rstc2;
//input [3:0] cols;
//output [3:0] rows;
output rs,rw,en;
output [7:0] data;
//wire [3:0] key;
//wire [7:0] key_mode;
//wire strobe,strobe_s;
//keypad_enc i0 (clk,rst,cols,key,rows,strobe);
ADC i0(clk,cs,din,led,doutb,en,den,rstc1,rstc2);

//dec4_8 i1 (key, key_mode);
//debouncer i3 (strobe,clk,rst,strobe_s);
lcd_state i4(value,clk,rst,rs,rw,en,data);
endmodule