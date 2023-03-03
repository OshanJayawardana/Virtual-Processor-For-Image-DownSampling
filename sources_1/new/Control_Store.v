`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2022 10:41:42 PM
// Design Name: 
// Module Name: Control_Store
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


module Control_Store(
input clk,
input z_flag,
input Decode,
input [7:0] Dec_IN,
input [5:0] next_address_micro,
output reg [55:0] signal
);
    
reg [55:0] ROM[0:50];
reg [5:0] Next_LUT[0:65536];
reg [5:0] old_address;
reg [15:0] Read_LUT[0:12];
reg [18:0] Write_LUT[0:12];

parameter LOADACI   = 4'b0000;
parameter LOADAC    = 4'b0001;
parameter WRITEAC   = 4'b0010;
parameter TRFR2AC   = 4'b0011;
parameter LOADR     = 4'b0100;
parameter JPNZ      = 4'b0101;
parameter ADD       = 4'b0110;
parameter SUB       = 4'b0111;
parameter ADDI      = 4'b1000;
parameter SUBI      = 4'b1001;
parameter INCRMNT   = 4'b1010;
parameter DCRMNT    = 4'b1011;
parameter LSHIFT    = 4'b1100;
parameter RSHIFT    = 4'b1101;
parameter CLAC      = 4'b1110;
parameter Fetch     = 4'b1111;

wire [55:0] signal_wire;
wire [55:0] signal_wire_temp;
wire [5:0] next_address;
wire [5:0] ROM_address_decode;
wire [5:0] ROM_address_micro;
wire [5:0] ROM_address;

assign next_address = Next_LUT[Dec_IN[7:4]];
assign ROM_address_decode[5] = next_address[5]&z_flag;
assign ROM_address_decode[4:0] = next_address[4:0];

assign ROM_address_micro[5] = next_address_micro[5]&z_flag;
assign ROM_address_micro[4:0] = next_address_micro[4:0];

assign ROM_address = Decode? ROM_address_decode:ROM_address_micro;

assign signal_wire_temp = ROM[ROM_address];

assign signal_wire[55:45] = signal_wire_temp[55:45];
assign signal_wire[40:39] = signal_wire_temp[40:39];
assign signal_wire[22] = signal_wire_temp[22];
assign signal_wire[3:0] = signal_wire_temp[3:0];

assign signal_wire[44:41] = Dec_IN[3:0];
assign signal_wire[38:23] = signal_wire_temp[39]? Read_LUT[Dec_IN[3:0]]: signal_wire_temp[38:23];
assign signal_wire[21:4] = signal_wire_temp[22]? Write_LUT[Dec_IN[3:0]]: signal_wire_temp[21:4];

reg [1:0] state = 2'b11;

always@(posedge clk)
	begin
        case(state)
            2'b00 : state = 2'b01;
            2'b01 : state = 2'b10;
            2'b10 : state = 2'b11;
            2'b11 : state = 2'b00;
            default : state = state;
        endcase
	end
	
always@(posedge clk)
    begin
        //$display("state: ",state);
        case(state)
            2'b00 :begin
                signal[55]<=0; //Decode
                signal[54]<=signal_wire[54]; //Fetch
                signal[53:48]<=ROM_address; //Next Address reset signal[51:46]<=old_address
                signal[47:45]<=3'b0;        //ALU reset
                signal[44:41]<=signal_wire[44:41];//shift
                signal[40]<=signal_wire[40]; //pc
                signal[39]<=signal_wire[39];//VR
                signal[38:23]<=signal_wire[38:23];//Read signal reset
                signal[22]<=signal_wire[22];//VW
                signal[21:4]<=18'b0; //Write signal reset
                signal[3:0]<=signal_wire[3:0]; //other control
                old_address<=ROM_address;
            end
            
            2'b01 :begin
                signal[55]<=0; //Decode
                signal[54]<=0; //Fetch
                signal[53:48]<=old_address; //Next Address reset
                signal[47:45]<=signal_wire[47:45]; //ALU reset
                signal[44:41]<=signal_wire[44:41];//shift
                signal[40]<=0; //pc
                signal[39]<=signal_wire[39];//VR
                signal[38:23]<=16'b0;//Read signal reset
                signal[22]<=signal_wire[22];//VW
                signal[21:4]<=18'b0; //Write signal reset
                signal[3:0]<=signal_wire[3:0]; //other controls
            end
            
            2'b10 :begin
                signal[55]<=0; //Decode
                signal[54]<=0; //Fetch
                signal[53:48]<=old_address; //Next Address reset
                signal[47:45]<=3'b0;        //ALU reset
                signal[44:41]<=signal_wire[44:41];//shift
                signal[40]<=0; //pc
                signal[39]<=signal_wire[39];//VR
                signal[38:23]<=16'b0;//Read signal reset
                signal[22]<=signal_wire[22];//VW
                signal[21:4]<=signal_wire[21:4]; //Write signal reset
                signal[3:0]<=signal_wire[3:0]; //other controls
            end
            
            2'b11 :begin
                signal[55]<=signal_wire[55]; //Decode
                signal[54]<=0; //Fetch
                signal[53:48]<=signal_wire[53:48]; //Next Address reset
                signal[47:45]<=3'b0;        //ALU reset
                signal[44:41]<=signal_wire[44:41];//shift
                signal[40]<=0; //pc
                signal[39]<=0;//VR
                signal[38:23]<=16'b0;//Read signal reset
                signal[22]<=0;//VW
                signal[21:4]<=18'b0; //Write signal reset
                signal[3:0]<=4'b0; //other controls
                //old_address<=signal_wire[51:46];
            end
        endcase
    //$display("Dec_IN ","%b",Dec_IN);
    //$display("ROM_address_decode: ","%b",ROM_address_decode);
    //$display("ROM_address_micro: ","%b",ROM_address_micro);
    //$display("ROM_address: ","%b",ROM_address);
    //$display("Decode: ","%b",Decode);
    //$display("");
    end
    
initial begin
old_address=6'b0;
signal = 56'b0;
end

initial begin
Read_LUT[0]     = 16'b1000000000000000;
Read_LUT[1]     = 16'b0000000000000001;
Read_LUT[2]     = 16'b0000000000000010;
Read_LUT[3]     = 16'b0000000000000100;
Read_LUT[4]     = 16'b0000000000001000;
Read_LUT[5]     = 16'b0000000000010000;
Read_LUT[6]     = 16'b0000000000100000;
Read_LUT[7]     = 16'b0000000001000000;
Read_LUT[8]     = 16'b0000000010000000;
Read_LUT[9]     = 16'b0000000100000000;
Read_LUT[10]    = 16'b0000001000000000;
Read_LUT[11]    = 16'b0000010000000000;
Read_LUT[12]    = 16'b0000100000000000;
end

initial begin
Write_LUT[0]     = 18'b000000000000000001;
Write_LUT[1]     = 18'b000000000000000010;
Write_LUT[2]     = 18'b000000000000000100;
Write_LUT[3]     = 18'b000000000000001000;
Write_LUT[4]     = 18'b000000000000010000;
Write_LUT[5]     = 18'b000000000000100000;
Write_LUT[6]     = 18'b000000000001000000;
Write_LUT[7]     = 18'b000000000010000000;
Write_LUT[8]     = 18'b000000000100000000;
Write_LUT[9]     = 18'b000000001000000000;
Write_LUT[10]    = 18'b000000010000000000;
Write_LUT[11]    = 18'b000000100000000000;
Write_LUT[12]    = 18'b000001000000000000;
end

initial begin
Next_LUT[LOADACI] = 6'b000011;
Next_LUT[LOADAC]  = 6'b001001;
Next_LUT[WRITEAC] = 6'b001100;
Next_LUT[TRFR2AC] = 6'b001111;
Next_LUT[LOADR]   = 6'b010000;
Next_LUT[JPNZ]    = 6'b110001;
Next_LUT[ADD]     = 6'b010101;
Next_LUT[SUB]     = 6'b010110;
Next_LUT[ADDI]    = 6'b010111;
Next_LUT[SUBI]    = 6'b011001;
Next_LUT[INCRMNT] = 6'b011011;
Next_LUT[DCRMNT]  = 6'b011100;
Next_LUT[LSHIFT]  = 6'b011101;
Next_LUT[RSHIFT]  = 6'b011110;
Next_LUT[CLAC]    = 6'b011111;
Next_LUT[Fetch]   = 6'b000000;
end

initial begin
ROM[0] = 56'b0_1_0_00001_000_0000_0_0_0_000000000000000_0_000000000000000000_00_0_0;//fetch 1
ROM[1] = 56'b0_0_0_00010_001_0000_1_0_0_001000000000000_0_000100000000000000_00_0_0;//fetch 2
ROM[2] = 56'b1_0_0_00000_000_0000_0_0_0_000000000000000_0_000000000000000000_00_0_0;//ftech 3

ROM[3] = 56'b0_1_0_00100_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//LOADACI 1
ROM[4] = 56'b0_0_0_00101_001_0000_0_0_0_001000000000000_0_001000000000000000_00_0_0;//LOADACI 2
ROM[5] = 56'b0_1_0_00110_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//LOADACI 3
ROM[6] = 56'b0_0_0_00111_000_0000_0_0_0_000000000000000_0_000000000000000000_01_0_0;//LOADACI 4
ROM[7] = 56'b0_0_0_01000_000_0000_0_0_0_000000000000000_0_000000000000000000_00_1_0;//LOADACI 5
ROM[8] = 56'b0_0_0_00000_001_0000_0_0_0_100000000000000_0_000000000000000001_00_0_0;//LOADACI 6

ROM[9] = 56'b0_0_0_01010_001_0000_0_1_0_000000000000000_0_100000000000000000_00_0_0;//LOADAC 1
ROM[10] = 56'b0_0_0_01011_000_0000_0_0_0_000000000000000_0_000000000000000000_00_1_0;//LOADAC 2
ROM[11] = 56'b0_0_0_00000_001_0000_0_0_0_100000000000000_0_000000000000000001_00_0_0;//LOADAC 3

ROM[12] = 56'b0_0_0_1101_001_0000_0_0_1_000000000000000_0_010000000000000000_00_0_0;//WRITEAC 1
ROM[13] = 56'b0_0_0_1110_001_0000_0_0_0_000000000000001_0_100000000000000000_00_0_0;//WRITEAC 2
ROM[14] = 56'b0_0_0_0000_000_0000_0_0_0_000000000000000_0_000000000000000000_00_0_1;//WRITEAC 3

ROM[15] = 56'b0_0_0_00000_001_0000_0_1_0_000000000000000_0_000000000000000001_00_0_0;//TRFR2AC 1

ROM[16] = 56'b0_0_0_00000_001_0000_0_0_1_000000000000000_1_000000000000000000_00_0_0;//LOADR 1

ROM[17] = 56'b0_1_0_10010_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//JPNZY 1
ROM[18] = 56'b0_0_0_10011_001_0000_0_0_0_001000000000000_0_001000000000000000_00_0_0;//JPNZY 2
ROM[19] = 56'b0_1_0_10100_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//JPNZY 3
ROM[20] = 56'b0_0_0_00000_000_0000_0_0_0_000000000000000_0_000000000000000000_10_0_0;//JPNZY 4

ROM[21] = 56'b0_0_0_00000_001_0000_0_0_1_000000000000001_0_000000000000000001_00_0_0;//ADD 1

ROM[22] = 56'b0_0_0_00000_010_0000_0_0_1_000000000000001_0_000000000000000001_00_0_0;//SUB 1

ROM[23] = 56'b0_1_0_11000_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//ADDI 1
ROM[24] = 56'b0_0_0_00000_001_0000_0_0_1_001000000000000_0_000000000000000001_00_0_0;//ADDI 2

ROM[25] = 56'b0_1_0_11010_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//SUBI 1
ROM[26] = 56'b0_0_0_00000_010_0000_0_0_1_001000000000000_0_000000000000000001_00_0_0;//SUBI 2

ROM[27] = 56'b0_0_0_00000_011_0000_0_1_0_000000000000000_1_000000000000000000_00_0_0;//INCRMNT 1

ROM[28] = 56'b0_0_0_00000_100_0000_0_1_0_000000000000000_1_000000000000000000_00_0_0;//DCRMNT 1

ROM[29] = 56'b0_0_0_00000_101_0000_0_0_1_000000000000000_0_000000000000000001_00_0_0;//LSHIFT 1
ROM[30] = 56'b0_0_0_00000_110_0000_0_0_1_000000000000000_0_000000000000000001_00_0_0;//RSHIFT 1

ROM[31] = 56'b0_0_0_00000_111_0000_0_0_1_000000000000000_0_000000000000000001_00_0_0;//CLAC 1

ROM[49] = 56'b0_0_1_10010_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//JPNZN 1
ROM[50] = 56'b0_0_0_00000_000_0000_1_0_0_000000000000000_0_000000000000000000_00_0_0;//JPNZN 2
end
endmodule
