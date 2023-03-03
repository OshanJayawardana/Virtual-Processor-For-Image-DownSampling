`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 12:06:10 AM
// Design Name: 
// Module Name: Control_Unit_tb
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


module Control_Unit_tb();
reg z_flag;
reg clk;
reg [4:0] next_address;
wire [53:0]signal;

Control_Store Control_Store(.z(z_flag), .next_address(next_address), .signal(signal));

initial begin
z_flag=0;
next_address = 5'b10001;
clk=1;
#10
clk=0;
#10
$stop;
end
endmodule
