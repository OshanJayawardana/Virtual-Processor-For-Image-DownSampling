`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 04:02:07 PM
// Design Name: 
// Module Name: IR
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


module IR(
input [15:0] in_bus,
input Decode,
input Write,
input clk,
output reg [7:0] out_bus
);

//reg [7:0] register;

initial begin
    out_bus = 8'b0;
end

always@(posedge clk)
        begin
            if (Write) begin
                out_bus <= in_bus[7:0];
            end
        //$display("IR ","%b", out_bus);
        end 
endmodule
