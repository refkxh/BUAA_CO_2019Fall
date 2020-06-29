`timescale 1ns / 1ps
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:07 11/16/2019 
// Design Name: 
// Module Name:    ControllerM 
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
module ControllerM(
    input [5:0] Op,
    input [5:0] Funct,
    output MemWrite,
    output [1:0] OpWidth,
    output LoadSigned,
    output GenM
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
	
	assign MemWrite = sw,
			 OpWidth = 0,
			 LoadSigned = 1'bx,
			 GenM = lw;

endmodule
