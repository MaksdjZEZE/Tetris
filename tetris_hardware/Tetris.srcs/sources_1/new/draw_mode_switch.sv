`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/01 18:57:09
// Design Name: 
// Module Name: draw_mode_switch
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


module draw_mode_switch(
        input  logic [9:0] draw_x, 
        input logic [9:0] draw_y,
        input logic [1:0] player_mode,
        output logic [3:0]  red, green, blue
    );
    always_comb
        begin
            red = 4'hf;
            green = 4'hf;
            blue = 4'hf;
            if (draw_x >= 200 && draw_x < 440)
            begin
                if (draw_y >= 120 && draw_y < 160)
                begin
                    if (player_mode == 'd1)
                    begin
                        red = 4'h0;
                        green = 4'h0;
                        blue = 4'hf;
                    end
                    else
                    begin
                        red = 4'hf;
                        green = 4'h0;
                        blue = 4'h0;
                    end
                end
                else if (draw_y >= 200 && draw_y < 240)
                begin
                    if (player_mode == 'd2)
                    begin
                        red = 4'h0;
                        green = 4'h0;
                        blue = 4'hf;
                    end
                    else
                    begin
                        red = 4'hf;
                        green = 4'h0;
                        blue = 4'h0;
                    end
                end
            end
        end
endmodule
