module lcd_state(value, clk, rst, rs, rw, en, data);
input  clk, rst;
input [7:0] value;
output reg rs, rw, en;
output reg [7:0] data;
parameter s_0=0,s_1=1,s_2=2,s_3=3,s_4=4,s_5=5;
parameter a = 3'b0;
integer i = 3;
reg [2:0] current_state, next_state;
always @(current_state)
begin: next_state_logic
case(current_state)
s_0:begin
 next_state = s_1;
 end
s_1:begin
 next_state = s_2;
 end
s_2:begin
 next_state = s_3;
 end
s_3:begin
 next_state = s_3;
 end
s_4: begin
 next_state = s_5;
 i <= i - 1;
 end
s_5: begin
 next_state = s_5;
 end
 default: next_state = s_0;
 endcase
end
always @(posedge clk or negedge rst)
begin: register_generation
 if(!rst)
 current_state = s_0;
 else
 current_state = next_state;
end
always @(current_state)
begin: output_logic
case (current_state)
 s_0: begin
 rs = 0;
 rw = 0;
 en = 1;
 data = 8'b000011;
 end
 s_1: begin
 rs = 0;
 rw = 0;
 en = 0;
 data = 8'b00001111;
 end
 s_2: begin
 rs = 0;
 rw = 0;
 en = 1;
 data = 8'b00000001;
 end
 s_3: begin
 rs = 0;
 rw = 0;
 en = 0;
 data = 8'b00000001;
 end
 s_4: begin
 rs = 1;
 rw = 0;
 en = 1;
 data = value;
 end
 s_5: begin
 rs = 1;
 rw = 0;
 en = 0;
 data = value;
 end
 endcase
 end
 endmodule