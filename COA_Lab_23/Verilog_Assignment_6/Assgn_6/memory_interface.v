module register(dest,enable,writenable,loadval,out,clk);
    //input [2:0] src;  //Source and destination register
    input [2:0] dest;
    input [3:0] loadval;  //Loadval for the load command
    //input move;  //Control signal(move=0 for load, move=1 for move)
    input clk;
    input enable,writenable;
    output [3:0] out;  //Output of the registerfile
    reg [3:0] out;
    reg [3:0] registers [7:0];
    parameter high=4'bzzzz;  //Default output value
    always @(posedge clk)
    begin
        if(enable)
        begin
            if(writenable)
            begin
                registers[dest]=loadval;
                out=registers[dest];
            end
            else
                out=registers[dest];
         end
         else
            out=0;
     end
endmodule

module top_module(val,addr1,addr2,opcode,out,clk);
    input [3:0] val;
    input [1:0] opcode;
    output [3:0] out;
    input [2:0] addr1;
    input [3:0] addr2;
    input clk;
    reg ena, wea;
    reg [3:0] dina;
    wire [3:0] douta;
    /*register_port your_instance_name (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addr1),  // input wire [2 : 0] addra
  .dina(dina),    // input wire [3 : 0] dina
  .douta(douta)  // output wire [3 : 0] douta
);*/
register M1(
.dest(addr1),
.enable(ena),
.writenable(wea),
.loadval(dina),
.out(douta),
.clk(clk)
);

    reg ena2,wea2;
    reg [3:0] dina2;
    wire [3:0] douta2;
   memory_port your_instance_name2 (
  .clka(clk),    // input wire clka
  .ena(ena2),      // input wire ena
  .wea(wea2),      // input wire [0 : 0] wea
  .addra(addr2),  // input wire [3 : 0] addra
  .dina(dina2),    // input wire [3 : 0] dina
  .douta(douta2)  // output wire [3 : 0] douta
);
    reg [3:0] out;
    always @(posedge clk)
    begin
        if (opcode == 0)
        begin
            dina2=val;
            ena2=1;
            wea2=1;
            ena=0;
            wea=0;
        end
        else if (opcode==1)
        begin
            ena=1;
            ena2=1;
            
            wea=0;
            
            #20 dina2=douta;
            wea2=1;
        end
        else if (opcode==2)
        begin
            ena=1;
            ena2=1;
            wea2=0;
            #20 dina=douta2;
            wea=1;
        end
        else
        begin
            ena=0;
            ena2=1;
            wea=0;
            wea2=0;
            #20 out=douta2;
        end
     end
            
endmodule
    