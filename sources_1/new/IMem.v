`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 12:08:46 AM
// Design Name: 
// Module Name: IMem
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


module IMem(
input [15:0] IM_IN,
output wire [7:0] IM_OUT
);

reg [7:0] MEM[0:65536];
assign IM_OUT = MEM[IM_IN];

//integer i=0;
//integer value;
//integer fd;
//reg [8*45:1] str;
initial begin
// 1. For Testing JPNZN and FETCH
//MEM[0] = 8'b0111_1111;
//MEM[1] = 8'b0101_1111;
//MEM[2] = 8'b0;
//MEM[3] = 8'b0;
//MEM[4] = 8'b0111_1111;

// 2. For LOADACI and (SUB or ADD) and LOADR and JPNZ
//MEM[0] = 8'b0000_1111;//LOADACI
//MEM[1] = 8'b0000_0000;
//MEM[2] = 8'b0000_0101;//AC<= 21
//MEM[3] = 8'b0100_0001;//LOADR R<=21
//MEM[4] = 8'b0000_1111;//LOADACI
//MEM[5] = 8'b0000_0000;
//MEM[6] = 8'b0000_0101;//AC<= 21
//MEM[7] = 8'b0110_1111;//ADD or SUB z=1
//MEM[8] = 8'b0101_1111;//JPNZ
//MEM[9] = 8'b0000_0001;
//MEM[10] = 8'b0000_0010;
//MEM[258] = 8'b0000_1111;//LOADACI
//MEM[259] = 8'b0000_1111;//LOADACI
//MEM[260] = 8'b0000_0101;//AC<= 21
//MEM[261] = 8'b0100_0001;//LOADR R<=21
//MEM[262] = 8'b0000_1111;//LOADACI
//MEM[263] = 8'b0000_0000;
//MEM[264] = 8'b0000_0101;//AC<= 21
//MEM[265] = 8'b0111_1111;//ADD or SUB z=1

// 3. For ADDI, SUBI, LSHIFT and RSHIFT
//MEM[0] = 8'b1000_1111;//ADDI
//MEM[1] = 8'b0000_0011;//3
//MEM[2] = 8'b1001_1111;//SUBI
//MEM[3] = 8'b0000_0010;//2 = 1
//MEM[4] = 8'b1100_0010;//Left shift 2 = 4
//MEM[5] = 8'b1101_0001;//Right shift 1 = 2

// 4. For INCRMNT, DCRMNT, TRFR2AC, WRITEAC, LOADAC and CLAC
//MEM[0] = 8'b1010_0011;//INCRMNT, 3
//MEM[1] = 8'b1010_0011;//INCRMNT, 3 R2=2
//MEM[2] = 8'b1010_0001;//INCRMNT, 1 R=1
//MEM[3] = 8'b0011_0011;//TRFR2AC AC = 2
//MEM[4] = 8'b0010_1111;//WRITEAC DMem[1]=2
//MEM[5] = 8'b1110_1111;//CLAC AC=0
//MEM[6] = 8'b0001_0001;//LOADAC AC = DMem[1]=2
//MEM[7] = 8'b1011_0000;//DCRMNT 0, AC=1
//MEM[8] = 8'b1011_0000;//DCRMNT 0, AC=0
$readmemb("C:/DownSample/project_final/ins.mem", MEM);
end
endmodule
