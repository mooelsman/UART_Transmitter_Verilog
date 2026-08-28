module mux (
    input wire data, parity_bit,
    input wire [1:0] sel,
    output reg tx_out
);
    always @(*) begin
        case (sel)
            2'b00:tx_out= 1'b0; 
            2'b01:tx_out= data;
            2'b10:tx_out= parity_bit;
            2'b11:tx_out= 1'b1;
            default: tx_out= 1'b1;
        endcase
    end
endmodule