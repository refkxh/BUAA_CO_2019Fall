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
	 input DMClk,
    input Reset,
	 input BDM,
    input [31:0] InstrM,
    input [31:0] ALUOutM,
    input [31:0] ForwardM2,
    input [31:0] WDM,
	 input [31:0] PCM,
	 input [31:0] PrRD,
	 input [7:2] HWInt,
	 input [6:2] ExcCodeM,
	 input [31:0] PCF,
	 input BDD,
	 input [31:0] PCD,
	 input [6:2] ExcCodeD,
	 input BDE,
	 input [31:0] PCE,
	 input [6:2] ExcCodeE,
    output [31:0] WDMW,
	 output PrWE,
	 output IntReq,
	 output eret,
	 output [31:0] EPC,
	 output [31:0] PrWD,
	 output [3:0] PrBE
    );

	parameter WORD = 2'b00, HALF = 2'b01, BYTE = 2'b10;
	
	wire [31:0] DMRD, DOut, RD, addr;
	wire [6:2] ExcCode;
	wire [3:0] EN;
	wire [1:0] OpWidth, GenM;
	wire HitDM, HitBridge;
	
	assign HitDM = (ALUOutM < 32'h2000), PrWE = MemWrite && HitBridge && !IntReq, 
			 HitBridge = (ALUOutM >= 32'h7F00 && ALUOutM <= 32'h7F0B) || (ALUOutM >= 32'h7F10 && ALUOutM <= 32'h7F2B) ||
							 (ALUOutM >= 32'h7F2C && ALUOutM <= 32'h7F43);
	assign ExcCode = (Ld && (((OpWidth == WORD) && (ALUOutM[1:0] != 0)) || ((OpWidth == HALF) && (ALUOutM[0] != 0))) && (ExcCodeM == 0)) ? 5'd4 :
						  (St && (((OpWidth == WORD) && (ALUOutM[1:0] != 0)) || ((OpWidth == HALF) && (ALUOutM[0] != 0))) && (ExcCodeM == 0)) ? 5'd5 :
						  (Ld && (OpWidth != WORD) && ((ALUOutM >= 32'h7F00 && ALUOutM <= 32'h7F0B) || (ALUOutM >= 32'h7F10 && ALUOutM <= 32'h7F2B)) && (ExcCodeM == 0)) ? 5'd4 :
						  (St && (OpWidth != WORD) && ((ALUOutM >= 32'h7F00 && ALUOutM <= 32'h7F0B) || (ALUOutM >= 32'h7F10 && ALUOutM <= 32'h7F2B)) && (ExcCodeM == 0)) ? 5'd5 :
						  (St && ((ALUOutM >= 32'h7F2C && ALUOutM <= 32'h7F33) || (ALUOutM >= 32'h7F40 && ALUOutM <= 32'h7F43)) && (ExcCodeM == 0)) ? 5'd5 :
						  (Ld && !(HitBridge || HitDM) && (ExcCodeM == 0)) ? 5'd4 :
						  (St && !(HitBridge || HitDM) && (ExcCodeM == 0)) ? 5'd5 :
						  (St && (ALUOutM >= 32'h7F00 && ALUOutM <= 32'h7F0B) && (ALUOutM[3:2] == 2'b10) && (ExcCodeM == 0)) ? 5'd5 :
						  ExcCodeM;
	assign addr = ((PCM != 0) || (ExcCodeM == 4)) ? {PCM[31:2], 2'b0} :
					  ((PCE != 0) || (ExcCodeE == 4)) ? {PCE[31:2], 2'b0} :
					  ((PCD != 0) || (ExcCodeD == 4)) ? {PCD[31:2], 2'b0} :
					  {PCF[31:2], 2'b0};
	assign BD = ((PCM != 0) || (ExcCodeM == 4)) ? BDM :
					((PCE != 0) || (ExcCodeE == 4)) ? BDE :
					((PCD != 0) || (ExcCodeD == 4)) ? BDD :
					1'b0;
	assign PrBE = EN;
	
	
	Controller ControllerM (
    .Op(InstrM[31:26]), 
    .Funct(InstrM[5:0]), 
	 .RS(InstrM[25:21]), 
	 .RT(InstrM[20:16]), 
    .MemWrite(MemWrite), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .GenM(GenM), 
	 .eret(eret), 
	 .CP0Write(CP0Write), 
	 .Ld(Ld), 
	 .St(St)
    );
	 
	 BE BEInstance (
    .OpWidth(OpWidth), 
    .Addr(ALUOutM[1:0]), 
    .DIn(ForwardM2), 
    .EN(EN), 
    .DOut(PrWD)
    );
	 
	 DM DMInstance (
    .clka(DMClk), 
    .rsta(Reset), 
    .wea((MemWrite && HitDM && !IntReq) ? EN : 4'b0), 
    .addra(ALUOutM[12:2]), 
    .dina(PrWD), 
    .douta(DMRD)
	 );
	 
	 DataExt DataExtInstance (
    .DIn(HitDM ? DMRD : PrRD), 
	 .Addr(ALUOutM[1:0]), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .DOut(RD)
    );
	 
	 CP0 CP0Instance (
    .Clk(Clk), 
    .Reset(Reset), 
    .Addr(InstrM[15:11]), 
    .DIn(ForwardM2), 
    .PC(addr[31:2]), 
    .ExcCode(ExcCode), 
    .HWInt(HWInt), 
    .WE(CP0Write), 
    .EXLSet(ExcCode != 0), 
    .EXLClr(eret), 
    .BD(BD), 
    .IntReq(IntReq), 
    .EPC(EPC), 
    .DOut(DOut)
    );
	 
	 MUX3 MWDM (
    .In0(WDM), 
    .In1(RD), 
	 .In2(DOut), 
    .Sel(GenM), 
    .Out(WDMW)
    );

endmodule
