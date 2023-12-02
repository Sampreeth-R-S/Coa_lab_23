`timescale 10ns/1ns
module testbench;
    reg [7:0]a;
    reg [7:0] b;
    reg clk;
    wire [7:0] out;
    gcd DUT(a,b,clk,out);
    initial
    begin
        clk=0;
    end
    initial
    begin
        $monitor($time,"A=%d,B=%d,output=%d",a,b,out);
        #0 a=48;b=18;
        #10000 $finish;
    end
    always #5 clk=~clk;
    
endmodule
      
       