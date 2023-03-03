`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 05:27:12 PM
// Design Name: 
// Module Name: DR
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


module DR(
input [15:0] in_bus,
input Read,
input Write,
input clk,
input Mem_Read,
input Mem_Write,
input [7:0] memory_out,
output reg [7:0] memory_in,
output reg [15:0] out_bus
);

reg [7:0] register;

initial begin
    register = 8'b0;
    memory_in = 8'b0;
end

always@(posedge clk)
        begin
            if (Read) begin
                out_bus[15:8] <= 8'b0;
                out_bus[7:0] <= register;
            end else begin
                out_bus <= 16'b0;
            end
            if (Write) begin
                register <= in_bus[7:0];
                memory_in <= in_bus[7:0];
            end
            if (Mem_Read) begin
                register <= memory_out;
                memory_in <= memory_out;
            end
        end
endmodule
