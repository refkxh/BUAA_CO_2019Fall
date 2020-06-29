`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:31 11/16/2019 
// Design Name: 
// Module Name:    StageM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module StageM(
    input Clk,
    input Reset,
    input [31:0] InstrM,
    input [31:0] ALUOutM,
    input [31:0] ForwardM2,
    input [31:0] WDM,
	 input [31:0] PCM,
    output [31:0] WDMW,
	 output M2Use
    );

	wire [31:0] DMRD;
	wire [1:0] OpWidth;
	
	Controller ControllerM (
    .Op(InstrM[31:26]), 
    .Funct(InstrM[5:0]), 
	 .RT(InstrM[20:16]), 
    .MemWrite(MemWrite), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .GenM(GenM), 
	 .M2Use(M2Use)
    );
	 
	 DM DMInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .Addr(ALUOutM), 
    .WD(ForwardM2), 
    .MemWrite(MemWrite), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .WPC(PCM), 
    .RD(DMRD)
    );
	 
	 MUX2 MWDM (
    .In0(WDM), 
    .In1(DMRD), 
    .Sel(GenM), 
    .Out(WDMW)
    );

endmodule
