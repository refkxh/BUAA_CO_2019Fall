`timescale 1ns / 1ps
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:27 11/16/2019 
// Design Name: 
// Module Name:    ControllerE 
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
module ControllerE(
    input [5:0] Op,
    input [5:0] Funct,
    output [3:0] ALUOp,
    output ALUSrc,
    output [1:0] GenE
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
	
	assign ALUOp = ori ? 4'b0010 :
						subu ? 4'b0001 :
						4'b0000,
			 ALUSrc = ori || lw || sw || lui,
			 GenE = (ori || lui) ? 2'b10 :
					  (addu || subu) ? 2'b01 :
					  2'b00;

endmodule
