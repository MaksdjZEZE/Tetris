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
    logic [3:0]  rs, gs, bs;
    logic [3:0]  ro, go, bo;
    logic [7:0]  keycode_player1, keycode_player2;
    logic game_start_player1, game_start_player2;
    logic game_restart_player1, game_restart_player2;
    logic game_over_player1, game_over_player2;
    logic [1:0] player_mode;
    
    logic [2:0] garbage_input_player1, garbage_input_player2;
    logic [2:0] garbage_output_player1, garbage_output_player2;
    logic garbage_added_player1, garbage_added_player2;
    logic garbage_output_valid_player1, garbage_output_valid_player2;
    
    block_info_t generated_block_player1, generated_block_player2;
    enum logic [2:0] {
        MODE_SWITCH_S,
        SINGLE_PLAYER_S,
        TWO_PLAYER_S,
        WAITING_START_S,
        GAME_S,
        GAME_OVER_S
    } display_state, display_state_next;
    
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                display_state <= MODE_SWITCH_S;
            else
                display_state <= display_state_next;
        end
        
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                player_mode <= 'd0;
            else
            begin
                if (display_state == MODE_SWITCH_S)
                    player_mode <= 'd0;  
                else if (display_state == SINGLE_PLAYER_S)
                    player_mode <= 'd1;
                else if (display_state == TWO_PLAYER_S)
                    player_mode <= 'd2;
                else
                    player_mode <= player_mode;
            end
        end
        
    always_comb
        begin
            display_state_next = display_state;
            case (display_state)
                MODE_SWITCH_S:
                begin
//                    player_mode = 'd0;
                    if (keycode[7:0] == `MOVE_ROTATE_2)
                        display_state_next = SINGLE_PLAYER_S;
                    else if (keycode[7:0] == `MOVE_DOWN_2)
                        display_state_next = TWO_PLAYER_S;
                end
                SINGLE_PLAYER_S:
                begin
//                    player_mode = 'd1;
                    if (keycode[7:0] == `NEW_GAME_1)
                        display_state_next = WAITING_START_S;
                    else if (keycode[7:0] == `MOVE_DOWN_2)
                        display_state_next = TWO_PLAYER_S;
                end
                TWO_PLAYER_S:
                begin
