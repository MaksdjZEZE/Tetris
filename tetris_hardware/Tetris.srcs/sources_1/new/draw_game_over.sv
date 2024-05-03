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
        output logic [3:0]  red, green, blue,
        output logic draw_game_over_en
    );
    logic [10:0] font_addr;
    logic [7:0] font_data; 
    logic [10:0] text[9] = '{11'h47, 11'h41, 11'h4D, 11'h45, 11'h4F, 11'h56, 11'h45, 11'h52, 11'h21};
    logic [10:0] text1[22] = '{11'h50, 11'h72, 11'h65, 11'h73, 11'h73, 11'h20, 11'h45, 11'h6E, 11'h74, 11'h65, 11'h72, 11'h20, 11'h74, 11'h6F, 11'h20, 11'h72, 11'h65, 11'h73, 11'h74, 11'h61, 11'h72, 11'h74};
    font_rom font_inst(.addr(font_addr), .data(font_data)); 
    
    always_comb
    begin
        font_addr = 320;
        if (draw_x >= 280 && draw_x < 352 && draw_y >= 96 && draw_y < 112)
        begin
            font_addr = 16*text[(draw_x-280) >> 3] + draw_y[3:0];   
        end
        if (draw_x >= 224 && draw_x < 400 && draw_y >= 144 && draw_y < 160)
        begin
            font_addr = 16*text1[(draw_x-224) >> 3] + draw_y[3:0];   
        end
    end
    
    always_comb 
        begin
            red = 4'hf;
            green = 4'hf;
            blue = 4'hf;
            draw_game_over_en = 1'b0;
//            if (draw_x >= 200 && draw_x < 440 && draw_y >= 120 && draw_y < 160)
//            begin
//                red = 4'hd;
//                green = 4'hd;
//                blue = 4'hd;
//            end
            if (draw_x >= 280 && draw_x < 352 && draw_y >= 96 && draw_y < 112)
            begin
                if (font_data[7 - draw_x[2:0]] == 1)
                begin
                    draw_game_over_en = 1'b1;
                    red = 4'hf;
                    green = 4'h0;
                    blue = 4'h0; 
                end
            end
            else if (draw_x >= 224 && draw_x < 400 && draw_y >= 144 && draw_y < 160)
            begin
                if (font_data[7 - draw_x[2:0]] == 1)
                begin
                    draw_game_over_en = 1'b1;
                    red = 4'h0;
                    green = 4'h0;
                    blue = 4'hf; 
                end
            end
        end
endmodule