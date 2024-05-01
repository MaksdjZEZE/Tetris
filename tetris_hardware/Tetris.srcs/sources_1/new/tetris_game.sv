`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/11 21:49:35
// Design Name: 
// Module Name: tetris_game
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
module tetris_game #(parameter [7:0] KEY_MOVE_LEFT = `MOVE_LEFT_1,
                     parameter [7:0] KEY_MOVE_RIGHT = `MOVE_RIGHT_1,
                     parameter [7:0] KEY_MOVE_ROTATE = `MOVE_ROTATE_1)(
    input  logic        Reset, 
    input  logic        frame_clk,
    input  logic [7:0]  keycode,
    output logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL],
    output logic [15:0] score
    );
    // This module should update the playfield according to user input
    enum logic [2:0] {
        IDLE_S,
        GEN_NEW_BLOCK_S,
        WAIT_INPUT_S,
        CHECK_MOVE_S,
        MAKE_MOVE_S,
        GAME_OVER_S,
        APPEND_BLOCK_S,
        CLEAN_LINE_S
    } game_state, game_state_next;
    
    logic [7:0] keycode_prev;
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] background_playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    logic [`TETRIS_COLORS_NUM_WIDTH-1:0] line_cleaned_playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL];
    block_info_t generated_block, curr_block;
//    logic draw_block_en_next;
    logic  [`PLAYFIELD_ROW-1:0] full_row;
    logic draw_block_en;
    logic wait_input_end; // This clock wait for 4 clocks
    logic wait_input_start;
    logic checking_new_block;
    block_move_t attempt_move, attempt_move_next;
    
    logic check_start;
    logic check_move_done;
    logic move_valid;
    logic signed [1:0] move_x;
    logic signed [1:0] move_y;
    logic user_has_input;
    logic gen_next_block_en;
    
//    logic [15:0] score;
    logic [`PLAYFIELD_ROW_WIDTH-1:0] full_row_num;
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                game_state <= IDLE_S;
            else
                game_state <= game_state_next;
        end
    logic updating_background;
    
    always_ff @(posedge frame_clk)
        begin
            if(game_state == IDLE_S)
            begin
                score <= 'd0;
                for( int row = 0; row < `PLAYFIELD_ROW; row++ )
                      begin
                        for( int col = 0; col < `PLAYFIELD_COL; col++ )
                          begin
                            background_playfield[row][col] <= 'd0;
                          end
                      end
            end
            else if (game_state == APPEND_BLOCK_S)
            begin
                score <= score + 20;
                for( int row = 0; row < `PLAYFIELD_ROW; row++ )
                  begin
                    for( int col = 0; col < `PLAYFIELD_COL; col++ )
                      begin
                        background_playfield[row][col] <= playfield[row][col];
                      end
                  end
            end
            else if (game_state == CLEAN_LINE_S)
            begin
                case (full_row_num)
                  1: score <= score + 100;
                  2: score <= score + 300;
                  3: score <= score + 700;
                  4: score <= score + 1500;
                  default: score <= score; 
                endcase
                
                for( int row = 0; row < `PLAYFIELD_ROW; row++ )
                  begin
                    for( int col = 0; col < `PLAYFIELD_COL; col++ )
                      begin
                        background_playfield[row][col] <= line_cleaned_playfield[row][col];
                      end
                  end
            end
        end
    always_comb
        begin
            updating_background = 0;
            game_state_next = game_state;
            case (game_state)
                IDLE_S:
                begin
                    if (keycode == `NEW_GAME_1)
                        game_state_next = GEN_NEW_BLOCK_S;
                end
                GEN_NEW_BLOCK_S:
                    game_state_next = CHECK_MOVE_S;
                WAIT_INPUT_S:
