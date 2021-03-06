// $Id: $
// File name:   scoreAdd.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: adder for traffic score and ped score

module scoreAdd(
  input wire [5:0] score1, //inputs should not exceed 6'd60
  input wire [5:0] score2,
  output wire [6:0] outScore
  );
  
  assign outScore = score1 + score2;
  
endmodule