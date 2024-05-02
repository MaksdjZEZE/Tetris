`timescale 1ns / 1ps
module PWM_Mixer (
    input logic clk,
    input logic rst_n,
    input logic [15:0] pwm_left,  // ������ PWM ����
    input logic [15:0] pwm_right, // ������ PWM ����
    output logic [15:0] pwm_out   // ��Ϻ�� PWM ���
);

    // ����Ȩ�أ��ɵ����Կ��ƻ�ϱ�����
    parameter WEIGHT_LEFT = 8'h80;
    parameter WEIGHT_RIGHT = 8'h80;

    // ������ PWM ��Ȩ�����
    logic [15:0] pwm_left_weighted = pwm_left * WEIGHT_LEFT;

    // ������ PWM ��Ȩ�����
    logic [15:0] pwm_right_weighted = pwm_right * WEIGHT_RIGHT;

    // ��Ϻ�� PWM ���
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pwm_out <= 16'h0000;
        end else begin
            // ������������Ȩ���
            pwm_out <= pwm_left_weighted + pwm_right_weighted;
        end
    end

endmodule

