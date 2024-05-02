`timescale 1ns / 1ps
module PWM_Mixer (
    input logic clk,
    input logic rst_n,
    input logic [15:0] pwm_left,  // 左声道 PWM 输入
    input logic [15:0] pwm_right, // 右声道 PWM 输入
    output logic [15:0] pwm_out   // 混合后的 PWM 输出
);

    // 定义权重（可调整以控制混合比例）
    parameter WEIGHT_LEFT = 8'h80;
    parameter WEIGHT_RIGHT = 8'h80;

    // 左声道 PWM 和权重相乘
    logic [15:0] pwm_left_weighted = pwm_left * WEIGHT_LEFT;

    // 右声道 PWM 和权重相乘
    logic [15:0] pwm_right_weighted = pwm_right * WEIGHT_RIGHT;

    // 混合后的 PWM 输出
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pwm_out <= 16'h0000;
        end else begin
            // 将左右声道加权相加
            pwm_out <= pwm_left_weighted + pwm_right_weighted;
        end
    end

endmodule

