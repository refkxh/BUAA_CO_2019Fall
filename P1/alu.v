`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:26 10/17/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );

	parameter PLUS = 3'b000, MINUS = 3'b001, AND = 3'b010, OR = 3'b011, SRL = 3'b100, SRA = 3'b101;
	
	always @ * begin
		case (ALUOp)
			PLUS:  C = A + B;
			MINUS:  C = A - B;
			AND:  C = A & B;
			OR:  C = A | B;
			SRL:  C = A >> B;
			SRA:  C = $signed(A) >>> B;
		endcase
	end

endmodule
