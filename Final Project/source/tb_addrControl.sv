// $Id: $
// File name:   tb_addrControl.sv
// Created:     5/1/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for address controlller
`timescale 1ns/1ps

module tb_addrControl();
  reg clk;
  reg n_rst;
  reg goRead;
  reg goWrite;
  reg[11:0] addr;
  
  addrControl DUT(
    clk, 
    n_rst,
    goRead,
    goWrite,
    addr
  );
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 1;
    n_rst = 0;
    
    #20
    n_rst = 1;
    #1000000000
    $stop;
  end
endmodule
  