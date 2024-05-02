//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2024/05/01 18:57:09
//// Design Name: 
//// Module Name: draw_mode_switch
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module draw_mode_switch(
//        input  logic [9:0] draw_x, 
//        input logic [9:0] draw_y,
//        input logic [1:0] player_mode,
//        output logic [3:0]  red, green, blue
//    );
    
//    logic [10:0] font_addr;
//    logic [7:0] font_data;
//    // 1P MODE
//    // 2P MODE
//    logic [10:0] text1[7] = '{11'h31, 11'h50, 11'h20, 11'h4D, 11'h4F, 11'h44, 11'h45};
//    logic [10:0] text2[7] = '{11'h32, 11'h50, 11'h20, 11'h4D, 11'h4F, 11'h44, 11'h45};

//    font_rom font_inst(.addr(font_addr), .data(font_data)); 
    
//    always_comb
//    begin
//        if (draw_x >=240 && draw_x < 296 && draw_y >= 120 && draw_y < 128)
//        begin
//            font_addr = 16*text1[(draw_x-240) >> 3] + draw_y[3:0];   
//        end
//        else if (draw_x >=240 && draw_x < 296 && draw_y >= 200 && draw_y < 208)
//        begin
//            font_addr = 16*text2[(draw_x-240) >> 3] + draw_y[3:0];   
//        end
//    end
    
//    always_comb
//        begin
//            red = 4'hf;
//            green = 4'hf;
//            blue = 4'hf;
//            if (draw_x >= 200 && draw_x < 440)
//            begin
//                if (draw_y >= 120 && draw_y < 160)
//                begin
//                    if (font_data[7 - draw_x[2:0]] != 1)
//                    begin
//                        red = 4'hf;
//                        green = 4'hf;
//                        blue = 4'hf;
//                    end 
//                    else if (player_mode == 'd1)
//                    begin
//                        red = 4'h0;
//                        green = 4'h0;
//                        blue = 4'hf;
//                    end
//                    else
//                    begin
//                        red = 4'hf;
//                        green = 4'h0;
//                        blue = 4'h0;
//                    end
//                end
//                else if (draw_y >= 200 && draw_y < 240)
//                begin
//                    if (font_data[7 - draw_x[2:0]] != 1)
//                    begin
//                        red = 4'hf;
//                        green = 4'hf;
//                        blue = 4'hf;
//                    end 
//                    else if (player_mode == 'd2)
//                    begin
//                        red = 4'h0;
//                        green = 4'h0;
//                        blue = 4'hf;
//                    end
//                    else
//                    begin
//                        red = 4'hf;
//                        green = 4'h0;
//                        blue = 4'h0;
//                    end
//                end
//            end
//        end
//endmodule

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
    
    logic [10:0] font_addr;
    logic [7:0] font_data; 
    logic [10:0] text1[8] = '{11'h31, 11'h50, 11'h20, 11'h4D, 11'h4F, 11'h44, 11'h45,11'h20};
    logic [10:0] text2[8] = '{11'h32, 11'h50, 11'h20, 11'h4D, 11'h4F, 11'h44, 11'h45,11'h20};
    font_rom font_inst(.addr(font_addr), .data(font_data)); 

    always_comb
    begin
        font_addr = 320;
        if (draw_x >= 240 && draw_x < 296)
        begin
            if (draw_y >= 128 && draw_y < 144)
            begin
                font_addr = 16*text1[(draw_x-240) >> 3] + draw_y[3:0]; 
            end
            else if (draw_y >= 208 && draw_y < 224)
            begin
                font_addr = 16*text2[(draw_x-240) >> 3] + draw_y[3:0]; 
            end
        end

    end
    always_comb
        begin
            red = 4'hf;
            green = 4'hf;
            blue = 4'hf;
            if (draw_x >= 200 && draw_x < 440)
            begin
                if (draw_y >= 120 && draw_y < 160)
                begin
                    if (font_data[7 - draw_x[2:0]] == 1)
                    begin
                        red = 4'hf;
                        green = 4'hf;
                        blue = 4'hf;
                    end
                    else if (player_mode == 'd1)
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
                    if (font_data[7 - draw_x[2:0]] == 1)
                    begin
                        red = 4'hf;
                        green = 4'hf;
                        blue = 4'hf;
                    end
                    else if (player_mode == 'd2)
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
