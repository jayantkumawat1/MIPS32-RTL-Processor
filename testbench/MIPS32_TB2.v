module mips32_test_2;

reg clk1,clk2;
integer k;

MIPS32 MIPS(clk1,clk2);

initial 
begin 
clk1=0;
clk2=0;
repeat(20)
begin 
#5 clk1=1; #5 clk1=0;
#5 clk2=1; #5 clk2=0;
end 
end 

initial begin 
for(k=0;k<32;k=k+1)
begin
MIPS.Reg[k]=k;
end 
MIPS.Mem[120] = 32'h0000000a;
MIPS.Mem[0] = 32'h20010078;   // LW R1,120(R0)
MIPS.Mem[1] = 32'h0ce77800;   // OR   R7, R7, R7  --- dummy instr.
MIPS.Mem[2] = 32'h0ce77800;   // OR   R7, R7, R7  --- dummy instr.
MIPS.Mem[3] = 32'h2821002d;   // ADDI R1, R1, 45
MIPS.Mem[4] = 32'h0ce77800;   // OR   R7, R7, R7  --- dummy instr.
MIPS.Mem[5] = 32'h0ce77800;   // OR   R7, R7, R7  --- dummy instr.
MIPS.Mem[6] = 32'h24010079;   // SW R1,121(R0)
MIPS.Mem[7]=  32'hfc000000;   // HLT

 
MIPS.HALTED=0;
MIPS.TAKEN_BRANCH=0;
MIPS.PC=0;

#280 
for (k=0;k<4;k=k+1)
begin
$display("R%1d-%2d",k,MIPS.Reg[k]) ;
end 
end 

initial begin
$dumpfile("MIPS_wave_ex2.vcd");
$dumpvars(0,mips32_test_2);
#300 $finish;
end

endmodule 


