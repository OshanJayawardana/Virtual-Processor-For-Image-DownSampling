`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 01:24:39 PM
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb();
reg [2:0] Op;
reg [3:0] shift;
reg clk;
reg Read_AC;
reg Mem_Read;
reg Ins_Con;
reg Decode;
reg Mem_Write;
reg [14:0] Read_RL;
reg [17:0] Write_RL;
wire z_flag;
wire [15:0] C_bus;
wire [15:0] A_bus, B_bus;
reg fetch;
reg PC1;

CPU CPU(.Op(Op), .shift(shift), .clk(clk), .Read_AC(Read_AC), .z_flag(z_flag), .C_bus(C_bus), .Read_RL(Read_RL), .Write_RL(Write_RL), .A_bus(A_bus),
 .B_bus(B_bus), .fetch(fetch), .PC1(PC1), .Decode(Decode), .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .IM_OUT(IM_OUT),
 .memory_in(memory_in), .address(address), .memory_out(memory_out), .Dec_IN(Dec_IN), .IM_IN(IM_IN), .Ins_Con(Ins_Con)); 


initial begin
fetch = 0;
Decode = 0;
Mem_Read = 0;
Mem_Write = 0;
PC1 = 0;
Ins_Con = 0;
Read_AC = 1; Read_RL = 15'b1; Write_RL=18'b0; shift=4'b10;
clk=1; Op=4'b000;
#10
clk=0;
#10

Read_AC = 1; Read_RL = 15'b1; Write_RL=18'b0; shift=4'b10;
clk=1; Op=4'b001;
#10
clk=0;
#10

Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b10;
clk=1; Op=4'b000;
#10
clk=0;
#10
/////////////////////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b1; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b010;
Read_AC = 1; Read_RL = 15'b1; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b10;
#10
clk=0;
#10

////////////////////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b011;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b10;
#10
clk=0;
#10

//////////////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b100;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b10;
#10
clk=0;
#10

////////////////////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b101;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b10;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b10;
#10
clk=0;
#10
///////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b100;
#10
clk=0;
#10

clk=1; Op=4'b110;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b100;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b100;
#10
clk=0;
#10

/////////////////////////////////////////////

clk=1; Op=4'b000;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b100;
#10
clk=0;
#10

clk=1; Op=4'b111;
Read_AC = 1; Read_RL = 15'b0; Write_RL=18'b0; shift=4'b100;
#10
clk=0;
#10

clk=1; Op=4'b000;
Read_AC = 0; Read_RL = 15'b0; Write_RL=18'b1; shift=4'b100;
#10
clk=0;
#10
$stop;                                  
end 
endmodule
