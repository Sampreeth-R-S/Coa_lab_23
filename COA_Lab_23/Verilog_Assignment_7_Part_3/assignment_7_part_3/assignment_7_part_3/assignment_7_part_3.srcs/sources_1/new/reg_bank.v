module left_shift(in1,in2,enable,out);  //Left shift operator
    input [31:0]in1,in2;
    input enable;
    output [31:0] out;
    wire [31:0] out;
    assign out=enable?((in2[0]==1'b1)?{in1[30:0],1'b0}:in1):32'bz;//Left shift by 1
    /*always @(posedge clock)
        begin
            if(enable)
                out=temp;
            else
                out = 8'bz;
        end*/
endmodule 

module right_shift_logical(in1,in2,enable,out);//Right shift operator
    input [31:0]in1,in2;
    input enable;
    //input clock;
    output [31:0] out;
    wire [31:0] out;
    wire temp;
    assign temp=0;
    assign out=enable?((in2[0]==1)?{temp,in1[31:1]}:in1):32'bz;//Right shift by 1
endmodule

module right_shift_arithmetic(in1,in2,enable,out);//Right shift operator
    input [31:0]in1,in2;
    input enable;
    //input clock;
    output [31:0] out;
    wire [31:0] out;
    wire temp;
    assign temp=in1[31];
    assign out=enable?((in2[0]==1)?{in1[31],in1[31:1]}:in1):32'bz;//Right shift by 1
endmodule

module and_op(in1,in2,enable,out);  //And operator
    input [31:0]in1,in2;
    input enable;
    //input clock;
    output [31:0] out;
    wire [31:0] out;
    assign out=enable?in1&in2:32'bz;//Return and of in1 and in2 if enable is set
endmodule 

module or_op(in1,in2,enable,out);//Or operator
    input [31:0]in1,in2;
    input enable;
   // input clock;
    output [31:0] out;
    wire [31:0] out;
    assign out=enable?in1|in2:32'bz;//Return or of in1 and in2 if enable is set
endmodule 

module not_op(in1,in2,enable,out);  //Not operator
    input [31:0]in1,in2;
    input enable;
    //input clock;
    output [31:0] out;
    wire [31:0] out;
    assign out=enable?~in1:32'bz;//Return not of in1 if enable is set
endmodule

module cla(in1,in2,carry_in,carry_out,enable,sum_output);//Carry Look Adder
    input [7:0] in1;
    input [7:0] in2;
    output carry_out;
    input enable;
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
    assign sum_output=enable?p^c[7:0]:8'bz;
    assign carry_out=enable?c[8]:1'bz;
endmodule 

module large_adder(input [31:0] in1,input [31:0] in2,output wire [31:0] out,input carry_in,input enable);
    //wire [31:0] out;
    wire [5:0]carry;
    assign carry[0]=0;
    cla C1(in1[7:0],in2[7:0],carry_in,carry[1],enable,out[7:0]);
    cla C2(in1[15:8],in2[15:8],carry[1],carry[2],enable,out[15:8]);
    cla C3(in1[23:16],in2[23:16],carry[2],carry[3],enable,out[23:16]);
    cla C4(in1[31:24],in2[31:24],carry[3],carry[4],enable,out[31:24]);
endmodule

module  complementor (out, X);//Complementor
    input [31:0] X;
    output [31:0] out;      
    wire [31:0] out;
    wire [31:0] complement;
    assign complement = ~X;
    //wire [31:0] temp;
    wire [31:0] zero;
    assign zero = 32'b0;
    wire carry_in;
    assign carry_in = 1'b1;
    wire enable;
    assign enable = 1'b1;
    large_adder A1 (complement,zero,out,carry_in,enable);      
endmodule

module subtractor(in1,in2,enable,diff_output);//Subtractor module
    input [31:0] in1;
    input [31:0] in2;
    input enable;
    //input clock;
    output [31:0] diff_output;
    wire [31:0] diff_output;
    wire [31:0] temp;
    wire carry_out;
    wire carry_in;
    assign carry_in=1'b1;
    assign temp=~in2;
    large_adder A1 (in1,temp,diff_output,carry_in,enable);//Adder to add in1 and 2's complement of in2
endmodule    

module xor_op(in1,in2,enable,out);//Xor operator
    input [31:0]in1,in2;
    input enable;
    output [31:0] out;
    wire [31:0] out;
    assign out=enable?in1^in2:32'bz;//Return xor of in1 and in2 if enable is set
endmodule

module my_decoder(inp,outp);//Decoder module
    input [3:0] inp;//Select line
    output [8:0] outp;//Enable line
    reg [8:0] outp;
    always @(inp)
    begin
        case (inp)//Switch case to select appropriate enable line
            4'b0000: outp=9'b000000001;
            4'b0001: outp=9'b000000010;
            4'b0010: outp=9'b000000100;
            4'b0011: outp=9'b000001000;
            4'b0100: outp=9'b000010000;
            4'b0101: outp=9'b000100000;
            4'b0110: outp=9'b001000000;
            4'b0111: outp=9'b010000000;
            4'b1000: outp=9'b100000000;
    endcase
    end
