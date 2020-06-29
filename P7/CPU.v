`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:33 11/30/2019 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
    input Clk,
    input Reset,
    input [7:2] HWInt,
    input [31:0] PrRD,
	 output PrWE,
    output [31:2] PrAddr,
    output [31:0] PrWD,
	 output [31:0] addr
    );

	wire [31:0] InstrD, InstrE, InstrM, RD1DE, RD2DE, RD1E, RD2E, WDE, RD2M, WDM, WDW,
					ForwardD1, ForwardD2, ForwardE1, ForwardE2, ForwardM2, NPCOut, InstrFD, PC4FD, PCFD,
					PC4D, PCD, PCW, Imm32DE, WDDE, Imm32E, PCE, ALUOutEM, RD2EM, WDEM, ALUOutM, PCM, WDMW, EPC;
	wire [4:0] A3D, A3E, A3M, A3W;
	wire [1:0] PCSrc;
	wire [6:2] ExcCodeFD, ExcCodeD, ExcCodeDE, ExcCodeE, ExcCodeEM, ExcCodeM;
	
	assign PrAddr = ALUOutM[31:2], PrWD = ForwardM2;
	 
	 HZD HZDInstance (
    .Clk(Clk), 
	 .Reset(Reset), 
	 .A1D(InstrD[25:21]), 
    .A2D(InstrD[20:16]), 
    .RD1D(RD1DE), 
    .RD2D(RD2DE), 
	 .D1Use(D1Use), 
	 .D2Use(D2Use), 
    .A1E(InstrE[25:21]), 
    .A2E(InstrE[20:16]), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
	 .E1Use(E1Use), 
	 .E2Use(E2Use), 
    .A3E(A3E), 
    .WDE(WDE), 
    .A2M(InstrM[20:16]), 
    .RD2M(RD2M), 
	 .M2Use(M2Use), 
    .A3M(A3M), 
    .WDM(WDM), 
    .A3W(A3W), 
    .WDW(WDW), 
	 .Start(Start), 
	 .Busy(Busy), 
	 .MD(MD), 
    .ForwardD1(ForwardD1), 
    .ForwardD2(ForwardD2), 
    .ForwardE1(ForwardE1), 
    .ForwardE2(ForwardE2), 
    .ForwardM2(ForwardM2), 
	 .PCEn(PCEn), 
	 .DRegEn(DRegEn), 
	 .ERegEn(ERegEn), 
	 .ERegFlush(ERegFlush), 
	 .MRegFlush(MRegFlush)
    );
	
	StageF StageFInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .PCEn(PCEn || eret || IntReq), 
	 .IntReq(IntReq), 
	 .eret(eret), 
    .PCSrc(PCSrc), 
    .NPCOut(NPCOut), 
    .ForwardD1(ForwardD1), 
	 .EPC(EPC), 
    .InstrFD(InstrFD), 
    .PC4FD(PC4FD), 
    .PCFD(PCFD), 
	 .ExcCodeFD(ExcCodeFD)
    );
	 
	 DReg DRegInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .DRegEn(DRegEn), 
	 .DRegFlush(IntReq || eret), 
	 .BDF(BD), 
    .InstrF(InstrFD), 
    .PC4F(PC4FD), 
    .PCF(PCFD), 
	 .ExcCodeF(ExcCodeFD), 
	 .BDD(BDD), 
    .InstrD(InstrD), 
    .PC4D(PC4D), 
    .PCD(PCD), 
	 .ExcCodeD(ExcCodeD)
    );
	 
	 StageD StageDInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .InstrD(InstrD), 
    .PC4D(PC4D), 
    .ForwardD1(ForwardD1), 
    .ForwardD2(ForwardD2), 
	 .ExcCodeD(ExcCodeD), 
    .A3W(A3W), 
    .WDW(WDW), 
    .PCW(PCW), 
    .RD1DE(RD1DE), 
    .RD2DE(RD2DE), 
    .Imm32DE(Imm32DE), 
    .A3D(A3D), 
    .WDDE(WDDE), 
    .PCSrc(PCSrc), 
    .NPCOut(NPCOut), 
	 .MD(MD), 
	 .D1Use(D1Use), 
	 .D2Use(D2Use), 
	 .BD(BD), 
	 .ExcCodeDE(ExcCodeDE)
    );
	 
	 EReg ERegInstance (
    .Clk(Clk), 
    .Reset(Reset), 
	 .ERegEn(ERegEn), 
    .ERegFlush(ERegFlush || IntReq || eret), 
	 .BDD(BDD), 
    .InstrD(InstrD), 
    .RD1D(RD1DE), 
    .RD2D(RD2DE), 
    .Imm32D(Imm32DE), 
    .A3D(A3D), 
    .WDD(WDDE), 
    .PCD(PCD), 
	 .ExcCodeD(ExcCodeDE), 
	 .BDE(BDE), 
    .InstrE(InstrE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .Imm32E(Imm32E), 
    .A3E(A3E), 
    .WDE(WDE), 
    .PCE(PCE), 
	 .ExcCodeE(ExcCodeE)
    );
	 
	 StageE StageEInstance (
    .Clk(Clk), 
    .Reset(Reset), 
	 .IntReq(IntReq), 
	 .eret(eret), 
	 .InstrE(InstrE), 
    .ForwardE1(ForwardE1), 
    .ForwardE2(ForwardE2), 
    .Imm32E(Imm32E),  
    .WDE(WDE), 
	 .ExcCodeE(ExcCodeE), 
    .ALUOutEM(ALUOutEM), 
    .RD2EM(RD2EM), 
    .WDEM(WDEM), 
	 .E1Use(E1Use), 
	 .E2Use(E2Use),
	 .Start(Start), 
	 .Busy(Busy), 
	 .ExcCodeEM(ExcCodeEM)
    );

	MReg MRegInstance (
    .Clk(Clk), 
    .Reset(Reset), 
	 .BDE(BDE), 
    .InstrE(InstrE), 
	 .MRegFlush(MRegFlush || IntReq || eret), 
    .ALUOutE(ALUOutEM), 
    .RD2E(RD2EM), 
    .A3E(A3E), 
    .WDE(WDEM), 
    .PCE(PCE), 
	 .ExcCodeE(ExcCodeEM), 
	 .BDM(BDM), 
    .InstrM(InstrM), 
    .ALUOutM(ALUOutM), 
    .RD2M(RD2M), 
    .A3M(A3M), 
    .WDM(WDM), 
    .PCM(PCM), 
	 .ExcCodeM(ExcCodeM)
    );
	 
	 StageM StageMInstance (
    .Clk(Clk), 
    .Reset(Reset), 
	 .BDM(BDM), 
    .InstrM(InstrM), 
    .ALUOutM(ALUOutM), 
    .ForwardM2(ForwardM2), 
    .WDM(WDM), 
    .PCM(PCM), 
	 .PrRD(PrRD), 
	 .HWInt(HWInt), 
	 .ExcCodeM(ExcCodeM), 
	 .PCF(PCFD), 
	 .BDD(BDD), 
	 .PCD(PCD), 
	 .ExcCodeD(ExcCodeD), 
	 .BDE(BDE), 
	 .PCE(PCE), 
	 .ExcCodeE(ExcCodeE), 
    .WDMW(WDMW), 
	 .M2Use(M2Use), 
	 .PrWE(PrWE), 
	 .IntReq(IntReq), 
	 .eret(eret), 
	 .EPC(EPC), 
	 .addr(addr)
    );
	 
	 WReg WRegInstance (
    .Clk(Clk), 
    .Reset(Reset), 
	 .WRegFlush(IntReq), 
    .A3M(A3M), 
    .WDM(WDMW), 
    .PCM(PCM), 
    .A3W(A3W), 
    .WDW(WDW), 
    .PCW(PCW)
    );

endmodule
