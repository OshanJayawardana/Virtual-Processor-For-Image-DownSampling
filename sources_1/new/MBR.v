`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 04:17:10 PM
// Design Name: 
// Module Name: MBR
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


module MBR(
input [7:0] in_bus,
input Read,
input fetch,
input clk,
output reg [7:0] AR_PC_MBR,//
output reg [15:0] out_bus
);

reg [7:0] register;

initial begin
    register = 8'b0;
    AR_PC_MBR = 8'b0;
end

always@(posedge clk)
        begin
            if (Read) begin
                out_bus[15:8] <= 8'b0;
                out_bus[7:0] <= register;
            end else begin
                out_bus <= 16'b0;
            end
            if (fetch) begin
                register <= in_bus;
                AR_PC_MBR <= in_bus;
            end
        end
endmodule
