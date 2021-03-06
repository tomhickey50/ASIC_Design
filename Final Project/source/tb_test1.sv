// $Id: $
// File name:   tb_test1.sv
// Created:     4/29/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench for test1

`timescale 1ns/10ps

module tb_test1();
  reg signed [4:0] i1;
  reg signed [4:0] i2;
  reg signed [7:0] i3;
  reg signed [7:0] i4;
  reg signed [11:0] x1;
  reg signed [11:0] x2;
  reg signed [12:0] out;
  
  test1 DAHTEST(i1, i2, i3, i4, x1, x2, out);
  
  initial begin
    #5
    i1 = 5'd12;
    i3 = 8'd100;
    i2 = 5'd2;
    i4 = -8'd5;
    
    #20
    i1 = -5'd10;
    i3 = -8'd6;
    i2 = 5'd9;
    i4 = 8'd14;    

    #20
    i1 = 5'd2;
    i3 = 8'd70;
    i2 = 5'd9;
    i4 = 8'd20;
     
    #40
    $stop;
  end
  
endmodule