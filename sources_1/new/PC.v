`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 03:32:17 PM
// Design Name: 
// Module Name: PC
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


module PC(
input [15:0] in_bus,
input fetch,
input Ins_Con,
input Write,
input clk,
input PC1,
input [7:0] TR_PC,
input [7:0] MBR_PC,
output reg [15:0] out_bus,
output reg finish_signal
);

//reg [15:0] register;

initial begin
    out_bus = 16'b0;//register = 16'b0;
    finish_signal = 0;
end

always@(posedge clk)
    begin
        if (Ins_Con) begin
            out_bus[15:8] <= TR_PC;//out_bus[15:8] <= TR_PC[7:0];
            out_bus[7:0] <= MBR_PC;//out_bus[7:0] <= MBR_PC[7:0];
        end
        //if (fetch) begin
        //    out_bus <= register;
        //end else begin
        //    out_bus <= 16'b0;
        //end
        if (Write) begin
            out_bus <= in_bus; //register <= in_bus;
        end
        if (PC1) begin
            out_bus <= out_bus + 1;//register <= register + 1;
        end
    //$display(out_bus);
    if (out_bus==333) begin
        finish_signal <= 1;
    end
    end
endmodule
