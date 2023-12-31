/*module testbench;
reg clk=0;
reg button1=0;
always #5 clk=~clk;
 control_unit M1 (clk,button1);
 initial
 begin
    #10000 $finish;
 end
endmodule
module blk_mem_gen_0 (
    input wire clka,    // input wire clka
    input wire ena,      // input wire ena
    input wire wea,      // input wire [0 : 0] wea
    input wire[9:0] addra,  // input wire [9 : 0] addra
    input wire[31:0] dina,    // input wire [31 : 0] dina
    output wire [31:0] douta  // output wire [31 : 0] douta
    );
    reg [31:0] reg_bank [0:3];
    reg [31:0] regA, regB;
    //input clka;
    initial
    begin
        reg_bank[0] = 32'b01001100000000000000000000000010;
        reg_bank[1] = 32'b00000100000000010000000000000001;
        reg_bank[2] = 32'b11111000000000000000000000000000;
        reg_bank[3] = 32'b11111000000000000000000000000000;
    end
    always @(posedge clka)
    begin
        if(wea)
            reg_bank[addra] <= dina;
    end
    assign douta = reg_bank[addra];

endmodule*/

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
            begin
                //$display("%d=write_data",write_data);
                //$display("%d=write_addr",write_addr);
                reg_bank[write_addr] <= write_data;
            end
        //$display("%d=reg_bank[1]",reg_bank[1]);
        //$display("%d=reg_bank[0]",reg_bank[0]);
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

module two_to_one_mux(in1, in2, sel, out);
    input [31:0] in1;
    input[31:0] in2;
    input sel;
    output wire[31:0] out;
    assign out = sel?in2:in1;
endmodule
module two_to_one_mux_small(in1, in2, sel, out);
    input [3:0] in1;
    input [3:0] in2;
    input sel;
    output wire[3:0] out;
    assign out = sel?in2:in1;