//                    player_mode = 'd2;
                    if (keycode[7:0] == `NEW_GAME_1)
                        display_state_next = WAITING_START_S;
                    else if (keycode[7:0] == `MOVE_ROTATE_2)
                        display_state_next = SINGLE_PLAYER_S;
                end
                WAITING_START_S:
                begin
                    if (keycode[7:0] == `NEW_GAME_1)
                        display_state_next = GAME_S;
                end
                GAME_S:
                begin
                    if (player_mode == 'd1)
                    begin
                        if (game_over_player1 == 'd1)
                        begin
                            display_state_next = GAME_OVER_S;
                        end
                    end
                    else if (player_mode == 'd2)
                    begin
                        if ((game_over_player1 == 'd1) && (game_over_player2 == 'd1))
                        begin
                            display_state_next = GAME_OVER_S;
                        end
                    end
                end
                GAME_OVER_S:
                    if (keycode[7:0] == `NEW_GAME_1)
                        display_state_next = MODE_SWITCH_S;
            endcase
        end
    assign game_start_player1 = (display_state != GAME_S) && (display_state_next == GAME_S);
    assign game_start_player2 = (display_state != GAME_S) && (display_state_next == GAME_S) && (player_mode == 'd2);
    assign game_restart_player1 = (display_state == GAME_OVER_S) && (display_state_next == MODE_SWITCH_S);
    assign game_restart_player2 = (display_state == GAME_OVER_S) && (display_state_next == MODE_SWITCH_S) && (player_mode == 'd2);
    always_comb
        begin
            keycode_player1 = 'd0;
            keycode_player2 = 'd0;
            if (keycode[15:8] == `MOVE_LEFT_1 || keycode[15:8] == `MOVE_RIGHT_1 || keycode[15:8] == `MOVE_ROTATE_1 || keycode[15:8] == `MOVE_DOWN_1)
                keycode_player1 = keycode[15:8];
            if (keycode[7:0] == `MOVE_LEFT_1 || keycode[7:0] == `MOVE_RIGHT_1 || keycode[7:0] == `MOVE_ROTATE_1 || keycode[7:0] == `MOVE_DOWN_1)
                keycode_player1 = keycode[7:0];
            if (keycode[15:8] == `MOVE_LEFT_2 || keycode[15:8] == `MOVE_RIGHT_2 || keycode[15:8] == `MOVE_ROTATE_2 || keycode[15:8] == `MOVE_DOWN_2)
                keycode_player2 = keycode[15:8];
            if (keycode[7:0] == `MOVE_LEFT_2 || keycode[7:0] == `MOVE_RIGHT_2 || keycode[7:0] == `MOVE_ROTATE_2 || keycode[7:0] == `MOVE_DOWN_2)
                keycode_player2 = keycode[7:0];
        end
    
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                garbage_input_player1 <= 0;
            else
            begin
                if (garbage_output_valid_player2 == 1)
                    garbage_input_player1 <= garbage_output_player2;
                else if (garbage_added_player1 == 1)
                    garbage_input_player1 <= 0;
            end
        end
        
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                garbage_input_player2 <= 0;
            else
            begin
                if (garbage_output_valid_player1 == 1)
                    garbage_input_player2 <= garbage_output_player1;
                else if (garbage_added_player2 == 1)
                    garbage_input_player2 <= 0;
            end
        end
        
    tetris_game #(
        .KEY_MOVE_LEFT(`MOVE_LEFT_1),
        .KEY_MOVE_RIGHT(`MOVE_RIGHT_1),
        .KEY_MOVE_ROTATE(`MOVE_ROTATE_1),
        .KEY_MOVE_DOWN(`MOVE_DOWN_1)
    ) tetris_game_player1(
        .Reset(Reset),
        .frame_clk(frame_clk),
        .keycode(keycode_player1),
        .game_start(game_start_player1),
        .game_restart(game_restart_player1),
        .garbage_input(garbage_input_player1),
        .garbage_added(garbage_added_player1),
        .playfield(playfield_player1),
        .score(score_player1),
        .game_over(game_over_player1),
        .garbage_output_valid(garbage_output_valid_player1),
        .garbage_output(garbage_output_player1),
        .generated_block(generated_block_player1)
    );
      
    draw_playfield draw_playfield_player1(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .generated_block(generated_block_player1),
        .playfield(playfield_player1),
        .draw_field_en(draw_field_player1_en),
        .red(r1),
        .green(g1),
        .blue(b1)
    );
    
    tetris_game #(
        .KEY_MOVE_LEFT(`MOVE_LEFT_2),
        .KEY_MOVE_RIGHT(`MOVE_RIGHT_2),
        .KEY_MOVE_ROTATE(`MOVE_ROTATE_2),
        .KEY_MOVE_DOWN(`MOVE_DOWN_2)
    ) tetris_game_player2(
        .Reset(Reset),
        .frame_clk(frame_clk),
        .keycode(keycode_player2),
        .game_start(game_start_player2),
        .game_restart(game_restart_player2),
        .garbage_input(garbage_input_player2),
        .garbage_added(garbage_added_player2),
        .playfield(playfield_player2),
        .score(score_player2),
        .game_over(game_over_player2),
        .garbage_output_valid(garbage_output_valid_player2),
        .garbage_output(garbage_output_player2),
        .generated_block(generated_block_player2)
    );
      
    draw_playfield #(
        .PLAYFIELD_X_(400),
        .PLAYFIELD_Y_(120)
    ) draw_playfield_player2(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .generated_block(generated_block_player2),
        .playfield(playfield_player2),
        .draw_field_en(draw_field_player2_en),
        .red(r2),
        .green(g2),
        .blue(b2)
    );
    
    draw_mode_switch draw_mode_switch_inst(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .player_mode(player_mode),
        .red(rs),
        .green(gs),
        .blue(bs)
    );
    
    draw_game_over draw_game_over_s(
        .draw_x(DrawX),
        .draw_y(DrawY),
        .red(ro),
        .green(go),
        .blue(bo)
    );
    always_comb
        begin
            Red = 4'hf;
            Green = 4'hf;
            Blue = 4'hf;
            case (display_state)
                MODE_SWITCH_S, SINGLE_PLAYER_S, TWO_PLAYER_S:
                begin
                    Red = rs;
                    Green = gs;
                    Blue = bs;
                end
                WAITING_START_S, GAME_S:
                begin
                    if (draw_field_player1_en)
                    begin
                        Red = r1;
                        Green = g1;
                        Blue = b1;
                    end
                    else if (player_mode == 'd2)
                    begin
                        Red = r2;
                        Green = g2;
                        Blue = b2;
                    end
                end
                GAME_OVER_S:
                begin
                    Red = ro;
                    Green = go;
                    Blue = bo;
                end
            endcase
            
        end
endmodule

