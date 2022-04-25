module leddemux (
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
