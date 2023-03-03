`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 01:27:45 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
input [2:0] Op,//
input [3:0] shift,//
input clk,
input fetch,//
input Decode,//
input PC1,//
input Read_AC,//
input [1:0] Ins_Con,//
input Mem_Read,//
input Mem_Write,//
input [14:0] Read_RL,//
input [17:0] Write_RL,//
input [7:0] IM_OUT,
output wire [7:0] memory_in,
output wire [15:0] address,
input [7:0] memory_out,
output wire[7:0] Dec_IN,
output wire [15:0] IM_IN,
output wire z_flag,
output wire [15:0] C_bus,
output wire [15:0] A_bus, B_bus,
output wire finish_signal
);

wire [15:0] B_0;
wire [15:0] B_1;
wire [15:0] B_2;
wire [15:0] B_3;
wire [15:0] B_4;
wire [15:0] B_5;
wire [15:0] B_6;
wire [15:0] B_7;
wire [15:0] B_8;
wire [15:0] B_9;
wire [15:0] B_10;
wire [15:0] B_11;
wire [15:0] B_12;
wire [15:0] B_13;
wire [15:0] B_14;
//wire [15:0] A_bus, B_bus;
//wire [15:0] MBR_W;
//wire [15:0] TR_W;
wire [7:0] AR_PC_TR;
wire [7:0] AR_PC_MBR;

assign B_bus = B_0|B_1|B_2|B_3|B_4|B_5|B_6|B_7|B_8|B_9|B_10|B_11|B_12|B_13|B_14;

R AC(.in_bus(C_bus), .out_bus(A_bus), .Read(Read_AC), .Write(Write_RL[0]), .clk(clk));
R R(.in_bus(C_bus), .out_bus(B_0), .Read(Read_RL[0]), .Write(Write_RL[1]), .clk(clk));
R R1(.in_bus(C_bus), .out_bus(B_1), .Read(Read_RL[1]), .Write(Write_RL[2]), .clk(clk));
R R2(.in_bus(C_bus), .out_bus(B_2), .Read(Read_RL[2]), .Write(Write_RL[3]), .clk(clk));
R R3(.in_bus(C_bus), .out_bus(B_3), .Read(Read_RL[3]), .Write(Write_RL[4]), .clk(clk));
R R4(.in_bus(C_bus), .out_bus(B_4), .Read(Read_RL[4]), .Write(Write_RL[5]), .clk(clk));
R R5(.in_bus(C_bus), .out_bus(B_5), .Read(Read_RL[5]), .Write(Write_RL[6]), .clk(clk));
R R6(.in_bus(C_bus), .out_bus(B_6), .Read(Read_RL[6]), .Write(Write_RL[7]), .clk(clk));
R R7(.in_bus(C_bus), .out_bus(B_7), .Read(Read_RL[7]), .Write(Write_RL[8]), .clk(clk));
R R8(.in_bus(C_bus), .out_bus(B_8), .Read(Read_RL[8]), .Write(Write_RL[9]), .clk(clk));
R R9(.in_bus(C_bus), .out_bus(B_9), .Read(Read_RL[9]), .Write(Write_RL[10]), .clk(clk));
R R10(.in_bus(C_bus), .out_bus(B_10), .Read(Read_RL[10]), .Write(Write_RL[11]), .clk(clk));
R R11(.in_bus(C_bus), .out_bus(B_11), .Read(Read_RL[11]), .Write(Write_RL[12]), .clk(clk));
PC PC(.in_bus(C_bus), .out_bus(IM_IN), .fetch(fetch), .Write(Write_RL[13]), .clk(clk), .PC1(PC1), .Ins_Con(Ins_Con[1]),
.TR_PC(AR_PC_TR), .MBR_PC(AR_PC_MBR), .finish_signal(finish_signal));//
IR IR(.in_bus(C_bus), .out_bus(Dec_IN), .Decode(Decode), .Write(Write_RL[14]), .clk(clk));
MBR MBR(.in_bus(IM_OUT), .out_bus(B_12), .Read(Read_RL[12]), .fetch(fetch), .clk(clk), .AR_PC_MBR(AR_PC_MBR));//
TR TR(.in_bus(C_bus), .out_bus(B_13), .Read(Read_RL[13]), .Write(Write_RL[15]), .clk(clk), .AR_PC_TR(AR_PC_TR));//
DR DR(.in_bus(C_bus), .out_bus(B_14), .Read(Read_RL[14]), .Write(Write_RL[16]), .clk(clk), .Mem_Read(Mem_Read),
.Mem_Write(Mem_Write), .memory_in(memory_in), .memory_out(memory_out));
AR AR(.in_bus(C_bus), .out_bus(address), .Write(Write_RL[17]), .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .clk(clk),
.Ins_Con(Ins_Con[0]), .TR_AR(AR_PC_TR), .MBR_AR(AR_PC_MBR));//
ALU alu(.A_bus(A_bus), .B_bus(B_bus), .operation(Op), .clk(clk), .C_bus(C_bus), .z_flag(z_flag), .shift(shift));  

endmodule
