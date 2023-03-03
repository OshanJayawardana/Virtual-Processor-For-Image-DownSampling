`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 01:23:14 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
input [15:0] A_bus,
input [15:0] B_bus,
input [2:0] operation,
input [3:0] shift,
input clk,
output reg [15:0] C_bus,
output reg z_flag
);

//ALU operations
parameter ADD = 3'b001;
parameter SUB = 3'b010;
parameter INC = 3'b011;
parameter DEC = 3'b100;
parameter LSHIFT = 3'b101;
parameter RSHIFT = 3'b110;
//parameter PASSATOC = 4'b0011;
//parameter PASSBTOC = 4'b0100;
//parameter INCA = 4'b0101;
//parameter DECA = 4'b0110;
//parameter INCB = 4'b0111;
//parameter DECB = 4'b1000;
//parameter RSHIFT1 = 4'b1001;
//parameter RSHIFT2 = 4'b1010;
//parameter LSHIFT = 4'b1011;
parameter RESET = 3'b111;

initial begin
    C_bus = 16'b0;
    z_flag = 1'b0;
end

always@(posedge clk)
    begin
    case(operation)
        ADD : C_bus <= A_bus + B_bus;
        
        SUB : begin
        C_bus = A_bus - B_bus;
        z_flag = (C_bus == 16'b0) ? 1'b1 : 1'b0;
        end
        
        INC : C_bus <= A_bus + B_bus + 1;
        
        DEC : begin
        C_bus = A_bus + B_bus - 1;
        z_flag = (C_bus == 16'b0) ? 1'b1 : 1'b0;
        end
        
        RSHIFT : C_bus <= A_bus >> shift;
        
        LSHIFT : C_bus <= A_bus << shift;
        
        RESET : C_bus <= 16'b0;
        
    endcase 
    end
endmodule
