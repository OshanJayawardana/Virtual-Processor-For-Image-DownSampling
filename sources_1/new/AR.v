`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 06:19:35 PM
// Design Name: 
// Module Name: AR
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


module AR(
input [15:0] in_bus,
input Write,
input Mem_Read,
input Mem_Write,
input clk,
input Ins_Con,
input [7:0] TR_AR,
input [7:0] MBR_AR,
output reg [15:0] out_bus
);

//reg [15:0] register;

initial begin
    out_bus = 16'b0;//register = 16'b0;
end

always@(posedge clk)
        begin
            if (Ins_Con) begin
                    out_bus[15:8] <= TR_AR;//register[15:8] <= TR_AR[7:0];
                    out_bus[7:0] <= MBR_AR;//register[7:0] <= MBR_AR[7:0];
                end
            //if (Mem_Read|Mem_Write) begin
                //out_bus <= register;
            //end else begin
                //out_bus <= 16'b0;
            //end
            if (Write) begin
                out_bus <= in_bus;
            end
        end
endmodule
