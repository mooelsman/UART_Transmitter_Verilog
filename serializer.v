module serializer (
    input wire [7:0]  p_in,
    input wire clk,rst,load,start,
    output reg s_out,
    output reg done
);
    reg [7:0] data;
    reg [3:0] count;
    always @(posedge clk or negedge rst) begin
        if (rst == 0) begin
            data<=8'b0;
            count<=0;
            s_out<=0;
            done <=0;
        end
        else if (load==1) begin
            data<= p_in;
            count<=0;
            done<=0;
        end
        else if(start==1) begin
            if (count<8) begin
                s_out<= data[0];
                data <=data >>1;
                count<=count+1;
                done<=0;
            end
            else begin
                done <=1;
            end
        end
    end
endmodule