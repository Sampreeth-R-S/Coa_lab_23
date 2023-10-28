module testbench();
    reg [15:0] in,button1=0,button2=0,button3=0,button4=0,button5=0;
    reg clk = 0;
    always begin #5 clk=~clk; end
    wire [15:0] out;
    top_module M1(in,button1,button2,button3,button4,button5, out,clk);
    initial
    begin
        $monitor("in=%d,out=%d",in,out);
        #0 in=0;
        #10 button2=1;
        #10 button2=0;
        #10 in=4464;
        #10 button2=1;
        #10 button2=0;
        #10 in=1;
        #10 button2=1;
        #10 button2=0;
        #10 button2=1;
        #10 button2=0;
        #10 in =1;
        #10 button2=1;
        #10 button2=0;
        #10 in=14464;
        #10 button2=1;
        #10 button2=0;
        #10 in=1;
        #10 button2=1;
        #10 button2=0;
        #10 button2=1;
        #10 button2=0;
        #10 in=16'b0101001000000001;
        #10 button1=1;
        #10 button1=0;
        #10 in=2;
        #10 button3=1;
        #10 button3=0;
        #10 button3=1;
        #10 button3=0;
        #10 button3=1;
        #10 button3=0;
        #1000 $finish;
     end

endmodule