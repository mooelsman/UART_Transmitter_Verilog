`timescale 1 ns / 100 ps
module fsm_controller_tb;

    reg clk, rst, V_INPUT, P_EN, ser_done;
    wire [1:0] mux_sel;
    wire ser_start, BUSY;

    fsm_controller uut (
        .clk(clk), .rst(rst), .V_INPUT(V_INPUT), .P_EN(P_EN), .ser_done(ser_done),
        .mux_sel(mux_sel), .ser_start(ser_start), .BUSY(BUSY)
    );
    always #5 clk= ~clk;
    initial begin
        $monitor("Time=%0t | rst=%b | V_INPUT=%b | ser_done=%b | BUSY=%b | mux_sel=%b | ser_start=%b", 
                 $time, rst, V_INPUT, ser_done, BUSY, mux_sel, ser_start);
        clk= 0; 
        rst= 0;
        V_INPUT =0;
        P_EN= 1;
        ser_done= 0;
        #12 rst = 1; 
        #10 V_INPUT = 1; 
        #10 V_INPUT = 0; 
        #40 ser_done = 1; 
        #10 ser_done = 0; 
        #30 $stop;
    end
endmodule