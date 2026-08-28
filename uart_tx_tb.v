`timescale 1 ns / 100 ps
module uart_tx_top_tb;
    reg clk, rst;
    reg [7:0] P_DATA;
    reg V_INPUT, P_EN, P_BIT;
    wire TX_OUT, BUSY;
    uart_tx_top my_uart (
        .clk(clk), .rst(rst),
        .P_DATA(P_DATA), .V_INPUT(V_INPUT), .P_EN(P_EN), .P_BIT(P_BIT),
        .TX_OUT(TX_OUT), .BUSY(BUSY)
    );
    always #5 clk= ~clk;
    initial begin
        $monitor("Time=%0t | rst=%b | V_IN=%b | DATA=%b | EN=%b | BIT=%b | TX_OUT=%b | BUSY=%b", 
                 $time,rst,V_INPUT , P_DATA,P_EN, P_BIT, TX_OUT, BUSY);
                 
        clk= 0;rst =0;V_INPUT = 0; 
        P_DATA= 8'b0; P_EN = 0; P_BIT = 0;
        #12 rst= 1; 

        P_DATA = $random; 
        P_EN = 0;
        P_BIT = $random;  

        @(negedge clk) V_INPUT = 1;
        @(negedge clk) V_INPUT = 0;
        wait(!BUSY); 
        #20;

        P_DATA = $random; 
        P_EN = 1;
        P_BIT = 0;
        
        @(negedge clk) V_INPUT = 1;
        @(negedge clk) V_INPUT = 0;
        wait(!BUSY); 
        #20;

        P_DATA = $random; 
        P_EN = 1;
        P_BIT = 1; 
        
        @(negedge clk)V_INPUT= 1;
        @(negedge clk) V_INPUT = 0;
        wait(!BUSY); 
        #20;

        P_DATA = $random; P_EN = $random; P_BIT = $random;
        @(negedge clk) V_INPUT = 1;
        @(negedge clk) V_INPUT = 0;
        wait(!BUSY);

        P_DATA = $random; P_EN = $random; P_BIT = $random;
        @(negedge clk) V_INPUT = 1;
        @(negedge clk) V_INPUT = 0;
        wait(!BUSY);
        #20;

        P_DATA = $random; P_EN = $random; P_BIT = $random;
        @(negedge clk) V_INPUT = 1;
        @(negedge clk) V_INPUT = 0;
        #40;

        P_DATA = $random; 
        V_INPUT = 1; 
        #10 V_INPUT = 0;

        wait(!BUSY);
        #50 $stop;
    end
endmodule