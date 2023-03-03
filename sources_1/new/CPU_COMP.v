`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 02:47:08 AM
// Design Name: 
// Module Name: CPU_COMP
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


module CPU_COMP(
input clk,
output wire z_flag,
output wire [15:0] C_bus,
output wire [15:0] A_bus, B_bus,
output wire [5:0] next_address_micro,

output wire [2:0] Op,
output wire [3:0] shift,
output wire fetch,
output wire Decode,
output wire PC1,
output wire[7:0] Dec_IN,
output wire Read_AC,
output wire [1:0] Ins_Con,
output wire Mem_Read,
output wire Mem_Write,
output wire [14:0] Read_RL,
output wire [17:0] Write_RL,
output wire [15:0] IM_IN,
output wire [7:0] IM_OUT,
output wire [7:0] memory_in,
output wire [7:0] memory_out,
output wire [15:0] address
);

//wire [2:0] Op;//
//wire [3:0] shift;//
//wire fetch;//
//wire Decode;//
//wire PC1;//
//wire Read_AC;//
//wire [1:0] Ins_Con;//
//wire Mem_Read;//
//wire Mem_Write;//
//wire [14:0] Read_RL;//
//wire [17:0] Write_RL;//
//wire [15:0] IM_IN;//
//wire [7:0] IM_OUT;//
//wire [7:0] memory_in;
//wire [7:0] memory_out;
//wire [15:0] address;
//wire[7:0] Dec_IN;//
wire [55:0] signal;//
wire finish_signal;

assign Mem_Write = signal[0];
assign Mem_Read = signal[1];
assign Ins_Con = signal[3:2];
assign Write_RL = signal[21:4];
assign Read_RL = signal[37:23];
assign Read_AC = signal[38];
assign PC1 = signal[40];
assign shift = signal[44:41];
assign Op = signal[47:45];
assign next_address_micro = signal[53:48];
assign fetch = signal[54];
assign Decode = signal[55];
    
CPU CPU(.Op(Op), .shift(shift), .clk(clk), .Read_AC(Read_AC), .z_flag(z_flag), .C_bus(C_bus), .Read_RL(Read_RL), .Write_RL(Write_RL), .A_bus(A_bus),
     .B_bus(B_bus), .fetch(fetch), .PC1(PC1), .Decode(Decode), .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .IM_OUT(IM_OUT),
     .memory_in(memory_in), .address(address), .memory_out(memory_out), .Dec_IN(Dec_IN), .IM_IN(IM_IN), .Ins_Con(Ins_Con), .finish_signal(finish_signal));
IMem IMem(.IM_IN(IM_IN), .IM_OUT(IM_OUT));
DMem DMem(.clk(clk), .Mem_Write(Mem_Write), .address(address), .memory_in(memory_in), .memory_out(memory_out), .finish_signal(finish_signal));
Control_Store Control_Store(.z_flag(z_flag), .Dec_IN(Dec_IN), .signal(signal), .Decode(Decode), .next_address_micro(next_address_micro), .clk(clk));
endmodule
