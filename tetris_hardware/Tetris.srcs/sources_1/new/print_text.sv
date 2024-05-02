`timescale 1ns / 1ps

`include "tetris_define.vh"
module print_text #(parameter [3:0] text_length = 10)(
    input logic [9:0] draw_x, 
    input logic [9:0] draw_y,
    input logic [9:0] card_x,
    input logic [9:0] card_y,
    input logic [15:0] score,
    input logic mode,
    output logic [`TETRIS_COLORS_NUM_WIDTH:0] color_picker
    );
    
    // this module aims at painting string with given ascii code on the screen at coordinate x and y.
    // it has two mode:
    // mode = 0  ==> print(f"score{score}") on the screen and don't care variable printed_text, text_length
    // mode = 1  ==> print(text[0:n-1]) on the screen and don't care variable score.
    logic [7:0] font_data;
    logic [10:0] font_addr;
    logic [11:0] ascii_address;
    logic [1:0] selector;
    logic [10:0] text_score[6] = '{11'h53, 11'h63, 11'h6F, 11'h72, 11'h65, 11'h3A}; // ascii for string 'Score:'
    
    localparam MODE0_TEXT_LENGTH = 48;  //length of "Score:"   
    localparam MODE0_TOTAL_LENGTH = 80;
    
    ScoreToAscii ScoreToAscii_inst(.score(score),.selector(selector),.ascii_address(ascii_address));
    font_rom font_inst(.addr(font_addr), .data(font_data));  
    
    always_comb
    begin
        case(mode)
            // mode = 0  ==> print(f"score{score}") on the screen and don't care variable printed_text, text_length
            1'b0:
            begin
                if (draw_x >= (card_x) && draw_x < card_x + MODE0_TOTAL_LENGTH) 
                begin
                   if (draw_x < card_x + MODE0_TEXT_LENGTH)
                   begin
                        // print "Score"
                        font_addr = 16*text_score[(draw_x-card_x) >> 3 ]+draw_y[3:0];
                   end 
                   else begin
                        // print score
                        font_addr = 16 * ascii_address + draw_y[3:0];  
                   end
                end
            end
            
//            1'b1:
//            begin
//            // mode = 1  ==> print(text[0:n-1]) on the screen and don't care variable score.
//                if (draw_x >= card_x  && draw_x < card_x + text_length*8 && draw_y >= card_y && draw_y < card_y+16)
//                begin
//                    font_addr = 16*printed_text[(draw_x-card_x) >> 3]+draw_y[3:0];
//                end 
//            end   
            default: 
            begin
                if (draw_x >= (card_x) && draw_x < card_x + MODE0_TOTAL_LENGTH) 
                begin
                   if (draw_x < card_x + MODE0_TEXT_LENGTH)
                   begin
                        // print "Score"
                        font_addr = 16*text_score[(draw_x-card_x) >> 3 ]+draw_y[3:0];
                   end 
                   else begin
                        // print score
                        font_addr = 16 * ascii_address + draw_y[3:0];  
                   end
                end
            end
        endcase
    end
    
    always_comb
    begin
        if (font_data[7 - draw_x[2:0]] == 1)begin
            color_picker = 8;
        end 
        else begin 
            color_picker = 0;
        end
    end
endmodule
