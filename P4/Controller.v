`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:08 11/09/2019 
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
    input Equal,
    input EQZ,
    input LTZ,
    output NPCOp,
    output RegWrite,
    output [3:0] ALUOp,
    output MemWrite,
    output [1:0] OpWidth,
    output LoadSigned,
    output [1:0] ExtOp,
    output [1:0] PCSrc,
    output [1:0] RegDst,
    output [1:0] RegSrc,
    output ALUSrc
    );

	parameter R = 0,
				 ADDU = 6'b100001,
				 SUBU = 6'b100011,
				 ORI = 6'b001101,
				 LW = 6'b100011,
				 SW = 6'b101011,
				 BEQ = 6'b000100,
				 LUI = 6'b001111,
				 JAL = 6'b000011,
				 JR = 6'b001000,
				 NOP = 0;

	wire addu, subu, ori, lw, sw, beq, lui, jal, jr, nop;
	
	assign addu = (Op == R) && (Funct == ADDU),
			 subu = (Op == R) && (Funct == SUBU),
			 ori = (Op == ORI),
			 lw = (Op == LW),
			 sw = (Op == SW),
			 beq = (Op == BEQ),
			 lui = (Op == LUI),
			 jal = (Op == JAL),
			 jr = (Op == R) && (Funct == JR),
			 nop = (Op == R) && (Funct == NOP);
	
	assign NPCOp = jal,
			 RegWrite = addu || subu || ori || lw || lui || jal,
			 ALUOp = ori ? 4'b0010 :
						subu ? 4'b0001 :
						4'b0000,
			 MemWrite = sw,
			 OpWidth = 0,
			 LoadSigned = 1'bx,
			 ExtOp = lui ? 2'b10 :
						(lw || sw || beq) ? 2'b01 :
						2'b00,
			 PCSrc = jr ? 2'b10 :
						(jal || (beq && Equal)) ? 2'b01 :
						2'b00,
			 RegDst = jal ? 2'b10 :
						 (addu || subu) ? 2'b01 :
						 2'b00,
			 RegSrc = jal ? 2'b10 :
						 lw ? 2'b01 :
						 2'b00,
			 ALUSrc = ori || lw || sw || lui;

endmodule
