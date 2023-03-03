`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 01:22:19 PM
// Design Name: 
// Module Name: R
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


module R(
    input [15:0] in_bus,
    input Read,
    input Write,
    input clk,
    output reg [15:0] out_bus
    );
    
    reg [15:0] register;
    
    initial begin
        register = 16'b0;
    end
    
    always@(posedge clk)
            begin
                if (Read) begin
                    out_bus <= register;
                end else begin
                    out_bus <= 16'b0;
                end
                if (Write) begin
                    register <= in_bus;
                end
            end
endmodule
