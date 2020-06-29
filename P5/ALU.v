`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:12:08 11/09/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output reg [31:0] Result
    );

	parameter PLUS = 4'b0000,
	          MINUS = 4'b0001,
				 OR = 4'b0010,
				 AND = 4'b0011,
				 NOR = 4'b0100,
				 XOR = 4'b0101,
				 SLL = 4'b0110,
				 SRL = 4'b0111,
				 SRA = 4'b1000,
				 SLT = 4'b1001,
				 SLTU = 4'b1010;
	
	always @ * begin
		case (ALUOp)
			PLUS: Result = A + B;
			MINUS: Result = A - B;
			OR: Result = A | B;
			AND: Result = A & B;
			NOR: Result = ~(A | B);
			XOR: Result = A ^ B;
			SLL: Result = A << B[4:0];
			SRL: Result = A >> B[4:0];
			SRA: Result = $signed(A) >>> B[4:0];
			SLT: Result = ($signed(A) < $signed(B)) ? 1 : 0;
			SLTU: Result = (A < B) ? 1 : 0;
			default: Result = 32'bx;
		endcase
	end

endmodule
