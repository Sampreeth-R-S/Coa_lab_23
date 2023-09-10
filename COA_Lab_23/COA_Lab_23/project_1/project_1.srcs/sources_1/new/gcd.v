module gcd(a,b,clk,out);
    input [7:0]a;
    input [7:0]b;
    input clk;
    output [7:0] out;
    reg [7:0] out;
    reg [7:0] rega;
    reg [7:0] regb;
    reg set=1'b0;
    
    always @(posedge clk)
    begin 
        if(set==0)
        begin
            rega=a;
            regb=b;
            set=1;
            $monitor("rega=%d, regb=%d",rega,regb);
        end   
        if(set&&rega>regb)
            rega=rega-regb;
        else if(set&&rega<regb)
            regb=regb-rega; 
        else if(set)
            out=rega;
        $monitor("rega=%d, regb=%d",rega,regb);
    end
    
endmodule