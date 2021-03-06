// $Id: $
// File name:   weather.sv
// Created:     3/19/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Weather Score

module score_weather
(
  input wire
   [3:0] w_in,
  output reg [6:0] w_out
);


always_comb begin
  if(w_in == 4'b0100)
    w_out = 20;
  else if(w_in == 4'b0101) 
    w_out = 30;
  else if(w_in == 4'b0110)
    w_out = 40;
  else if(w_in == 4'b1000 || w_in == 4'b0111) 
    w_out = 50;
  else if(w_in == 4'b1100) 
    w_out = 70;
  else if(w_in == 4'b1101)
    w_out = 80;
  else if(w_in == 4'b1110)
    w_out = 90;
  else if(w_in == 4'b1111)
    w_out = 100;
  else
    w_out = 0;
  end
endmodule