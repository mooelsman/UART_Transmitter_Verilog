`timescale 1 ns / 100 ps
module mux_tb;

    reg data, parity_bit;
    reg [1:0] sel;
    wire tx_out;
    integer i;

    mux my_mux (
        .data(data), .parity_bit(parity_bit), .sel(sel), .tx_out(tx_out)
    );

    initial begin
        $monitor("Time=%0t | sel=%b | data=%b | parity_bit=%b | tx_out=%b", 
                 $time, sel, data, parity_bit, tx_out);
                 
        for (i =0;i<15; i=i+1) begin
            #10;
            data= $random;
            parity_bit= $random;
            sel= $random;
        end
        
        #10 $stop;
    end
endmodule