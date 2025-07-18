`timescale 1ns / 1ps

module pwm_rtl_tb();
    localparam TB_WIDTH   = 4;
    localparam CLK_PERIOD = 2; // 2ns = 500MHz clock

    reg [TB_WIDTH-1:0] div, duty;
    reg clk, rst_n, div_valid, duty_valid;
    wire out, ready;

    pwm_rtl #(.WIDTH(TB_WIDTH)) dut(
        .out(out),
        .ready(ready),
        .clk(clk),
        .div(div),
        .duty(duty),
        .div_valid(div_valid),
        .duty_valid(duty_valid),
        .rst_n(rst_n)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;    
    end

    initial begin
        rst_n = 0; div = 10; duty = 5; div_valid = 1; duty_valid = 1;
        #5 rst_n = 1;

        #10 duty = 7; // glitch free duty change mid-cycle.

        #15 div_valid = 0; duty_valid = 0; div = 15; duty = 6; // no loading

        #20 div_valid = 1; duty_valid = 1; // load on handshake.

        #10 div = 10; duty = 0; // 0% duty

        #20 div = 12; duty = 12; // 100% duty

        #20 div = 1; duty = 0; // minimum div

        #20 div = 10; duty = 5; // div = 10, 50% duty

        #15 div = 0; // rejected.
    end

    initial #180 $finish;

endmodule