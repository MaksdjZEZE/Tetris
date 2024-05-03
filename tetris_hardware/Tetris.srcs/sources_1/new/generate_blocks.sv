`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/11 16:07:01
// Design Name: 
// Module Name: generate_blocks
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "tetris_define.vh"
module generate_blocks(
        input logic frame_clk,
        input logic gen_en,
        output block_info_t new_block_info
    );
    logic [14:0] prbs_15 = 'd1;
    logic [0:3][0:3][0:3] blocks_table[`BLOCK_NUM];
    
    logic [2:0] new_block_type;
    
    always_ff @( posedge frame_clk )
      if( gen_en )
        prbs_15 <= { prbs_15[13:0], prbs_15[14] ^ prbs_15[13] };
        
    always_ff @( posedge frame_clk )
      begin
        new_block_type <= prbs_15[7:0] % `BLOCK_NUM;
//        new_block_type <= `BLOCK_J;
      end
    assign blocks_table[`BLOCK_I ] = { 4'b0000,
                                       4'b1111,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0010,
                                       4'b0010,
                                       4'b0010,
                                       4'b0010,
    
                                       4'b0000,
                                       4'b0000,
                                       4'b1111,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b0100,
                                       4'b0100,
                                       4'b0100 };
                                       
    assign blocks_table[`BLOCK_J ] = { 4'b1000,
                                       4'b1110,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0110,
                                       4'b0100,
                                       4'b0100,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b1110,
                                       4'b0010,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b0100,
                                       4'b1100,
                                       4'b0000 };
                                       
    assign blocks_table[`BLOCK_L ] = { 4'b0010,
                                       4'b1110,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b0100,
                                       4'b0110,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b1110,
                                       4'b1000,
                                       4'b0000,
    
                                       4'b0110,
                                       4'b0010,
                                       4'b0010,
                                       4'b0000 };
                                       
    assign blocks_table[`BLOCK_O ] = { 4'b0000,
                                       4'b0110,
                                       4'b0110,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b0110,
                                       4'b0110,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b0110,
                                       4'b0110,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b0110,
                                       4'b0110,
                                       4'b0000 };
                                       
    assign blocks_table[`BLOCK_S ] = { 4'b0110,
                                       4'b1100,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b0110,
                                       4'b0010,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b0110,
                                       4'b1100,
                                       4'b0000,
    
                                       4'b1000,
                                       4'b1100,
                                       4'b0100,
                                       4'b0000 };
                                       
    assign blocks_table[`BLOCK_Z ] = { 4'b1100,
                                       4'b0110,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0010,
                                       4'b0110,
                                       4'b0100,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b1100,
                                       4'b0110,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b1100,
                                       4'b1000,
                                       4'b0000 };
                                       
    assign blocks_table[`BLOCK_T ] = { 4'b0100,
                                       4'b1110,
                                       4'b0000,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b0110,
                                       4'b0100,
                                       4'b0000,
    
                                       4'b0000,
                                       4'b1110,
                                       4'b0100,
                                       4'b0000,
    
                                       4'b0100,
                                       4'b1100,
                                       4'b0100,
                                       4'b0000 };
    always_ff @(posedge frame_clk)
        begin
            new_block_info.data <= blocks_table[new_block_type];
            new_block_info.color <= new_block_type + 1;
            new_block_info.point <= 0;
            new_block_info.x <= 'd3;
            new_block_info.y <= 'd0;
        end
endmodule
