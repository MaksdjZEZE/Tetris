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
    logic [10:0] font_addr;
    logic [7:0] font_data; 
    logic [10:0] text[9] = '{11'h47, 11'h41, 11'h4D, 11'h45, 11'h4F, 11'h56, 11'h45, 11'h52, 11'h21};
    logic [10:0] text1[22] = '{11'h50, 11'h72, 11'h65, 11'h73, 11'h73, 11'h20, 11'h45, 11'h6E, 11'h74, 11'h65, 11'h72, 11'h20, 11'h74, 11'h6F, 11'h20, 11'h72, 11'h65, 11'h73, 11'h74, 11'h61, 11'h72, 11'h74};
    font_rom font_inst(.addr(font_addr), .data(font_data)); 
    
    always_comb
    begin
        font_addr = 320;
        if (draw_x >= 240 && draw_x < 312 && draw_y >= 128 && draw_y < 144)
        begin
            font_addr = 16*text[(draw_x-240) >> 3] + draw_y[3:0];   
        end
        if (draw_x >= 184 && draw_x < 360 && draw_y >= 176 && draw_y < 192)
        begin
            font_addr = 16*text1[(draw_x-184) >> 3] + draw_y[3:0];   
        end
    end
    
    always_comb 
        begin
            red = 4'hf;
            green = 4'hf;
            blue = 4'hf;
//            if (draw_x >= 200 && draw_x < 440 && draw_y >= 120 && draw_y < 160)
//            begin
//                red = 4'hd;
//                green = 4'hd;
//                blue = 4'hd;
//            end
            if (draw_x >= 240 && draw_x < 312 && draw_y >= 128 && draw_y < 144)
            begin
                if (font_data[7 - draw_x[2:0]] == 1)
                begin
                    red = 4'h0;
                    green = 4'h0;
                    blue = 4'h0; 
                end
            end
            else if (draw_x >= 184 && draw_x < 360 && draw_y >= 176 && draw_y < 192)
            begin
                if (font_data[7 - draw_x[2:0]] == 1)
                begin
                    red = 4'h0;
                    green = 4'h0;
                    blue = 4'h0; 
                end
            end
        end
endmodule
