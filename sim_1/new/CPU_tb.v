`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 09:32:06 AM
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb();
reg clk;
wire z_flag;
wire [15:0] C_bus;
wire [15:0] A_bus, B_bus;
wire [5:0] next_address_micro;

wire [2:0] Op;//
wire [3:0] shift;//
wire fetch;//
wire Decode;//
wire PC1;//
wire Read_AC;//
wire [1:0] Ins_Con;//
wire Mem_Read;//
wire Mem_Write;//
wire [14:0] Read_RL;//
wire [17:0] Write_RL;//
wire [15:0] IM_IN;//
wire [7:0] IM_OUT;//
wire [7:0] memory_in;
wire [7:0] memory_out;
wire [15:0] address;
wire[7:0] Dec_IN;//

CPU_COMP CPU_COMP(.clk(clk), .z_flag(z_flag), .C_bus(C_bus), .A_bus(A_bus), .B_bus(B_bus),
.next_address_micro(next_address_micro),
.Op(Op),.shift(shift),.fetch(fetch), .Decode(Decode), .PC1(PC1), .Read_AC(Read_AC), .Ins_Con(Ins_Con),
.Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Read_RL(Read_RL), .Write_RL(Write_RL), .IM_IN(IM_IN), .IM_OUT(IM_OUT),
.memory_in(memory_in), .memory_out(memory_out), .address(address), .Dec_IN(Dec_IN));

initial begin
clk=0;
forever #(10) clk<=~clk;
end
endmodule
