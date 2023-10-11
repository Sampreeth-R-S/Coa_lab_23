module testbench;
     reg clk;
     initial
    begin
        clk=0;  //Initialise the clock
        forever #5 clk=~clk;  //Toggle the clock every 5ns
    end
    reg [16:0] in,out;
    reg button1,button2,button3;
    reg load1,load2,load3,load4,load5;
    ALU DUT(in,out,button1,button2,button3);
endmodule
