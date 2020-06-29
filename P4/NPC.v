`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:00 11/09/2019 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input NPCOp,
    input [31:0] PC4,
    input [25:0] Imm26,
    output [31:0] Out
    );

	assign Out = NPCOp ? {PC4[31:28], Imm26, 2'b0} : (PC4 + {{14{Imm26[15]}}, Imm26[15:0], 2'b0});

endmodule
