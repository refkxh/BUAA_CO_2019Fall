`timescale 1ns / 1ps
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:33 11/20/2019 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] Op,
    input [5:0] Funct,
	 input [4:0] RS,
	 input [4:0] RT,
    input Equal,
    input LTZ,
    input EQZ,
    output NPCOp,
    output [1:0] ExtOp,
    output [1:0] PCSrc,
	 output [1:0] A3Sel,
    output GenD,
	 output MD,
	 output D1Use,
	 output D2Use,
	 output BD,
	 output RI,
	 output [3:0] ALUOp,
	 output ALUSrcA,
    output ALUSrcB,
	 output Start,
	 output [1:0] MDUOp,
	 output HIWrite,
	 output LOWrite,
    output [1:0] GenE,
	 output E1Use,
	 output E2Use,
	 output Ov,
	 output Ld,
	 output St,
	 output MemWrite,
    output [1:0] OpWidth,
    output LoadSigned,
    output [1:0] GenM,
	 output M2Use,
	 output eret,
	 output CP0Write
    );

	wire addu, subu, ori, lw, sw, beq, lui, j, jal, jr, lb, lbu, lh, lhu, sb, sh, add, sub, mult, multu,
		  div, divu, sll, srl, sra, sllv, srlv, srav, andw, orw, xorw, norw, addi, addiu, andi, xori, slt,
		  slti, sltiu, sltu, bne, blez, bgtz, bltz, bgez, jalr, mfhi, mflo, mthi, mtlo, mfc0, mtc0;
	
	assign addu = (Op == `R) && (Funct == `ADDU),
			 subu = (Op == `R) && (Funct == `SUBU),
			 ori = (Op == `ORI),
			 lw = (Op == `LW),
			 sw = (Op == `SW),
			 beq = (Op == `BEQ),
			 lui = (Op == `LUI),
			 j = (Op == `J),
			 jal = (Op == `JAL),
			 jr = (Op == `R) && (Funct == `JR),
			 lb = (Op == `LB),
			 lbu = (Op == `LBU),
			 lh = (Op == `LH),
			 lhu = (Op == `LHU),
			 sb = (Op == `SB),
			 sh = (Op == `SH),
			 add = (Op == `R) && (Funct == `ADD),
			 sub = (Op == `R) && (Funct == `SUB),
			 mult = (Op == `R) && (Funct == `MULT),
			 multu = (Op == `R) && (Funct == `MULTU),
			 div = (Op == `R) && (Funct == `DIV),
			 divu = (Op == `R) && (Funct == `DIVU),
			 sll = (Op == `R) && (Funct == `SLL),
			 srl = (Op == `R) && (Funct == `SRL),
			 sra = (Op == `R) && (Funct == `SRA),
			 sllv = (Op == `R) && (Funct == `SLLV),
			 srlv = (Op == `R) && (Funct == `SRLV),
			 srav = (Op == `R) && (Funct == `SRAV),
			 andw = (Op == `R) && (Funct == `AND),
			 orw = (Op == `R) && (Funct == `OR),
			 xorw = (Op == `R) && (Funct == `XOR),
			 norw = (Op == `R) && (Funct == `NOR),
			 addi = (Op == `ADDI),
			 addiu = (Op == `ADDIU),
			 andi = (Op == `ANDI),
			 xori = (Op == `XORI),
			 slt = (Op == `R) && (Funct == `SLT),
			 slti = (Op == `SLTI),
			 sltiu = (Op == `SLTIU),
			 sltu = (Op == `R) && (Funct == `SLTU),
			 bne = (Op == `BNE),
			 blez = (Op == `BLEZ),
			 bgtz = (Op == `BGTZ),
			 bltz = (Op == `BLTZ) && (RT == 0),
			 bgez = (Op == `BGEZ) && (RT == 5'b00001),
			 jalr = (Op == `R) && (Funct == `JALR),
			 mfhi = (Op == `R) && (Funct == `MFHI),
			 mflo = (Op == `R) && (Funct == `MFLO),
			 mthi = (Op == `R) && (Funct == `MTHI),
			 mtlo = (Op == `R) && (Funct == `MTLO),
			 eret = (Op == `COP0) && (Funct == `ERET),
			 mfc0 = (Op == `COP0) && (RS == 5'b0),
			 mtc0 = (Op == `COP0) && (RS == 5'b00100);
	
	assign NPCOp = j || jal,
			 ExtOp = lui ? 2'b10 :
						(lw || sw || beq || lb || lbu || lh || lhu || sb || sh || addi || addiu ||
						slti || sltiu || bne || blez || bgtz || bltz || bgez) ? 2'b01 :
						2'b00,
			 PCSrc = (jr || jalr) ? 2'b10 :
						(j || jal || (beq && Equal) || (bne && !Equal) || (blez && (LTZ || EQZ)) ||
						(bgtz && (!LTZ && !EQZ)) || (bltz && LTZ) || (bgez && !LTZ)) ? 2'b01 :
						2'b00,
			 A3Sel = (ori || lw || lui || lb || lbu || lh || lhu || addi || addiu || andi || xori || slti || sltiu || mfc0) ? 2'b11 :
						(addu || subu || add || sub || sll || srl || sra || sllv || srlv || srav ||
						andw || orw || xorw || norw || slt || sltu || jalr || mfhi || mflo) ? 2'b10 :
						jal ? 2'b01 :
						2'b00,
			 GenD = jal || jalr,
			 MD = mult || multu || div || divu || mfhi || mflo || mthi || mtlo,
			 D1Use = beq || jr || bne || blez || bgtz || bltz || bgez || jalr,
			 D2Use = beq || bne,
			 BD = beq || j || jal || jr || bne || blez || bgtz || bltz || bgez || jalr,
			 RI = !(addu || subu || ori || lw || sw || beq || lui || j || jal || jr || lb || lbu || lh || lhu || sb || sh || add || sub || mult || multu ||
					div || divu || sll || srl || sra || sllv || srlv || srav || andw || orw || xorw || norw || addi || addiu || andi || xori || slt ||
					slti || sltiu || sltu || bne || blez || bgtz || bltz || bgez || jalr || mfhi || mflo || mthi || mtlo || mfc0 || mtc0 || eret);
			 
	assign ALUOp = (sltu || sltiu) ? 4'b1010 :
						(slt || slti) ? 4'b1001 :
						(sra || srav) ? 4'b1000 :
						(srl || srlv) ? 4'b0111 :
						(sll || sllv) ? 4'b0110 :
						(xorw || xori) ? 4'b0101 :
						norw ? 4'b0100 :
						(andw || andi) ? 4'b0011 :
						(ori || orw) ? 4'b0010 :
						(subu || sub) ? 4'b0001 :
						4'b0000,
			 ALUSrcA = sll || srl || sra,
			 ALUSrcB = ori || lw || sw || lui || lb || lbu || lh || lhu || sb || sh || addi || addiu ||
						  andi || xori || slti || sltiu,
			 Start = mult || multu || div || divu,
			 MDUOp = div ? 2'b11 :
						divu ? 2'b10 :
						mult ? 2'b01 :
						2'b00,
			 HIWrite = mthi,
			 LOWrite = mtlo,
			 GenE = mflo ? 2'b11 :
					  mfhi ? 2'b10 :
					  (addu || subu || ori || lui || add || sub || sll || srl || sra || sllv || srlv ||
					  srav || andw || orw || xorw || norw || addi || addiu || andi || xori || slt ||
					  slti || sltiu || sltu) ? 2'b01 :
					  2'b00,
			 E1Use = addu || subu || ori || lw || sw || lb || lbu || lh || lhu || sb || sh || add ||
			 sub || mult || multu || div || divu || sllv || srlv || srav || andw || orw || xorw ||
			 norw || addi || addiu || andi || xori || slt || slti || sltiu || sltu || mthi || mtlo,
			 E2Use = addu || subu || add || sub || mult || multu || div || divu || sll || srl || sra ||
			 sllv || srlv || srav || andw || orw || xorw || norw || slt || sltu,
			 Ov = add || addi || sub,
			 Ld = lw || lh || lhu || lb || lbu,
			 St = sw || sh || sb;
			 
			 
	assign MemWrite = sw || sb || sh,
			 OpWidth = (sb || lb || lbu) ? 2'b10 :
						  (sh || lh || lhu) ? 2'b01 :
						  2'b00,
			 LoadSigned = lb || lh,
			 GenM = mfc0 ? 2'b10 :
					  (lw || lb || lbu || lh || lhu) ? 2'b01 :
					  2'b00,
			 M2Use = sw || sb || sh || mtc0,
			 CP0Write = mtc0;

endmodule
