`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 10:26:14 PM
// Design Name: 
// Module Name: DMem
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


module DMem(
input clk,
input Mem_Write,
input finish_signal,
input [15:0] address,
input [7:0] memory_in,
output wire [7:0] memory_out
);

reg [7:0] MEM[0:65536];
assign memory_out = MEM[address];

always@(posedge clk)
begin
    if (Mem_Write) begin
        MEM[address]<=memory_in;
    end
    
    if (finish_signal) begin
        $writememb("C:/DownSample/project_final/DMem_out.mem", MEM);
        $display("done");
        $finish;
    end
end

initial begin
//IM_OUT <= 8'b0;
//MEM[0] = 8'b0000_0100;
//MEM[1] = 8'b0000_1001;
//MEM[2] = 8'b0000_0010;
//MEM[5] = 8'b0001_0101;
$readmemb("C:/DownSample/project_final/image.mem", MEM);
end
endmodule
