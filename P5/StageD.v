`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:23 11/16/2019 
// Design Name: 
// Module Name:    StageD 
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
module StageD(
    input Clk,
	 input Reset,
	 input [31:0] InstrD,
    input [31:0] PC4D,
    input [31:0] ForwardD1,
    input [31:0] ForwardD2,
	 input [31:0] InstrW,
	 input [4:0] A3W,
	 input [31:0] WDW,
	 input [31:0] PCW,
    output [31:0] RD1DE,
    output [31:0] RD2DE,
    output [31:0] Imm32DE,
    output [4:0] A3DE,
    output [31:0] WDDE,
	 output [1:0] PCSrc,
	 output [31:0] NPCOut
    );

	wire [31:0] NPCPC8;
	wire [1:0] ExtOp;
	
	ControllerD ControllerDInstance (
    .Op(InstrD[31:26]), 
    .Funct(InstrD[5:0]), 
    .Equal(Equal), 
    .LTZ(LTZ), 
    .EQZ(EQZ), 
    .NPCOp(NPCOp), 
    .ExtOp(ExtOp), 
    .PCSrc(PCSrc), 
    .GenD(GenD)
    );
	 
	 ControllerW ControllerWInstance (
    .Op(InstrW[31:26]), 
    .Funct(InstrW[5:0]),  
    .RegWrite(RegWrite)
    );
	 
	 GRF GRFInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .A1(InstrD[25:21]), 
    .A2(InstrD[20:16]), 
    .A3(A3W), 
    .WD(WDW), 
    .RegWrite(RegWrite), 
    .WPC(PCW), 
    .RD1(RD1DE), 
    .RD2(RD2DE)
    );
	 
	 EXT EXTInstance (
    .Imm16(InstrD[15:0]), 
    .ExtOp(ExtOp), 
    .Imm32(Imm32DE)
    );
	 
	 CMP CMPInstance (
    .A(ForwardD1), 
    .B(ForwardD2), 
    .Equal(Equal), 
    .LTZ(LTZ), 
    .EQZ(EQZ)
    );
	 
	 NPC NPCInstance (
    .NPCOp(NPCOp), 
    .PC4(PC4D), 
    .Imm26(InstrD[25:0]), 
    .Out(NPCOut), 
    .PC8(NPCPC8)
    );
	 
	 MUX2 #5 MA3D (
    .In0(5'b0), 
    .In1(5'd31), 
    .Sel(GenD), 
    .Out(A3DE)
    );
	 
	 MUX2 MWDD (
    .In0(32'bx), 
    .In1(NPCPC8), 
    .Sel(GenD), 
    .Out(WDDE)
    );

endmodule
