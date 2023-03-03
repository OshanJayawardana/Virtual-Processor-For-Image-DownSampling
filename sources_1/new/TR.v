`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 04:53:08 PM
// Design Name: 
// Module Name: TR
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


module TR(
input [15:0] in_bus,
input Read,
input Write,
input clk,
output reg [7:0] AR_PC_TR,//
output reg [15:0] out_bus
);

reg [7:0] register;

initial begin
    register = 8'b0;
    AR_PC_TR = 8'b0;
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
                AR_PC_TR <= in_bus[7:0];
            end
        end
endmodule
