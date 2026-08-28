`timescale 1 ns / 100 ps
module serializer_tb;

    reg [7:0] p_in;
    reg clk, rst, load, start;
    wire s_out,done;
    integer i;
    serializer my_serializer (
    .p_in(p_in), .clk(clk), .rst(rst),
    .load(load), .start(start),
    .s_out(s_out), .done(done)
  );
  
  always #5 clk =~clk;
  initial begin
    $monitor("Time=%0t | rst=%b | load=%b | start=%b | s_out=%b | done=%b",
    $time, rst, load, start, s_out, done);
    clk=0;
    rst=0;
    load=0;
    start=0;
    p_in=8'b0;
    #10;
    rst=1;
    
    for (i =0 ;i<10 ;i=i+1 ) begin
        #10;
        p_in =$random;
        load=1;
        #10;
        load=0;
        start=1;
        wait(done);
        @(negedge clk);
        start = 0;
        #10;
    end
    $stop;
  end
endmodule