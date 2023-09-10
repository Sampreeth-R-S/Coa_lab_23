module register(src,dest,loadval,move,out,clk);
    input [2:0] src;
    input [2:0] dest;
    input [15:0] loadval;
    input [7:0] move;
    input clk;
    output [15:0] out;
    reg [15:0] out;
    reg [15:0] registers [7:0];
    parameter high=16'bzzzzzzzzzzzzzzzz;
    always @(posedge clk)
    begin
        if(move==0)
            registers[dest]=loadval;
        if(move)
        begin
            out=registers[src];
            $monitor("Out=%d",out);
            registers[dest]=out;
        end
        else 
            out=high;
     end
endmodule

module registerfile(src_register,dst_register,move_in,inp,out,clk);
    input [2:0] src_register;
    input [2:0] dst_register;
    input move_in;
    input [15:0] inp;
    output [15:0] out;
    input clk;
    reg [15:0] temp;
    register R (src_register, dst_register,inp,move_in,out,clk);
    
endmodule
            
            