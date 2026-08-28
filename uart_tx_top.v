module uart_tx_top (
    input wire clk, rst,
    input wire [7:0] P_DATA,
    input wire V_INPUT,
    input wire P_EN,
    input wire P_BIT, 
    output wire TX_OUT,
    output wire BUSY
);
    wire w_ser_done;    
    wire w_ser_start;
    wire [1:0] w_mux_sel;
    wire w_ser_data_out;
    wire w_parity_out;
    fsm_controller fsm_inst (
        .clk(clk),
        .rst(rst),
        .V_INPUT(V_INPUT),
        .P_EN(P_EN),
        .ser_done(w_ser_done),
        .mux_sel(w_mux_sel),
        .ser_start(w_ser_start),
        .BUSY(BUSY)
    );
    serializer ser_inst (
        .p_in(P_DATA),
        .clk(clk),
        .rst(rst),
        .load(V_INPUT),      
        .start(w_ser_start),
        .s_out(w_ser_data_out),
        .done(w_ser_done)
    );

    parity_calc parity_inst (
        .P_DATA(P_DATA),
        .P_EN(P_EN),
        .P_BIT(P_BIT),
        .P_OUT(w_parity_out)
    );
    mux mux_inst (
        .data(w_ser_data_out),
        .parity_bit(w_parity_out),
        .sel(w_mux_sel),
        .tx_out(TX_OUT)
    );

endmodule