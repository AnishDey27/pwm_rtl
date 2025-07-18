module pwm_rtl #(
    parameter WIDTH = 4
)(
    output out,
    output ready,
    input clk,
    input[WIDTH-1:0] div,
    input[WIDTH-1:0] duty,
    input div_valid,
    input duty_valid,
    input rst_n
);
    reg out_reg;
    reg [WIDTH-1:0] counter;
    reg [WIDTH-1:0] div_store, duty_store;
    wire next_out;

    // COUNTER
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) counter <= 0;
        else if (ready) counter <= 0;
        else counter <= counter + 1'b1;
    end

    assign ready = (counter == div_store - 1);

    // DIV LOAD
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) div_store <= 1;
        else if(div_valid && ready && (div != 0)) div_store <= div;
    end

    // DUTY LOAD
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) duty_store <= 0;
        else if(duty_valid && ready) duty_store <= duty;
    end

    // OUTPUT
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) out_reg <= 0;
        else out_reg <= next_out;
    end

    assign next_out = (counter < duty_store);
    assign out = out_reg;

endmodule