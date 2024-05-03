`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/11 17:12:22
// Design Name: 
// Module Name: draw_playfield
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
module draw_playfield #(parameter [9:0] PLAYFIELD_X_ = 80,
                        parameter [9:0] PLAYFIELD_Y_ = 120)(
    input  logic [9:0] draw_x, 
    input logic [9:0] draw_y,
    input block_info_t generated_block,
    input  logic [`TETRIS_COLORS_NUM_WIDTH-1:0] playfield[`PLAYFIELD_ROW][`PLAYFIELD_COL],
    output logic draw_field_en,
    output logic [3:0]  red, green, blue
    );
    
    localparam [9:0] BLOCK_SIZE_ = `BLOCK_SIZE;
    localparam [9:0] PLAYFIELD_WIDTH_ = `PLAYFIELD_WIDTH;
    localparam [9:0] PLAYFIELD_HEIGHT_ = `PLAYFIELD_HEIGHT;
    
    localparam [11:0] TETRIS_COLOR [`TETRIS_COLORS_NUM + 1] = {
        12'hfff, //f f f 
        12'h3cf, //49 199 239
        12'hfd0, //247 211 8
        12'ha5a, //66 182 66
        12'h4b4, //66 182 66
        12'he23, //239 32 41
        12'h66b, //90 101 173
        12'hf82, //239 121 33
        12'h000 // 0 0 0
    };
    logic [`PLAYFIELD_COL_WIDTH-1:0] col;
    logic [`PLAYFIELD_ROW_WIDTH-1:0] row;
    logic [9:0] field_x, field_y;
    logic [`BLOCK_SIZE_WIDTH-1:0] block_x, block_y;
    logic [`TETRIS_COLORS_NUM_WIDTH:0] color_picker;
    always_comb begin
        color_picker = 0;
        draw_field_en = 1'b0;
        if ((draw_x >= PLAYFIELD_X_-1) && (draw_x <= PLAYFIELD_X_ + PLAYFIELD_WIDTH_) && (draw_y >= PLAYFIELD_Y_-1) && (draw_y <= PLAYFIELD_Y_ + PLAYFIELD_HEIGHT_))
        begin
            // If draw_x, draw_y inside the field:
            draw_field_en = 1'b1;
            color_picker = 8;
            if ((draw_x >= PLAYFIELD_X_) && (draw_x < PLAYFIELD_X_ + PLAYFIELD_WIDTH_) && (draw_y >= PLAYFIELD_Y_) && (draw_y < PLAYFIELD_Y_ + PLAYFIELD_HEIGHT_))
            begin        
                // caculate the col and row in the field
                field_x = draw_x - PLAYFIELD_X_;
                field_y = draw_y - PLAYFIELD_Y_;
                col = field_x[9:4];
                row = field_y[9:4];
                block_x = field_x - (col<<4);
                block_y = field_y - (row<<4);
                
                if (block_x == 0 || block_y == 0 || block_x == BLOCK_SIZE_ - 1 || block_y == BLOCK_SIZE_ - 1)
                    color_picker = 0;
                else
                    color_picker = playfield[row][col];
                  
            end
        end
        else if ((draw_x >= PLAYFIELD_X_ + 168) && (draw_x < PLAYFIELD_X_ + 232) && (draw_y >= PLAYFIELD_Y_ + 256) && (draw_y < PLAYFIELD_Y_ + 320))
        begin
            draw_field_en = 1'b1;
            field_x = draw_x - (PLAYFIELD_X_ + 168);
            field_y = draw_y - (PLAYFIELD_Y_ + 256);
            col = field_x[9:4];
            row = field_y[9:4];
            block_x = field_x - (col<<4);
            block_y = field_y - (row<<4);
            
            if (block_x == 0 || block_y == 0 || block_x == BLOCK_SIZE_ - 1 || block_y == BLOCK_SIZE_ - 1)
                color_picker = 0;
            else
            begin
                if (generated_block.data[generated_block.point][row][col] == 1'd1)
                    color_picker = generated_block.color;
                else
                    color_picker = 0;
             end
        end

        red = TETRIS_COLOR[color_picker][11:8];
        green = TETRIS_COLOR[color_picker][7:4];
        blue = TETRIS_COLOR[color_picker][3:0];
    end
endmodule
