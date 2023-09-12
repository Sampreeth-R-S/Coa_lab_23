module testbench;
    reg clk=0;
    always #5   clk=~clk;
    reg [3:0] val;
    reg [2:0] addr1;
    reg [3:0] addr2;
    reg [1:0] opcode;
    wire [3:0] out;
    top_module M1(val,addr1,addr2,opcode,out,clk);
    initial
        begin
            $monitor ("val=%d,addr1=%d,addr2=%d,opcode=%d,out=%d",val,addr1,addr2,opcode,out);
            #0 opcode=0;addr2=0;val=10;
            #100 opcode=2;addr1=1;addr2=0;
            #100 opcode=1;addr1=1;addr2=1;
            #100 opcode=3;addr2=1;
            #100 opcode=0;addr2=1;val=15;
            #100 opcode=3;addr2=1;
            #100 $finish;
        end
endmodule