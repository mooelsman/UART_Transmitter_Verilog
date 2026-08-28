`timescale 1 ns / 100 ps
module parity_calc_tb;

    reg [7:0] P_DATA;
    reg P_EN, P_BIT;
    wire P_OUT;
    integer i; 
    parity_calc my_parity_calc (
        .P_DATA(P_DATA), .P_EN(P_EN), .P_BIT(P_BIT), .P_OUT(P_OUT)
    );

    initial begin
        $monitor("Time=%0t | EN=%b | BIT=%b | DATA=%b | P_OUT=%b", 
                 $time, P_EN, P_BIT, P_DATA, P_OUT);
                 
        for (i=0; i<10; i=i+1) begin
            #10;
            P_DATA= $random;
            P_EN= $random; 
            P_BIT= $random;
        end
        #10 $stop;
    end
endmodule