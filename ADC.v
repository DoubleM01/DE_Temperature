module ADC(clk,cs,din,led,count,doutb,en,den,rstc1,rstc2);
output clk;
output cs;
output reg  din;
//input donull,
//input dobit;
reg  [9:0] dout;
output reg led;
output [3:0] count;
reg [3:0] count_temp;
reg [3:0] count_temp2;
input doutb;
output reg en;
output reg den;
input rstc1;
input rstc2;
reg high;
wire [1:0]y;

assign cs= 1'b0;
//assign dout <= 0;
always@(clk) begin
//assign cs= 1'b0;
    if(rstc1)
        count_temp = 4'b0;
    else
        begin
            count_temp <= count_temp + 1;
            case(count_temp)
                4'b0100: begin
                    din=1'b0;
                    en = 1'b1;
                end
                4'b0000:   din=1'b1;
                4'b0001:  din=1'b1;
                4'b0010:  din=1'b0;
                4'b0011:  din=1'b0;
                default:  din = 1'bx;
            endcase
        end
end
always @(negedge clk) begin
    if(rstc2)
        count_temp2 <= 4'b0;
    else
        begin
            count_temp2 <= count_temp2 + 1;
            if(count_temp2 == 4'b0010)
                begin
                    den <= 1'b1;
                    count_temp2 <= count_temp2 - 1;
                end

            if(count_temp2 != 4'b1001)
                dout[count_temp2-1] <=  doutb;
            else
                begin
                    if(dout>10'b0000100101)
                        led = 1'b1;
                     else
                     begin
                        led = 1'b0;
                        end
                        //demux2_1(1'b0, 1'b1,  led[0],led[1]);
                end
end
end
endmodule