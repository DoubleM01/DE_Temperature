module demux2_1 (
  input      slct,
  input      fis,
  output reg r,
  output reg g
);
 
  // using if
  always @* begin
    if (slct == 1'b0)  {r, g} <= {1'b0, fis};
    else               {r, g} <= {fis, 1'b0};
  end
 
  
 
endmodule
module temp(
input clk,
output cs,
reg  din,
input donull,
reg [9:0] dout,
output [1:0] led,
output [3:0] count,
reg [3:0] count_temp,
reg [3:0] count_temp2,
input doutb,
output en,
reg den,
input rstc1,
input rstc2,
reg high,
wire [1:0]y
);
//always@(clk) begin
assign cs= 1'b0;
always@(clk) begin
//assign cs= 1'b0;
if(rstc1)
count_temp <= 4'b0;
else
count_temp <= count_temp + 1;
case(count_temp)
 4'b0100: begin
 assign din=1'b0;
   en = 1'b1;
  end
    4'b0000: assign  din=1'b1;
    4'b0001: assign din=1'b1;
    4'b0010: assign din=1'b0;
    4'b0011: assign din=1'b0;
    default: assign din = 1'bx;
    
endcase
end
always @(negedge clk) begin
if(rstc2)
count_temp2 <= 4'b0;
else
count_temp2 <= count_temp2 + 1;
if(count_temp2 == 4'b0010)
begin
assign den = 1'b1;
count_temp2 <= count_temp2 - 1;
end
end
if(count_temp2 != 4'b1001)
  dout[count_temp2-1 :0] <=  doutb;
else
begin
if(dout>10'b0000100101)
demux2_1(1'b1, 1'b1,  led[0],led[1]);
else
begin
demux2_1(1'b0, 1'b1,  led[0],led[1]);
end
end
endmodule