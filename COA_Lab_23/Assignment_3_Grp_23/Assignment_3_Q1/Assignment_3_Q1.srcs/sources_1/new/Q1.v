module select(in1,in2,enable,out,clock);  //Module to select the input
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    reg [7:0] out;
    always @(posedge clock)  
        begin
            if(enable)  //If enable, select the input to output, else high impdeance
                out=in1;
            else
                out = 8'bz;
        end
endmodule
module left_shift(in1,in2,enable,out,clock);  //Left shift operator
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    wire [7:0] out;
    wire carry_out;
    cla M1(in1,in1,carry_out,enable,clock,out);//Left shift by 1(return 2*in1)
    /*always @(posedge clock)
        begin
            if(enable)
                out=temp;
            else
                out = 8'bz;
        end*/
endmodule 
module right_shift(in1,in2,enable,out,clock);//Right shift operator
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    reg [7:0] out;
    always @(posedge clock)
        begin
            if(enable)//Right shift if enable
                out=in1>>1;
            else
                out = 8'bz;
        end
endmodule
module and_op(in1,in2,enable,out,clock);  //And operator
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    reg [7:0] out;
    always @(posedge clock)
        begin
            if(enable)//Return and if enable is set
                out=in1&in2;
            else
                out = 8'bz;
        end
endmodule 
module or_op(in1,in2,enable,out,clock);//Or operator
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    reg [7:0] out;
    always @(posedge clock)
        begin
            if(enable)  //return the or if enable is set
                out=in1|in2;
            else
                out = 8'bz;
        end
endmodule 
module not_op(in1,in2,enable,out,clock);  //Not operator
    input [7:0]in1,in2;
    input enable;
    input clock;
    output [7:0] out;
    reg [7:0] out;
    always @(posedge clock)
        begin
            if(enable)//Return not of in1 if enable is set
                out=~in1;
            else
                out = 8'bz;
        end
endmodule

module cla(in1,in2,carry_out,enable,clock,sum_output);//Carry Look Adder
    input [7:0] in1;
    input [7:0] in2;
    output carry_out;
    input enable;
    input clock;
    output [7:0] sum_output;
    reg [7:0] sum_output;
    reg carry_out;
    wire [7:0] p;//Carry propagate
    wire [7:0] g;//Carry Generate
    assign p=in1^in2;
    assign g=in1&in2;
    wire [8:0] c;//Carry
    assign c[0]=0;//Setting the value of each carry bit
    assign c[1]=g[0];
        assign c[2]=g[1]|p[1]&g[0];
        assign c[3]=g[2]|p[2]&(g[1]|p[1]&g[0]);
        assign c[4]=g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]));
        assign c[5]=g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0])));
        assign c[6]=g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]))));
        assign c[7]=g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0])))));
        assign c[8]=g[7]|p[7]&(g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]))))));
    always @(posedge clock)
    begin
        if(enable)//Set the output to the sum of in1 and in2(=p^carry) if enable is set
        begin
            sum_output<=p^c[7:0];
            //$monitor("c=%d",in2);
            //$monitor("c=%d",in2);
            carry_out<=c[8];
        end
        else 
            sum_output=8'bz;
    end
endmodule 

module  complementor (out, X, clock);//Complementor for subtract
    input [7:0] X;
    input  clock;
    output [7:0] out;      
    reg [7:0] out;
    always @(posedge clock)//return 2's complement of the input
        out=~X+1;
          
endmodule

module subtractor(in1,in2,enable,clock,diff_output);//Subtractor module
    input [7:0] in1;
    input [7:0] in2;
    input enable;
    input clock;
    output [7:0] diff_output;
    wire [7:0] diff_output;
    wire [7:0] temp;
    wire carry_out;
    complementor C1 (temp,in2,clock);//Temp stores 2's complement
    cla A1 (in1,temp,carry_out,enable,clock,diff_output);//Add 2's complement of in2 with the in1
endmodule    
 
 
module my_decoder(inp,outp);//Decoder module
    input [2:0] inp;//Select line
    output [7:0] outp;//Enable line
    reg [7:0] outp;
    always @(inp)
    begin
        case (inp)//Switch case to select appropriate enable line
            3'b000: outp=8'b00000001;
            3'b001: outp=8'b00000010;
            3'b010: outp=8'b00000100;
            3'b011: outp=8'b00001000;
            3'b100: outp=8'b00010000;
            3'b101: outp=8'b00100000;
            3'b110: outp=8'b01000000;
            3'b111: outp=8'b10000000;
    endcase
    end
endmodule

module top_module(in1,in2,sel,out,clock);//Top module
    input [7:0]in1,in2;
    output [7:0] out;
    input [2:0] sel;
    input clock;
    wire [7:0] enable;
    wire carry_out;
    my_decoder M(sel,enable);//Decoder to the select input
    cla M1(in1,in2,carry_out,enable[0],clock,out);//Component modules with appropriate select lines
    subtractor M2(in1,in2,enable[1],clock,out);
    select M3(in1,in2,enable[2],out,clock);
    left_shift M4(in1,in2,enable[3],out,clock);
    right_shift M5(in1,in2,enable[4],out,clock);
    and_op M6(in1,in2,enable[5],out,clock);
    not_op M7(in1,in2,enable[6],out,clock);
    or_op M8(in1,in2,enable[7],out,clock);
endmodule