endmodule

module ALU(in1,in2,sel,out);//Top module
    input [31:0]in1,in2;
    output [31:0] out;
    input [3:0] sel;
    //input clock;
    wire [8:0] enable;
    wire carry_out;
    wire carry_in;
    assign carry_in=1'b0;
    my_decoder M(sel,enable);//Decoder to the select input
    large_adder M1(in1,in2,out,carry_in,enable[0]);//Component modules with appropriate select lines
    subtractor M2(in1,in2,enable[1],out);
    //select M3(in1,in2,enable[2],out);
    right_shift_arithmetic M3(in1,in2,enable[2],out);
    left_shift M4(in1,in2,enable[3],out);
    right_shift_logical M5(in1,in2,enable[4],out);
    and_op M6(in1,in2,enable[5],out);
    not_op M7(in1,in2,enable[6],out);
    or_op M8(in1,in2,enable[7],out);
    xor_op M9(in1,in2,enable[8],out);
endmodule

module reg_bank(read_addr1, read_addr2, write_addr, write_data, write_enable, read_data1, read_data2, clk);
    input [3:0] read_addr1, read_addr2, write_addr;
    input [31:0] write_data;
    input write_enable;
    output [31:0] read_data1, read_data2;
    wire [31:0] read_data1, read_data2;
    reg [31:0] reg_bank [0:15];
    reg [31:0] regA, regB;
    input clk;
    always @(posedge clk)
    begin
        if(write_enable)
            reg_bank[write_addr] <= write_data;
    end
    assign read_data1 = reg_bank[read_addr1];
    assign read_data2 = reg_bank[read_addr2];
endmodule

module pos_edge_det (input sig, // Input signal for which positive edge has to be detected
                     input clk, // Input signal for clock
                     output pe); // Output signal that gives a pulse when a positive edge occurs

   reg sig_dly; // Internal signal to store the delayed version of signal

   // This always block ensures that sig_dly is exactly 1 clock behind sig
   always @ (posedge clk) begin
      sig_dly <= sig;
   end
   // Combinational logic where sig is AND with delayed, inverted version of sig
   // Assign statement assigns the evaluated expression in the RHS to the internal net pe
   assign pe = sig & ~sig_dly;
endmodule

module top_module(input [15:0] in, input button1, input button2, input button3, input button4, input button5, output reg[15:0] out, input clk);
    reg [31:0] aluin1, aluin2;
    wire [31:0] aluout;
    reg [31:0] regA,regB;
    reg [3:0] read_addr1, read_addr2, write_addr;
    reg write_enable = 0;
    reg [31:0] regbankin;
    wire [31:0] regout1,regout2;
    reg_bank R1(read_addr1,read_addr2,write_addr, regbankin, write_enable, regout1, regout2, clk);
    reg [3:0] sel;
    ALU M1(aluin1, aluin2, sel, aluout);
    wire p1,p2,p3;
    reg [2:0] counter = 0;
    pos_edge_det m1(button1,clk,p1);
    pos_edge_det m2(button2, clk, p2);
    pos_edge_det m3(button3, clk, p3);
    wire [31:0] outp;
    reg [3:0] addrtemp;
    reg [31:0] regtemp;
    reg [2:0] counter2=0;
    reg [2:0] counter3=0;
    always @(posedge clk)
    begin
        if(p1)
        begin
            read_addr1 = in[3:0];
            read_addr2 = in[7:4];
            write_addr = in[11:8];
            sel = in[15:12];
            counter3=1;
            out = in;
        end
        else if(counter3==1)
        begin
            aluin1=regout1;
            aluin2=regout2;
            counter3=2;
        end
        else if(counter3==2)
        begin
            regbankin = aluout;
            write_enable=1;
            out = regbankin[15:0];
            counter3=3;
        end
        else if(counter3==3)
        begin
            write_enable=0;
            counter3=0;
        end
        if(p2)
        begin
            write_enable = 0;
            if(counter==0)
            begin
                addrtemp = in[3:0];
                counter = counter+1;
                out = {12'b0,addrtemp};
            end
            else if(counter == 1)
            begin
                regtemp[15:0]=in;
                out = regtemp[15:0];
                counter = counter + 1;
            end
            else if(counter == 2)
            begin
                regtemp[31:16]=in;
                counter=counter+1;
                out = regtemp[31:16];
                write_addr=addrtemp;
                regbankin=regtemp;
                write_enable=1;
            end
            else if(counter == 3)
            begin
                counter=0;
                write_enable=0;
                out = 0;
            end
        end
        if(p3)
        begin
            write_enable=0;
            read_addr1=in[3:0];
            
            if(counter2==0)
            begin
                counter2=1;
                write_enable=0;
                read_addr1=in[3:0];
            end
            else if(counter2==1)
            begin
                $display("readaddr=%d,readval=%d,in=%d\n",read_addr1,regout1,in);
                counter2=2;
                out=regout1[15:0];
            end
            else if(counter2==2)
            begin
                counter2=0;
                out=regout1[31:16];
            end
        end
    end
                
endmodule