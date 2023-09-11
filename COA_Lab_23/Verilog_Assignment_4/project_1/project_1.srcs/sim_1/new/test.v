module testbench;
reg [7:0] multiplier,multiplicand;
reg clk;
     initial
    begin
        clk=0;  //Initialise the clock
        forever #5 clk=~clk;  //Toggle the clock every 5ns
    end
wire [7:0] out1,out2;
top_module M1(multiplier,multiplicand,out1,out2,clk);
initial
begin
    #0 multiplier=100;multiplicand=14;
    #2000 $monitor("m1=%d,m2=%d,out1=%d,out2=%d",multiplier,multiplicand,out1,out2);
end
endmodule