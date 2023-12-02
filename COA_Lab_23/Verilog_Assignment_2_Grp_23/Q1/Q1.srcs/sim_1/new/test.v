module testbench;
    reg [2:0] src;
    reg [2:0] dest;
    reg [15:0] val;
    reg move_in;
    wire [15:0] out;
    reg clk;
    registerfile DUT(src,dest,move_in,val,out,clk);
    initial
    begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial
        begin
            $monitor($time,"src=%d,dest=%d,val=%d,move_in=%d,out=%d",src,dest,val,move_in,out);
            #0 dest=1;val=48;move_in=0;
            $monitor($time,"src=%d,dest=%d,val=%d,move_in=%d,out=%d",src,dest,val,move_in,out);
            #20 dest=2;val=18;move_in=0;
            $monitor($time,"src=%d,dest=%d,val=%d,move_in=%d,out=%d",src,dest,val,move_in,out);
            #20 src=1;dest=3;move_in=1;
            $monitor($time,"src=%d,dest=%d,val=%d,move_in=%d,out=%d",src,dest,val,move_in,out);
            #20 src=2;dest=1;move_in=1;
            $monitor($time,"src=%d,dest=%d,val=%d,move_in=%d,out=%d",src,dest,val,move_in,out);
            #100 $finish;
       end
endmodule 