module testbench;
reg [15:0] in1;
reg rst1,rst2,rst3,rst4;
reg clk=0;
always begin #4 clk=~clk; end
reg rst;
wire [15:0] y;
top_module  DUT(in1,rst1,rst2,rst3,rst4,clk,y);
initial
begin
    #0 in1=769;rst2=1;
    #100 rst2=0;
    #100 rst1=1;in1=253;
    #100 rst1=0;
    #100 rst3=0;rst4=1;
    #100 $monitor("y=%d",y);
    #100 rst4=0;rst3=1;
    #100 $monitor("y=%d",y);
    $finish;
end
endmodule