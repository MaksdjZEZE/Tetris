`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/17 16:42:33
// Design Name: 
// Module Name: check_move
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
module check_move(
    input logic frame_clk,
    input logic Reset,
    input logic check_start,
    input logic [`TETRIS_COLORS_NUM_WIDTH-1:0] background_playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL],
    input block_info_t curr_block,
    input block_move_t attempt_move,
    
    output logic check_move_done,
    output logic move_valid,
    output logic signed [1:0] move_x,
    output logic signed [1:0] move_y
    );
    logic signed [1:0] move_x_temp;
    logic signed [1:0] move_y_temp;
    
    logic signed [`PLAYFIELD_COL_WIDTH:0] check_col;
    logic signed [`PLAYFIELD_ROW_WIDTH:0] check_row;
    
    logic move_valid_temp;
    logic check_move_done_temp;
    logic [1:0] attempt_point;
    enum logic [1:0] {
        CHECK_IDLE,
        CHECKING,
        CHECK_DONE
    } check_state, check_state_next;
    
    always_ff @(posedge frame_clk or posedge Reset)
        begin
            if(Reset)
                check_state <= CHECK_IDLE;
            else
                check_state <= check_state_next;
        end
        
    always_ff @(posedge frame_clk)
        begin
            move_valid <= move_valid_temp;
            check_move_done <= check_move_done_temp;
            move_x <= move_x_temp;
            move_y <= move_y_temp;
        end   
        
    always_comb
        begin
            check_state_next = check_state;
            check_move_done_temp = 0;
            move_valid_temp = move_valid;
            attempt_point = curr_block.point;
            case (check_state)
                CHECK_IDLE:
                begin
                    if (check_start)
                    begin
                        case (attempt_move)
                            MOVE_LEFT:
                            begin
                                move_x_temp = -1;
                                move_y_temp = 0;
                            end
                            MOVE_RIGHT:
                            begin
                                move_x_temp = 1;
                                move_y_temp = 0;
                            end
                            MOVE_DOWN:
                            begin
                                move_x_temp = 0;
                                move_y_temp = 1;
                            end
                            MOVE_ROTATE:
                                attempt_point = (attempt_point + 1) % 4;
                            default:
                            begin
                                move_x_temp = 0;
                                move_y_temp = 0;
                            end
                        endcase
                        check_state_next = CHECKING;
                    end
                end
                
                CHECKING:
                begin
                    move_valid_temp = 1;
                    for( int row = 0; row < 4; row++ )
                      begin
                        for( int col = 0; col < 4; col++ )
                          begin
                            if(curr_block.data[attempt_point][row][col] == 1'd1)
                                begin
                                    check_col = curr_block.x + col + move_x_temp;
                                    check_row = curr_block.y + row + move_y_temp;
                                    if( check_col < 0 || check_col >= `PLAYFIELD_COL || check_row >= `PLAYFIELD_ROW || background_playfield[check_row][check_col]!=0)
                                    begin    
                                        move_valid_temp = 0;
                                        break;
                                    end
                                end
                          end
                      end
                    check_state_next = CHECK_DONE;
                end
                
                CHECK_DONE:
                begin
                    check_move_done_temp = 1;
                    check_state_next = CHECK_IDLE;
                end
            endcase
        end
    
endmodule