endmodule
module three_to_one_mux(
    input [31:0] in1, in2, in3,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(in1 or in2 or in3 or sel)
    begin
        case(sel)
        0: out=in1;
        1: out=in2;
        2: out=in3;
        3: out=0;
        endcase
    end
endmodule

module three_to_one_mux_small(
    input [9:0] in1, in2, in3,
    input [1:0] sel,
    output reg [9:0] out
);
    always @(in1 or in2 or in3 or sel)
    begin
        case(sel)
        0: out=in1;
        1: out=in2;
        2: out=in3;
        3: out=0;
        endcase
    end
endmodule

module four_to_one_mux(
    input [31:0] in1, in2, in3,in4,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(in1 or in2 or in3 or sel or in4)
    begin
        case(sel)
        0: out=in1;
        1: out=in2;
        2: out=in3;
        3: out=in4;
        endcase
    end
endmodule

module four_to_one_mux_small(
    input [9:0] in1, in2, in3,in4,
    input [1:0] sel,
    output reg [9:0] out
);
    always @(in1 or in2 or in3 or sel or in4)
    begin
        case(sel)
        0: out=in1;
        1: out=in2;
        2: out=in3;
        3: out=in4;
        endcase
    end
endmodule

module datapath(
    input wire clk,
    input wire ena,
    input wire wea,
    //input wire [9:0] addra,
    //input wire [31:0] dina,
    output wire [31:0] douta,
    input wire [3:0] read_addr1,read_addr2, //write_addr,
    //input wire [31:0] write_data,
    input wire write_enable,
    output wire [31:0] read_data1, read_data2,
    //input wire[31:0] in1, in2,
    input wire [3:0] sel,
  output wire [31:0] out,
    input wire [31:0] pc,
    output wire [31:0] stackpointer,
    input wire [1:0] alusrc_1,alusrc_2,memsrc,
    input wire [31:0] instruction,
    input wire reg_addr_src,
    input wire [1:0] reg_write_src,
    input wire [1:0] mem_addr_src,
    input wire stack_addr,
    input wire update_sp,
    input [31:0] immediate

);
    wire [31:0] dina;
    wire [31:0] in1,in2;
    wire [31:0] write_data;
    wire [3:0] write_addr;
    reg [31:0] temp=1;
    wire [9:0] addra;
    //wire [31:0] stackpointer;
    blk_mem_gen_0 RAM (
    .clka(clk),    // input wire clka
    .ena(ena),      // input wire ena
    .wea(wea),      // input wire [0 : 0] wea
    .addra(addra),  // input wire [9 : 0] addra
    .dina(dina),    // input wire [31 : 0] dina
    .douta(douta)  // output wire [31 : 0] douta
    );
    reg_bank M1(read_addr1, read_addr2, write_addr, write_data, write_enable, read_data1, read_data2, clk);
    wire [31:0] stack_temp;
    three_to_one_mux mux1(read_data1, stackpointer, pc, alusrc_1, in1);
    three_to_one_mux mux2(read_data2, immediate, temp, alusrc_2, in2);
    four_to_one_mux mux3(read_data1,read_data2,pc,stackpointer,memsrc,dina);
    two_to_one_mux_small mux4(instruction[14:11],instruction[19:16],reg_addr_src,write_addr);
    four_to_one_mux mux5(out,read_data1,douta,immediate, reg_write_src, write_data);
    three_to_one_mux_small mux6(out[9:0],stackpointer[9:0],pc[9:0],mem_addr_src,addra);
    two_to_one_mux mux7 (out,douta,stack_addr,stack_temp);
    ALU M2 (in1,in2,sel,out);
    assign stackpointer = update_sp?stack_temp:stackpointer;
    //always @(posedge clk)
        //$display("%d=immediate",immediate);
endmodule
module control_unit(clk, button1);
    input clk;
    input button1;
    reg ena=0,wea=0;
    reg [9:0] addra;
    reg [31:0] dina;
    wire[31:0] douta;
    reg [31:0] counter=0;
    reg[31:0] instruction; 
    reg halt=0;
    reg [31:0] write_data;
    wire[31:0] read_data1, read_data2;
    reg[3:0] read_addr1, read_addr2, write_addr;
    reg [31:0] in1,in2;
    reg [5:0] opcode;
    reg[5:0] func;
    reg [31:0] immediate=0;
    wire [31:0] stackpointer;
    wire[31:0] out;
    wire p1;
    reg [3:0] sel;
    reg write_enable=0;
    reg [31:0] pc=0;
    reg [1:0] alusrc_1, alusrc_2, memsrc, reg_write_src, mem_addr_src;
    reg reg_addr_src,stack_addr, update_sp;
    datapath M10 (clk,ena,wea,douta,read_addr1, read_addr2, write_enable, read_data1, read_data2, sel, out, pc, stackpointer, alusrc_1,alusrc_2,memsrc,instruction, reg_addr_src, reg_write_src,mem_addr_src, stack_addr, update_sp,immediate);
    pos_edge_det P1(button1,clk,p1);
    
    
    always @(posedge clk)
    begin
        ////$display("%d=pc",pc);
        if(halt==1)
        begin   
            if(p1)
            begin
                halt = 0;
                pc = pc + 1;
            end
        end
        else if(counter==0)
        begin
            //addra=pc[9:0];
            mem_addr_src=2;
            ena=1;
            wea=0;
            counter=1;
        end
        else if(counter==1)
        begin
            counter=2;
        end
        else if(counter==2)
        begin
            counter=3;
            //$display("%d=instruction",douta[31:26]);
            //pc=pc+1;
            instruction=douta;
            read_addr1=instruction[24:21];
            read_addr2=instruction[19:16];
            opcode=instruction[31:26];
            func=instruction[5:0];
            immediate[31:0] <= { {16{instruction[15]}}, instruction[15:0] };
            if(opcode==62)
            begin
                halt=1;
            end
        end
        else if(counter==3)
        begin
            //ena=0;
            sel=0; 
            if(opcode==0)
            begin
                if(func<9)
                begin
                    sel=func;
                    //in1=read_data1;
                    alusrc_1 = 0;
                    //in2=read_data2;
                    alusrc_2 = 0;
                end
                if(func==11)
                begin
                    sel=1;
                    //in1=stackpointer;
                    alusrc_1 = 1;
                    //in2=1;
                    alusrc_2 = 2;
                end
                if(func==12)
                begin
                    sel=0;
                    //in1=stackpointer;
                    alusrc_1 = 1;
                    //in2=1;
                    alusrc_2 = 2;
                end
                if(func==13)
                begin 
                    sel=0;
                    //in1=stackpointer;
                    alusrc_1 = 1;
                    //in2=1;
                    alusrc_2 = 2;
                end
            end
            
            if(opcode==2)
                sel=1;
            else if(opcode==3)
                sel=5;
            else if(opcode==4)
                sel=7;
            else if(opcode==5)
                sel=8;
            else if(opcode==6)
                sel=6;
            else if(opcode==7)
                sel=3;
            else if(opcode==8)
                sel=4;
            else if(opcode==9)
                sel=2;
            if(opcode>=1&&opcode<=9)
                begin
                    //in1=read_data1;
                    alusrc_1 = 0;
                    //in2=immediate;
                    alusrc_2=1;
                end
            if(opcode>9&&opcode<=13)
            begin
                //in1=pc;
                alusrc_1=2;
                //in2=immediate;
                alusrc_2=1;
            end
            if(opcode>=14&&opcode<=17)
            begin
                //in1=read_data1;
                alusrc_1=0;
                //in2=immediate;
                alusrc_2=1;
            end
            if(opcode==18)
            begin
                //in1=stackpointer;
                alusrc_1=1;
                //in2=1;
                alusrc_2=2;
                sel=1;
            end
            counter=4;
        end
        else if(counter==4)
        begin
            pc=pc+1;
            if(opcode==0)
            begin
                if(func==11)
                begin
                    //dina=read_data1;
                    memsrc=0;
                    wea=1;
                    //addra=out;
                    mem_addr_src=0;
                    //stackpointer=out;
                    stack_addr = 0;
                    update_sp = 1;
                end
                else if(func==12||func==13)
                begin
                    //addra=stackpointer;
                    mem_addr_src=1;
                    //stackpointer=out;
                    stack_addr=0;
                    update_sp = 1;
                end
                //pc=pc+1;
            end
            if(opcode==10)
            begin
                pc=out;
            end
            else if(opcode==11)
            begin
                if(read_data1<0)
                    pc=out;
            end
            else if(opcode==12)
            begin
                if(read_data1>0)
                    pc=out;
            end
            else if(opcode==13)
            begin
                if(read_data1==0)
                    pc=out;
            end
            else if(opcode==14||opcode==16)
            begin
                //addra=out;
                mem_addr_src=0;
            end
            else if(opcode==15)
            begin
                //addra=out;
                mem_addr_src=0;
                wea=1;
                //dina=read_data2;
                memsrc=1;
                
            end
            else if(opcode==17)
            begin
                //addra=out;
                mem_addr_src=0;
                wea=1;
                //dina=stackpointer;
                memsrc=3;
            end
            else if(opcode==18)
            begin
                //addra=out;
                mem_addr_src=0;
                //dina=pc;
                memsrc=2;       
                wea=1;
                //stackpointer=out;
                stack_addr=0;
                update_sp=1;
            end
            counter=5;
        end
        else if(counter==5)
        begin
            counter=6;
            update_sp=0;
        end
        else if(counter==6)
        begin
            if(opcode==0)
            begin
                wea=0;
                if(func<=8)
                begin
                    //write_addr=instruction[14:11];
                    reg_addr_src=0;
                    //write_data=out;
                    reg_write_src=0;
                    write_enable=1;
                end
                if(func==10)
                begin
                    //write_addr=instruction[14:11];
                    reg_addr_src=0;
                    //write_data=read_data1;
                    reg_write_src=1;
                    write_enable=1;
                end
                if(func==12)
                begin
                    //write_addr=instruction[14:11];
                    reg_addr_src=0;
                    //write_data=douta;
                    reg_write_src=2;
                    write_enable=1;
                end
                if(func==13)
                begin
                    pc=douta;
                end
            end
            if(opcode>=1&&opcode<=9)
            begin
                //write_addr=instruction[19:16];
                reg_addr_src=1;
                //write_data=out;
                reg_write_src=0;
                write_enable=1;
            end
            if(opcode==14)
            begin
                //write_addr=instruction[19:16];
                reg_addr_src=1;
                //write_data=douta;
                reg_write_src=2;
                write_enable=1;
            end
            if(opcode==16)
            begin
                //stackpointer=douta;
                stack_addr=1;
                update_sp=1;
            end
            if(opcode==18)
            begin
                pc=pc+immediate;
            end
            if(opcode==19)
            begin
                //write_data=immediate;
                reg_write_src=3;
                //write_addr=instruction[19:16];
                reg_addr_src=1;
                write_enable=1;
                ////$display("%d=enable,%d=data,%d=address",write_enable,immediate[1],write_addr);
            end
            counter=8;
        end
        else if(counter==8)
        begin
            counter=9;
            update_sp=0;
        end
        else if(counter==9)
        begin
            counter=7;
        end
        else if(counter==7)
        begin
            counter=0;
            wea=0;
            write_enable=0;
        end
    end
endmodule