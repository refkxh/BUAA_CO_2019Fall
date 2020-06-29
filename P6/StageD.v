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
	 input [4:0] A3W,
	 input [31:0] WDW,
	 input [31:0] PCW,
    output [31:0] RD1DE,
    output [31:0] RD2DE,
    output [31:0] Imm32DE,
    output [4:0] A3D,
    output [31:0] WDDE,
	 output [1:0] PCSrc,
	 output [31:0] NPCOut,
	 output MD,
	 output D1Use,
	 output D2Use
    );

	wire [31:0] NPCPC8;
	wire [1:0] ExtOp, A3Sel;
	
	Controller ControllerD (
    .Op(InstrD[31:26]), 
    .Funct(InstrD[5:0]), 
	 .RT(InstrD[20:16]), 
    .Equal(Equal), 
    .LTZ(LTZ), 
    .EQZ(EQZ), 
    .NPCOp(NPCOp), 
    .ExtOp(ExtOp), 
    .PCSrc(PCSrc), 
	 .A3Sel(A3Sel), 
    .GenD(GenD), 
	 .MD(MD), 
	 .D1Use(D1Use), 
	 .D2Use(D2Use)
    );
	 
	 GRF GRFInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .A1(InstrD[25:21]), 
    .A2(InstrD[20:16]), 
    .A3(A3W), 
    .WD(WDW), 
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
	 
	 MUX4 #5 MA3 (
    .In0(5'b0), 
    .In1(5'd31), 
	 .In2(InstrD[15:11]), 
	 .In3(InstrD[20:16]), 
    .Sel(A3Sel), 
    .Out(A3D)
    );
	 
	 MUX2 MWDD (
    .In0(32'bz), 
    .In1(NPCPC8), 
    .Sel(GenD), 
    .Out(WDDE)
    );

endmodule
