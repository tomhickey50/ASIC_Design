// $Id: $
// File name:   timer.sv
// Created:     3/24/2014
// Author:      Emre Ozsahin
// Lab Section: 5
// Version:     1.0  Initial Design Entry
// Description: Timer 

module timer(
  input wire clk,
  input wire n_rst,
  input wire rising_edge_found,
  input wire falling_edge_found,
  input wire stop_found,
  input wire start_found,
  output reg byte_received,
  output reg ack_prep,
  output reg check_ack,
  output reg ack_done
  );
  
  
  reg flag,cl,c_en;
 // reg byte_received;
 // reg ack_prep;
 // reg check_ack;
 // reg ack_done;

  typedef enum bit[2:0] {IDLE,CNT,REC,N_FALL_EDGE,N_RISE_EDGE,FIN_FALL_EDGE} state_type;
  state_type state,next_state;
always @(posedge clk,negedge n_rst) begin
    if(n_rst == '0) begin
      state <= IDLE;  
    end else begin
       state <= next_state;
    end
end
  
always_comb begin
    //flag = 1'b0;
    cl = 1'b0;
    next_state = state;
    byte_received = 1'b0;
    ack_prep = 1'b0;
    check_ack = 1'b0;
    c_en = 1'b0;
    ack_done = 1'b0;
    
    case(state)
      
      IDLE : begin
        //cl = 1'b1;
        if (start_found == 1'b1) begin
          next_state = CNT;
        end else if( stop_found == 1'b1) begin
          next_state = IDLE;
        end
      end
      
      
      CNT : begin
        c_en = 1'b1;
        if(flag == 1'b1 && rising_edge_found == 1'b1) begin       
          next_state = REC;
        end else if(stop_found == 1'b1) begin
          next_state = IDLE;
        end
      end
      
      REC : begin
        cl = 1'b1;
        byte_received = 1'b1;
        if(falling_edge_found == 1'b1)begin
          next_state = N_FALL_EDGE;
        end else if(stop_found == 1'b1)begin
          next_state = IDLE;
        end 
      end
      
      N_FALL_EDGE : begin       
        ack_prep = 1'b1;
        if(rising_edge_found == 1'b1)begin
          next_state = N_RISE_EDGE;
        end /*else if( stop_found == 1'b1) begin
          next_state = IDLE;
        end*/
      end
        
      N_RISE_EDGE : begin
        check_ack = 1'b1;
        if(falling_edge_found == 1'b1)begin
          next_state = FIN_FALL_EDGE;
        end else if(stop_found == 1'b1) begin
          next_state = IDLE;
        end
      end  
      
      FIN_FALL_EDGE : begin
        cl = 1'b1;
        ack_done = 1'b1;
        if( stop_found == 1'b1) begin
          next_state = IDLE;
        end else begin
          next_state = CNT;
        end
      end
      
    endcase
  end  
  
  flex_counter counter_tim (
    .clk(clk),
    .n_rst(n_rst & !start_found),
    .clear(cl),
    .count_enable(rising_edge_found && c_en),
    .rollover_val(4'b0111),
    .rollover_flag(flag)
  );
  
  
endmodule
