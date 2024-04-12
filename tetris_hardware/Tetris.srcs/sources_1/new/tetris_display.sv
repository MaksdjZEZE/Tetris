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
    always_comb
      begin
    
        for( int row = 0; row < `PLAYFIELD_ROW; row++ )
          begin
            for( int col = 0; col < `PLAYFIELD_COL; col++ )
              begin
                playfield[row][col] = (col % 7) + 1;
              end
          end
      end
      
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

