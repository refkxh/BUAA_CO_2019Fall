`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:48 11/09/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] Imm16,
    input [1:0] ExtOp,
    output reg [31:0] Imm32
    );

	always @ * begin
		case (ExtOp)
			0: Imm32 = {16'b0, Imm16};
			1: Imm32 = {{16{Imm16[15]}}, Imm16};
			2: Imm32 = {Imm16, 16'b0};
			default: Imm32 = 32'bx;
		endcase
	end

endmodule
