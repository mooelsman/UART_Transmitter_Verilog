module parity_calc (
    input wire [7:0] P_DATA,
    input wire P_EN,P_BIT,
    output reg P_OUT
);
    always @(*) begin
        if (P_EN==1'b0) begin
            P_OUT=1'b0;
        end
        else  begin
            if (P_BIT==1'b0) begin
                P_OUT=^P_DATA;
            end
            else begin
                P_OUT=~^P_DATA;
            end
        end
    end
endmodule