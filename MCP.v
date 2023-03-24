module MCP(db,clk,cs,sclk,din,doutb,led,dout);
input clk;
output reg cs;
output reg  din;
output reg sclk;
reg index;
reg newclk;
output reg doutb;
input db;
 //output reg o[7:0];
//input donull,
//input dobit;
output reg led;
  output reg [7:0] dout;
parameter s_0=0,s_1=1,s_2=2,s_3=3,s_4=4,s_5=5;
reg [2:0] current_state, next_state;

always @(negedge clk,negedge newclk)begin
assign current_state =s_0;
newclk =~newclk;
assign sclk = newclk;
//begin: next_state_logic
case(current_state)
s_0:begin
assign cs =1'b1;
assign din =1'b0;
assign dout =8'b00000000;
assign current_state =s_1;end
s_1:begin
assign cs =1'b0;
assign din=1'b1;
assign din=1'b1;
assign current_state =s_2;
end
s_2:begin
for(index = 0; index <3 ; index = index + 1) begin
assign din=1'b0;
end
assign current_state =s_3;
end

s_3:begin
assign cs =1'b0;
assign current_state =s_4;
end
s_4:begin
assign cs =1'b0;
assign current_state =s_4;
end

s_5:begin
assign cs =1'b0;
for(index = 0; index <9 ; index = index + 1) begin
 doutb = db;
dout[index] =  doutb;
end
end

//assign current_state =s_4;
endcase

end
endmodule
