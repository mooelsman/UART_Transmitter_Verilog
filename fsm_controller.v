module fsm_controller (
    input wire clk, rst, V_INPUT,P_EN, ser_done,
    output reg [1:0]mux_sel,
    output reg ser_start, BUSY
);
    localparam IDLE   = 3'd0;
    localparam START  = 3'd1;
    localparam DATA   = 3'd2;
    localparam PARITY = 3'd3;
    localparam STOP   = 3'd4;

    reg[2:0] current_state, next_state;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            current_state<= IDLE;
        end
        else begin
            current_state<= next_state;
        end
    end
    always @(*) begin
        next_state= current_state;
        mux_sel= 2'b11;
        ser_start= 1'b0;
        BUSY= 1'b1;
        case (current_state)
            IDLE: begin
                BUSY=1'b0;
                mux_sel= 2'b11;
                if (V_INPUT==1'b1) begin
                    next_state= START;
                end
            end
            START: begin
                mux_sel=2'b00;
                next_state= DATA;
            end
            DATA:begin
                mux_sel=2'b01;
                ser_start=1'b1;
                if(ser_done==1'b1)begin
                    ser_start=1'b0;
                    if (P_EN==1'b1) begin
                        next_state=PARITY;
                    end
                    else begin
                        next_state=STOP;
                    end
                end
            end
            PARITY: begin
                mux_sel=2'b10;
                next_state= STOP;
            end
            STOP:begin
                mux_sel=2'b11;
                next_state=IDLE;
            end
            default: begin
                next_state=IDLE;
            end
        endcase
    end

endmodule