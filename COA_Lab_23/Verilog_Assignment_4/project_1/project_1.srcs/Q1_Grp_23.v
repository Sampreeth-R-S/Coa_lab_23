//module cla(in1,in2,carry_out,enable,clock,sum_output);//Carry Look Adder
//    input [7:0] in1;
//    input [7:0] in2;
//    output carry_out;
//    output [7:0] sum_output;
//    input enable;
//    input clock;
//    //output [7:0] sum_output;
//    reg [7:0] sum_output;
//    reg carry_out;
//    wire [7:0] p;//Carry propagate
//    wire [7:0] g;//Carry Generate
//    assign p=in1^in2;
//    assign g=in1&in2;
//    wire [8:0] c;//Carry
//    assign c[0]=0;//Setting the value of each carry bit
//    assign c[1]=g[0];
//        assign c[2]=g[1]|p[1]&g[0];
//        assign c[3]=g[2]|p[2]&(g[1]|p[1]&g[0]);
//        assign c[4]=g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]));
//        assign c[5]=g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0])));
//        assign c[6]=g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]))));
//        assign c[7]=g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0])))));
//        assign c[8]=g[7]|p[7]&(g[6]|p[6]&(g[5]|p[5]&(g[4]|p[4]&(g[3]|p[3]&(g[2]|p[2]&(g[1]|p[1]&g[0]))))));
//    always @(posedge clock)
//    begin
//        if(enable)//Set the output to the sum of in1 and in2(=p^carry) if enable is set
//        begin
//            sum_output<=p^c[7:0];
//            //$monitor("c=%d",in2);
//            //$monitor("c=%d",in2);
//            carry_out<=c[8];
//        end
//        else 
//            sum_output=8'bz;
//    end
    
//endmodule 
//module decoder(out,state);
//    input [15:0] out;
//    output [1:0]state;
//    reg [1:0] state;
//    wire b1;
//    assign b1=out[0];
//    wire b2;
//    assign b2=out[1];
//    always @*
//    begin
//        if(b1==b2)
//            state=2'b00;
//        else if(b1==1)
//            state=2'b10;
//        else
//            state=2'b01;
//     end
//endmodule
////module  complementor (out, X, clock);//Complementor for subtract
////    input [7:0] X;
////    input  clock;
////    output [7:0] out;      
////    reg [7:0] out;
////    always @(posedge clock)//return 2's complement of the input
////        out=~X+1;
          
////endmodule

////module subtractor(in1,in2,enable,clock,out);//Subtractor module
////    input [7:0] in1;
////    input [7:0] in2;
////    input enable;
////    output [7:0]out;
////    input clock;
////    //output [7:0] diff_output;
////    //wire [7:0] diff_output;
////    wire [7:0] temp;
////    wire carry_out;
////    //assign in1=diff_output;
////    complementor C1 (temp,in2,clock);//Temp stores 2's complement
////    cla A1 (in1,temp,carry_out,enable,clock,out);//Add 2's complement of in2 with the in1
////endmodule    
////module right_shift(in1,enable,clock,out);//Right shift operator
////    input [15:0]in1;
////    input enable;
////    input clock;
////    output out;
////    //output [15:0] out;
////    reg [15:0] out;
////    always @(posedge clock)
////        begin
////            if(enable)//Right shift if enable
////                out={in1[15],in1>>1};
////            else
////                out = 15'bz;
////        end
////     //assign in1=out;
////endmodule 

//module top_module(multiplier,multiplicand,out,clock);
//    input [7:0] multiplier;
//    input [7:0] multiplicand;
//    input clock;
//    output [15:0] out;
//    reg [16:0] out;
//    reg start=0;
//    reg [7:0] A=0;
//    reg Q=0;
//    reg set=1;
//    reg [4:0]counter;
//    wire [1:0] state;
//    reg shiftenable;
//    reg sumenable;
//    wire carry_out;
//    reg subenable;
//    wire [16:0] temp;
//    decoder  M1(out,state);
//    //cla(in1,in2,carry_out,enable,clock);
//    cla M2(multiplicand,out[16:9],carry_out,sumenable,clock,temp[16:9]);
//    subtractor M3(out[16:9],multiplicand,subenable,clock,temp[16:9]);
//    right_shift M4(out,shiftenable,clock,temp);
//    always @(posedge clock)
//    begin
//        if(start==0)
//        begin
//            start=1;
//            out={multiplier,1'b0};
//            counter=8;
//            $monitor("out2=%d,start=%d",out,start);
//        end
//        else
//        begin
//            if(counter)
//            begin
//                if(set)
//                    begin
                    
//                    shiftenable=0;
//                    case (state)
//                    2'b01: sumenable=1;
//                    2'b10: subenable=1;
//                    default: set=0;
//                    endcase
//                    $monitor("out=%d,temp=%d",out,temp);
//                    set=0;
//                    end
//                else 
//                    begin
//                    sumenable=0;
//                    subenable=0;
//                    shiftenable=1;
//                    set=1;
//                    counter=counter-1;
//                    $monitor("out2=%d,start=%d,temp=%d",out,start,temp);
//                    end
//                 //$monitor("out2=%d,state=%d",out,state);
//              end
//          end
//      end
//endmodule
          
module right_shift(out1,m1,Q2,shiftenable,clock,temp2,temp3,temp1);
input Q2;
input [7:0]out1,m1;
input clock,shiftenable;
output temp1;
output [7:0] temp2,temp3;
reg temp1;
reg [7:0] temp2,temp3;

//always @(posedge clock)
always @*
begin
if(shiftenable)
    begin
    temp1=m1[0];
    temp3={out1[0],m1>>1};
    temp2={out1[7],Q2>>1};
    $monitor("temp1=%d,q1=%d",temp2,m1);
    end

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
    always @*
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
    assign in1=sum_output;
endmodule 

module  complementor (out, X, clock);//Complementor for subtract
    input [7:0] X;
    input  clock;
    output [7:0] out;      
    reg [7:0] out;
    always @*//return 2's complement of the input
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
    cla A1 (in1,temp,carry_out,enable,clock);//Add 2's complement of in2 with the in1
endmodule 
module top_module(m1,m2,out1,out2,clock);
    input [7:0] m1,m2;
    input clock;
    output [7:0] out1,out2;
    reg [7:0] out1,out2;
    reg Q2=0;
    reg start=0;
    reg set=0;
    wire carry_out;
    reg [4:0] counter=8;
    reg sumenable,difenable,shiftenable;
   
    wire temp1;
    wire [7:0] temp2,temp3;
    cla M1(out1,m2,carry_out,sumenable,clock,temp2);
    subtractor M2(out1,m2,difenable,clock,temp2);
    right_shift M3(out1,out2,Q2,shiftenable,clock,temp2,temp3,temp1);
    always @(posedge clock)
     begin
        if(start==0)
            begin
            start=1;
            out1=0;
            out2=m1;
            end
        else 
        begin
            if(counter)
            begin
                if(set)
                begin
                    if(Q2==out2[0])
                        set=0;
                    else if(Q2==1)
                        begin
                            sumenable=1;
                            set=0;
                            out1=temp2;
                        end
                     else
                        begin
                            difenable=1;
                            set=0;
                            out1=temp2;
                         end
                   end
                   else
                   begin
                        shiftenable=1;
                        set=1;
                        counter=counter-1;
                        $monitor("out1=%d,oput2=%d,counter=%d",out1,out2,counter);
                        out1=temp2;
                        out2=temp3;
                        Q2=temp1;
                   end
               end
           end
       end
endmodule
               