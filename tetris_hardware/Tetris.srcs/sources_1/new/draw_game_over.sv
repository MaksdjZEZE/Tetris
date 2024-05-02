`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/01 19:25:34
// Design Name: 
// Module Name: draw_game_over
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


module draw_game_over(
        input  logic [9:0] draw_x, 
        input logic [9:0] draw_y,
        output logic [3:0]  red, green, blue
    );
    
    always_comb 
        begin
            red = 4'hf;
            green = 4'hf;
            blue = 4'hf;
            if (draw_x >= 200 && draw_x < 440 && draw_y >= 120 && draw_y < 160)
            begin
                red = 4'hd;
                green = 4'hd;
                blue = 4'hd;
            end
        end
endmodule
