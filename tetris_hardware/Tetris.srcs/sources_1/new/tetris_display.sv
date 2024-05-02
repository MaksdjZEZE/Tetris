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
    input  logic [15:0]  keycode,
    input  logic [9:0] DrawX, DrawY,
    output logic [3:0]  Red, Green, Blue,
    output logic [15:0] score_player1,
    output logic [15:0] score_player2
    );
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield_player1[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield_player2[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    logic draw_field_player1_en;
    logic draw_field_player2_en;
    logic [3:0]  r1, g1, b1;
    logic [3:0]  r2, g2, b2;
    logic [7:0]  keycode_player1, keycode_player2;
    always_comb
        begin
            keycode_player1 = 'd0;
            keycode_player2 = 'd0;
            if (keycode[15:8] == `NEW_GAME_1 || keycode[7:0] == `NEW_GAME_1)
            begin 
                keycode_player1 = `NEW_GAME_1;
                keycode_player2 = `NEW_GAME_1;
            end
            if (keycode[15:8] == `MOVE_LEFT_1 || keycode[15:8] == `MOVE_RIGHT_1 || keycode[15:8] == `MOVE_ROTATE_1)
                keycode_player1 = keycode[15:8];
            if (keycode[7:0] == `MOVE_LEFT_1 || keycode[7:0] == `MOVE_RIGHT_1 || keycode[7:0] == `MOVE_ROTATE_1)
                keycode_player1 = keycode[7:0];
            if (keycode[15:8] == `MOVE_LEFT_2 || keycode[15:8] == `MOVE_RIGHT_2 || keycode[15:8] == `MOVE_ROTATE_2)
                keycode_player2 = keycode[15:8];
            if (keycode[7:0] == `MOVE_LEFT_2 || keycode[7:0] == `MOVE_RIGHT_2 || keycode[7:0] == `MOVE_ROTATE_2)
                keycode_player2 = keycode[7:0];
        end
    tetris_game #(
        .KEY_MOVE_LEFT(`MOVE_LEFT_1),
        .KEY_MOVE_RIGHT(`MOVE_RIGHT_1),
        .KEY_MOVE_ROTATE(`MOVE_ROTATE_1)
    ) tetris_game_player1(
        .Reset(Reset),
        .frame_clk(frame_clk),
        .keycode(keycode_player1),
        .playfield(playfield_player1),
        .score(score_player1)
    );
      
    draw_playfield draw_playfield_player1(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .score(score_player1),
        .playfield(playfield_player1),
        .draw_field_en(draw_field_player1_en),
        .red(r1),
        .green(g1),
        .blue(b1)
    );
    
    tetris_game #(
        .KEY_MOVE_LEFT(`MOVE_LEFT_2),
        .KEY_MOVE_RIGHT(`MOVE_RIGHT_2),
        .KEY_MOVE_ROTATE(`MOVE_ROTATE_2)
    ) tetris_game_player2(
        .Reset(Reset),
        .frame_clk(frame_clk),
        .keycode(keycode_player2),
        .playfield(playfield_player2),
        .score(score_player2)
    );
      
    draw_playfield #(
        .PLAYFIELD_X_(400),
        .PLAYFIELD_Y_(120)
    ) draw_playfield_player2(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .score(score_player2),
        .playfield(playfield_player2),
        .draw_field_en(draw_field_player2_en),
        .red(r2),
        .green(g2),
        .blue(b2)
    );
    
    always_comb
        begin
            if (draw_field_player1_en)
            begin
                Red = r1;
                Green = g1;
                Blue = b1;
            end
            else
            begin
                Red = r2;
                Green = g2;
                Blue = b2;
            end
        end
endmodule

