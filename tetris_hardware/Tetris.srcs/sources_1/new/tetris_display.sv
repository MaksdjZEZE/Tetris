`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/09 22:21:05
// Design Name: 
// Module Name: tetris_display
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
module tetris_display(
    input  logic        Reset, 
    input  logic        frame_clk,
    input  logic [7:0]  keycode,
    input  logic [9:0] DrawX, DrawY,
    output logic [3:0]  Red, Green, Blue
    );
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    logic draw_left_field_en;
    
    tetris_game tetris_game_inst(
        .Reset(Reset),
        .frame_clk(frame_clk),
        .keycode(keycode),
        .playfield(playfield)
    );
      
    draw_playfield draw_left_playfield(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .playfield(playfield),
        .draw_field_en(draw_left_field_en),
        .red(Red),
        .green(Green),
        .blue(Blue)
    );
    
endmodule

