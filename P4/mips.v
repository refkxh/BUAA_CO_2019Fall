`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:24 11/07/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	wire [31:0] MPCOut, PCOut, AdderOut, GRFRD1, GRFRD2, Instr, NPCOut, MRegSrcOut, ALUResult, DMRD, EXTImm32, MALUSrcOut;
	wire [4:0] MRegDstOut;
	wire [3:0] ALUOp;
	wire [1:0] OpWidth, ExtOp, PCSrc, RegDst, RegSrc;
	
	Controller ControllerInstance (
    .Op(Instr[31:26]), 
    .Funct(Instr[5:0]), 
    .Equal(Equal), 
    .EQZ(EQZ), 
    .LTZ(LTZ), 
    .NPCOp(NPCOp), 
    .RegWrite(RegWrite), 
    .ALUOp(ALUOp), 
    .MemWrite(MemWrite), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .ExtOp(ExtOp), 
    .PCSrc(PCSrc), 
    .RegDst(RegDst), 
    .RegSrc(RegSrc), 
    .ALUSrc(ALUSrc)
    );
	
	MUX3 MPC (
    .In0(AdderOut), 
    .In1(NPCOut), 
    .In2(GRFRD1), 
    .Sel(PCSrc), 
    .Out(MPCOut)
    );
	
	PC PCInstance (
    .Clk(clk), 
    .Reset(reset), 
    .En(1'b1), 
    .In(MPCOut), 
    .Out(PCOut)
    );
	 
	 IM IMInstance (
    .Addr(PCOut), 
    .Instr(Instr)
    );
	 
	 Adder AdderInstance (
    .In(PCOut), 
    .Out(AdderOut)
    );
	 
	 NPC NPCInstance (
    .NPCOp(NPCOp), 
    .PC4(AdderOut), 
    .Imm26(Instr[25:0]), 
    .Out(NPCOut)
    );
	 
	 MUX3 #5 MRegDst (
    .In0(Instr[20:16]), 
    .In1(Instr[15:11]), 
    .In2(5'd31), 
    .Sel(RegDst), 
    .Out(MRegDstOut)
    );
	 
	 MUX3 MRegSrc (
    .In0(ALUResult), 
    .In1(DMRD), 
    .In2(AdderOut), 
    .Sel(RegSrc), 
    .Out(MRegSrcOut)
    );
	 
	 GRF GRFInstance (
    .Clk(clk), 
    .Reset(reset), 
    .A1(Instr[25:21]), 
    .A2(Instr[20:16]), 
    .A3(MRegDstOut), 
    .WD(MRegSrcOut), 
    .RegWrite(RegWrite), 
    .WPC(PCOut), 
    .RD1(GRFRD1), 
    .RD2(GRFRD2)
    );
	 
	 CMP CMPInstance (
    .A(GRFRD1), 
    .B(GRFRD2), 
    .Equal(Equal), 
    .LTZ(LTZ), 
    .EQZ(EQZ)
    );
	 
	 EXT EXTInstance (
    .Imm16(Instr[15:0]), 
    .ExtOp(ExtOp), 
    .Imm32(EXTImm32)
    );
	 
	 MUX2 MALUSrc (
    .In0(GRFRD2), 
    .In1(EXTImm32), 
    .Sel(ALUSrc), 
    .Out(MALUSrcOut)
    );
	 
	 ALU ALUInstance (
    .A(GRFRD1), 
    .B(MALUSrcOut), 
    .ALUOp(ALUOp), 
    .Result(ALUResult)
    );
	 
	 DM DMInstance (
    .Clk(clk), 
    .Reset(reset), 
    .Addr(ALUResult), 
    .WD(GRFRD2), 
    .MemWrite(MemWrite), 
    .OpWidth(OpWidth), 
    .LoadSigned(LoadSigned), 
    .WPC(PCOut), 
    .RD(DMRD)
    );

endmodule
