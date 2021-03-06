// $Id: $
// File name:   tb_sramcontrol.sv
// Created:     4/26/2014
// Author:      Kyle Fesmire
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for the ram controller
`timescale 1ns/100ps

module tb_sramcontrol();
  reg clk;
  reg n_rst;
  //inputs from sram
  reg [15:0] s_trafficIn; // format: 00 - 7bits of NS - 7 bits of EW 
  reg [15:0] s_pedIn; //format: 00 - 7 bits of NW - 7 bits of EW
  reg [15:0] s_NSout;  //format 00 - 14 bits of NSout
  reg [15:0] s_EWout; //format 00 - 14 bits of NSout
  reg [15:0] s_dir_time; //format 00000000 s_dir_time[8] = dir; s_dir_time[7:0] = dTime
  //outputs to sram
  reg read_enable;
  reg write_enable;
  reg [11:0] s_addr;
  //these values are writen to sram
  reg [15:0] w_trafficIn;  
  reg [15:0] w_pedIn; 
  reg [15:0] w_NSout;  
  reg [15:0] w_EWout; 
  reg [15:0] w_dir_time;
  
  //inputs from NN
  reg read;
  reg write;
  reg [11:0] addr; 
  
  reg [6:0] iTNS;
  reg [6:0] iTEW;
  reg [6:0] iPNS;
  reg [6:0] iPEW;
  reg [13:0] iNSout;
  reg [13:0] iEWout;
  reg idir;
  reg [7:0] idTime;
  //outputs to Calibrator
  reg [6:0] TNS;
  reg [6:0] TEW;
  reg [6:0] PNS;
  reg [6:0] PEW;
  reg [13:0] NSout;
  reg [13:0] EWout;
  reg dir;
  reg [7:0] dTime; 
    
    //memory controls
    reg tb_mem_init;
    reg tb_mem_clr;
    reg tb_mem_dump;
    reg zero;
    integer tb_init_0;
    integer tb_init_1;
    integer tb_init_2;
    integer tb_init_3;
    integer tb_init_4;
    
    always begin
      #5
      clk = ~clk;
    end
    
    initial begin
      clk = 1;
      n_rst = 1;
      zero <= 0;
      
      addr = 0;
      read = 0;
      write = 0;
      iTNS = 0;
      iTEW = 0;
      iPNS = 0;
      iPEW = 0;
      iNSout = 0;
      iEWout = 0;
      idir = 0;
      idTime = 0;
      
      tb_mem_clr = 0;
      tb_mem_dump = 0;
      tb_init_0 <= 0;
      tb_init_1 <= 1;
      tb_init_2 <= 2;
      tb_init_3 <= 3;
      tb_init_4 <= 4;
      
      #1
      read = 0;
      addr = 0;
      tb_mem_init = 0;

      #5
      tb_mem_init = 1;
      #6
      tb_mem_init = 0;
      addr = 12'd0;
      read = 1;
      
      #10
      addr = 12'd1;
      #10
      addr = 12'd2;
      #10
      addr = 12'd4;
      #10
      addr = 12'd16;
      #10
      addr = 12'd64;
      #10
      addr = 12'd1024;
      
      #10
      read = 0;
      #50
      addr = 30;
      
      iTNS = 7'hA;
      iTEW = 7'hB;
      iPNS = 7'hC;
      iPEW = 7'hD;
      iNSout = 14'h9A;
      iEWout = 14'h9B;
      idir = 1;
      idTime = 8'h12;
      
      #5
      write = 1;
      
      #50
      write = 0;
      
      #50
      tb_mem_dump = 1;
      
      #20
      tb_mem_dump = 0;
      
      
      #100
      $stop;
    end      
    
    sramcontrol controller(
      clk,
      n_rst,
      s_trafficIn,
      s_pedIn,
      s_NSout,
      s_EWout, 
      s_dir_time, 
      read_enable,
      write_enable,
      s_addr,
      w_trafficIn,  
      w_pedIn, 
      w_NSout,  
      w_EWout, 
      w_dir_time,
      read,
      write,
      addr, 
  
      iTNS,
      iTEW,
      iPNS,
      iPEW,
      iNSout,
      iEWout,
      idir,
      idTime,
      TNS,
      TEW,
      PNS,
      PEW,
      NSout,
      EWout,
      dir,
      dTime 
  );
      
    
  on_chip_sram_wrapper trafficIn__
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(zero),
		.init_file_number(tb_init_0),
		.dump_file_number(tb_init_0),
		.start_address(zero),
		.last_address(60),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(write_enable),
		.address(s_addr),
		.read_data(s_trafficIn),
		.write_data(w_trafficIn)
	);
	
	
	on_chip_sram_wrapper pedIn__
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(zero),
		.init_file_number(tb_init_1),
		.dump_file_number(tb_init_1),
		.start_address(zero),
		.last_address(60),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(write_enable),
		.address(s_addr),
		.read_data(s_pedIn),
		.write_data(w_pedIn)
	);
	
	on_chip_sram_wrapper NSout__
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(zero),
		.init_file_number(tb_init_2),
		.dump_file_number(tb_init_2),
		.start_address(zero),
		.last_address(60),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(write_enable),
		.address(s_addr),
		.read_data(s_NSout),
		.write_data(w_NSout)
	);
	
	on_chip_sram_wrapper EWout__
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(zero),
		.init_file_number(tb_init_3),
		.dump_file_number(tb_init_3),
		.start_address(zero),
		.last_address(60),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(write_enable),
		.address(s_addr),
		.read_data(s_EWout),
		.write_data(w_EWout)
	);
	
	on_chip_sram_wrapper dir_time__
	(
		// Test bench control signals
		.mem_clr(tb_mem_clr),
		.mem_init(tb_mem_init),
		.mem_dump(tb_mem_dump),
		.verbose(zero),
		.init_file_number(tb_init_4),
		.dump_file_number(tb_init_4),
		.start_address(zero),
		.last_address(60),
		// Memory interface signals
		.read_enable(read_enable),
		.write_enable(write_enable),
		.address(s_addr),
		.read_data(s_dir_time),
		.write_data(w_dir_time)
	);
      
endmodule