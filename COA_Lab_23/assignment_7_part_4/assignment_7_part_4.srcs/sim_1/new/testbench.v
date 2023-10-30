module testbench;
reg clk=0;
always #5 clk=~clk;
 datapath M1 (clk);
 initial
 begin
    #10000 $finish;
 end
endmodule