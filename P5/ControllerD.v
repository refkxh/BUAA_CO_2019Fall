`timescale 1ns / 1ps
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:51 11/16/2019 
// Design Name: 
// Module Name:    ControllerD 
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
module ControllerD(
    input [5:0] Op,
    input [5:0] Funct,
    input Equal,
    input LTZ,
    input EQZ,
    output NPCOp,
    output [1:0] ExtOp,
    output [1:0] PCSrc,
    output GenD
    );

	wire addu, subu, ori, lw, sw, beq, lui, j, jal, jr, nop;
	
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
			 nop = (Op == `R) && (Funct == `NOP);
	
	assign NPCOp = j || jal,
			 ExtOp = lui ? 2'b10 :
						(lw || sw || beq) ? 2'b01 :
						2'b00,
			 PCSrc = jr ? 2'b10 :
						(j || jal || (beq && Equal)) ? 2'b01 :
						2'b00,
			 GenD = jal;

endmodule
