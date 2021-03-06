// $Id: $
// File name:   tb_moore.sv
// Created:     2/14/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Test Bench For Moore 1101 Detector.

`timescale 1ns / 10ps

module tb_moore ();
  
  // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	
	// Shared Test Variables
	reg [15:0] seq;
	int i;
	reg tb_clk;
	reg tb_n_rst;
	reg tb_i;
	reg tb_o;
	reg tb_test_num;
	
	// DUT portmaps
	moore DUT
	(
	 .clk(tb_clk),
	 .n_rst(tb_n_rst),
	 .i(tb_i),
	 .o(tb_o)
	);
	
		// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// Default Configuration Test bench main process
	initial
	begin
	  
	  tb_n_rst = 1'b1;
	  tb_i = 1'b0;
	  tb_test_num = 0; 
	  
	  // Power-on Reset of the DUT
	  #(0.1);
		tb_n_rst	= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		#(CLK_PERIOD * 2.25);	// Release the reset away from a clock edge
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		
			// Wait for a while to see normal operation
		#(CLK_PERIOD);

  // test 1: n_rst
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 0;
  tb_i = 0;
  
  @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
	// test 2: 
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		// test 3: 
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		
		// test 4: 
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 0;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);

// test 5: 
  @(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b1)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		//1101
		
		//test 6:
	@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 0;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
		@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 0;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b0)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
			@(negedge tb_clk);
  tb_test_num += 1; 
  tb_n_rst = 1;
  tb_i = 1;
  
   @(posedge tb_clk);
  #(CHECK_DELAY);
  if(tb_o == 1'b1)
    $info("Default Test Case %0d:: PASSED", tb_test_num);
	else // Test case failed
		$error("Default Test Case %0d:: FAILED", tb_test_num);
		
	seq = 16'b0101011101101101;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 0;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
		  
	seq = 16'b0111010010010010;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b0011010010010101;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b0000000011111111;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b1111011101101010;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
 seq = 16'b1011001011101100;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  seq = 16'b0001110110110111;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  seq = 16'b1111011101101010;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  seq = 16'b1111011101101010;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  seq = 16'b1111000011110000;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b1111000011110000;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b0000111100001111;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  //all possible cases
   seq = 16'b1101001110001011;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end
  
  seq = 16'b1011100110101001;
	for(i = 0;i < 16;i=i+1) begin
		  
		  @(negedge tb_clk);
      tb_test_num += 1; 
      tb_n_rst = 1;
      tb_i = seq[i];
  
      @(posedge tb_clk);
      #(CHECK_DELAY);
  end



end

  
endmodule