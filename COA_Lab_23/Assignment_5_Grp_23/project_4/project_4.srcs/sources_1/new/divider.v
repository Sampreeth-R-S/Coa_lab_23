module cla(in1,in2,carry_in,carry_out,sum_output);//Carry Look Adder
    input [7:0] in1;
    input [7:0] in2;
    output carry_out;
    //input enable;
    //input clock;
    input carry_in;
    output [7:0] sum_output;
    wire [7:0] sum_output;
    wire carry_out;
    wire [7:0] p;//Carry propagate
    wire [7:0] g;//Carry Generate
    assign p=in1^in2;
    assign g=in1&in2;
    wire [8:0] c;//Carry
    assign c[0]=carry_in;//Setting the value of each carry bit
    assign c[1]=g[0]|p[0]&carry_in;
        assign c[2]=g[1]|p[1]&(g[0]|p[0]&carry_in);
        assign c[3]=g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in));
        assign c[4]=g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in)));
        assign c[5]=g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in))));
        assign c[6]=g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in)))));
        assign c[7]=g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in))))));
        assign c[8]=g[7]|p[7]&(g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&(g[0]|p[0]&carry_in)))))));
    assign sum_output=p^c[7:0];
    assign carry_out=c[8];
endmodule 
module large_adder(input [31:0] in1,input [31:0] in2,output wire [31:0] out);
    //wire [31:0] out;
    wire [5:0]carry;
    assign carry[0]=0;
    cla C1(in1[7:0],in2[7:0],carry[0],carry[1],out[7:0]);
    cla C2(in1[15:8],in2[15:8],carry[1],carry[2],out[15:8]);
    cla C3(in1[23:16],in2[23:16],carry[2],carry[3],out[23:16]);
    cla C4(in1[31:24],in2[31:24],carry[3],carry[4],out[31:24]);
endmodule
module  complementor (out, X);//Complementor for subtract
    input [31:0] X;
    //input  clock;
    wire [31:0] x_temp;
    assign x_temp=~X;
    output [31:0] out;      
    wire [31:0] out;
    //assign out=~X+1;
    wire [5:0]carry;
    assign carry[0]=1;
    wire [7:0]zero;
    assign zero=0;
    cla Cp1(x_temp[7:0],zero,carry[0],carry[1],out[7:0]);
    cla Cp2(x_temp[15:8],zero,carry[1],carry[2],out[15:8]);
    cla Cp3(x_temp[23:16],zero,carry[2],carry[3],out[23:16]);
    cla Cp4(x_temp[31:24],zero,carry[3],carry[4],out[31:24]);     
endmodule

module right_shift(input [31:0] x,output wire [31:0]y);
    assign y=x>>8;
endmodule

module top_module(in1,rst1,rst2,rst3,rst4,clk,y);
    wire [31:0] x;
    input [15:0] in1;
    output [15:0] y;
    wire [31:0] x_complement;
    wire [31:0] x_temp2;
    wire [31:0]y_temp[2:0];
    wire [31:0] sum_temp[2:0];
    wire [31:0]one;
    //wire [31:0] y_temp;
    reg[15:0] y;
    input rst1,rst2,clk,rst3,rst4;
    reg [31:0]x_temp;
    assign x=x_temp;
    always @(posedge clk)
    begin
        if(rst1==1)
        begin
            x_temp[31:16]=in1;
            //$monitor("x=%d,in1=%d",y,in1);
        end
        else if(rst2==1)
        begin
            x_temp[15:0]=in1;
            //$monitor("x=%d",x);
        end
        else if(rst3==1)
        begin
            y=y_temp[2][15:0];
        end
        else if(rst4==1)
        begin
            y=y_temp[2][31:16];
        end
    end
    
    assign one=1;
    large_adder C1(x,one,x_temp2);
    wire [31:0] z;
    right_shift R1(x_temp2,z);
    
    large_adder C2(z,x_temp2,sum_temp[0]);
    right_shift R2(sum_temp[0],y_temp[0]);
    large_adder C3(x_temp2,y_temp[0],sum_temp[1]);
    right_shift R3(sum_temp[1],y_temp[1]);
    large_adder C4(x_temp2,y_temp[1],sum_temp[2]);
    right_shift R4(sum_temp[2],y_temp[2]);
endmodule