//                    game_state_next = CHECK_MOVE_S;
                    if (user_has_input == 'd1 || wait_input_end == 'd1)
                        game_state_next = CHECK_MOVE_S;
                CHECK_MOVE_S:
                    if (check_move_done == 'd1)
                        game_state_next = MAKE_MOVE_S;
                MAKE_MOVE_S:
                begin
                    if (attempt_move == MOVE_DOWN && move_valid == 'd0)
                        game_state_next = APPEND_BLOCK_S;
                    else
                    begin 
                        if (attempt_move == MOVE_APPEAR && move_valid == 'd0)  
                            game_state_next = GAME_OVER_S;
                        else
                            game_state_next = WAIT_INPUT_S;
                    end
                end
                APPEND_BLOCK_S:
                begin
//                    game_state_next = GEN_NEW_BLOCK_S;
                    game_state_next = CLEAN_LINE_S;
                end
                CLEAN_LINE_S:
                begin
                    if (full_row == 0)
                        game_state_next = GEN_NEW_BLOCK_S;
                end
                GAME_OVER_S:
                begin
                    if (keycode == `NEW_GAME_1)
                        game_state_next = IDLE_S;
                end
          
            endcase
        end
    


    
    always_comb
        begin

            for( int row = 0; row < `PLAYFIELD_ROW; row++ )
              begin
                for( int col = 0; col < `PLAYFIELD_COL; col++ )
                  begin
                    playfield[row][col] = background_playfield[row][col];
                  end
              end
            if (draw_block_en == 1)
                begin
                    for( int row = 0; row < 4; row++ )
                      begin
                        for( int col = 0; col < 4; col++ )
                          begin
                            if(curr_block.data[curr_block.point][row][col] == 1'd1)
                                playfield[curr_block.y + row][curr_block.x + col] = curr_block.color;
                          end
                      end
                end

        end
    
    assign gen_next_block_en = ( game_state == IDLE_S ) || ( game_state == GEN_NEW_BLOCK_S ); 
    generate_blocks generate_blocks_inst(
        .frame_clk(frame_clk),
        .gen_en(gen_next_block_en),
        .new_block_info(generated_block)
    );
    
    always_ff @(posedge frame_clk)
        begin
            if(game_state == GEN_NEW_BLOCK_S)
                curr_block <= generated_block;
            else
            begin
                if (game_state == MAKE_MOVE_S)
                begin
                    if (move_valid == 'd1)
                    begin
                        curr_block.x <= curr_block.x + move_x;
                        curr_block.y <= curr_block.y + move_y;
                        if (attempt_move == MOVE_ROTATE)
                            curr_block.point <= (curr_block.point + 1) % 4;
                    end
                end
            end
        end        
    
    wait_clock wait_clock_inst(
        .frame_clk(frame_clk),
        .Reset(Reset),
        .wait_clock_start(wait_input_start),
        .wait_clock_en(wait_input_end)
    );
    
    assign wait_input_start = (game_state != WAIT_INPUT_S) && (game_state_next == WAIT_INPUT_S);
    
    always @(posedge frame_clk or posedge Reset) begin
        if (Reset)
            keycode_prev <= 8'h0;
        else
            keycode_prev <= keycode;
    end
    // This comb block is used to update the attemt_move
    always_comb
        begin
            user_has_input = 0;
            attempt_move_next = attempt_move;  // The defalut movement is move down
            if (game_state == GEN_NEW_BLOCK_S)
                attempt_move_next = MOVE_APPEAR;
            else
            begin
                if (game_state == WAIT_INPUT_S)
                begin
                    if (keycode != KEY_MOVE_ROTATE || keycode != keycode_prev) begin
                        case (keycode)
                            KEY_MOVE_RIGHT:
                            begin
                                user_has_input = 1;
                                attempt_move_next = MOVE_RIGHT;
                            end
                            KEY_MOVE_LEFT:
                            begin
                                user_has_input = 1;
                                attempt_move_next = MOVE_LEFT;
                            end
                            KEY_MOVE_ROTATE:
                            begin
                                user_has_input = 1;
                                attempt_move_next = MOVE_ROTATE;
                            end
                            default:
                                attempt_move_next = MOVE_DOWN;
                        endcase
                    end
                    else
                        attempt_move_next = MOVE_DOWN;
                end
            end
        end
    
    // This ff block is used to update the actual_move to attemt_mvoe
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                attempt_move <= MOVE_DOWN;
            else
                if( ( game_state_next == CHECK_MOVE_S ) && ( game_state != CHECK_MOVE_S ) )
                    attempt_move <= attempt_move_next;
        end

    assign check_start = (game_state != CHECK_MOVE_S) && (game_state_next == CHECK_MOVE_S);
    check_move check_move_inst(
        .frame_clk(frame_clk),
        .Reset(Reset),
        .check_start(check_start),
        .background_playfield(background_playfield),
        .curr_block(curr_block),
        .attempt_move(attempt_move_next),
        .check_move_done(check_move_done),
        .move_valid(move_valid),
        .move_x(move_x),
        .move_y(move_y)
    );
    
    


    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                draw_block_en <= 0;
            else
            begin
                if (check_move_done && (attempt_move != MOVE_APPEAR || move_valid == 1))
                    draw_block_en <= 1;
                else
                begin
                    if ((game_state == IDLE_S) || (game_state == GEN_NEW_BLOCK_S) || ((game_state == CLEAN_LINE_S) && (full_row != 0)))
                        draw_block_en <= 0;
                end
            end
        end    
    
    //  || (game_state == APPEND_BLOCK_S)
    logic  [`PLAYFIELD_ROW_WIDTH-1:0] row_cnt;
    always_comb
        begin
            full_row = 'd0;
            full_row_num = 'd0;
            for( int row = 0; row < `PLAYFIELD_ROW ; row++ )
            begin
                full_row[row] = 1'b1;
                full_row_num = full_row_num + 1;
                for( int col = 0; col < `PLAYFIELD_COL; col++ )
                begin
                    if (background_playfield[row][col]==0)
                    begin
                        full_row[row] = 1'b0;
                        full_row_num = full_row_num - 1;
                        break;
                    end
                end
            end
            
            for( int row = 0; row < `PLAYFIELD_ROW ; row++ )
            begin
                for( int col = 0; col < `PLAYFIELD_COL; col++ )
                begin
                    line_cleaned_playfield[row][col] = 'd0;
                end
            end

            row_cnt = `PLAYFIELD_ROW-1;
            for (int row = `PLAYFIELD_ROW-1; row >= 0; row--)
                if (full_row[row] == 0)
                begin
                    for( int col = 0; col < `PLAYFIELD_COL; col++ )
                    begin
                        line_cleaned_playfield[row_cnt][col] = background_playfield[row][col];
                    end
                    row_cnt = row_cnt - 1;
                end

        end
        

endmodule
