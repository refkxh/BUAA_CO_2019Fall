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
    output reg [31:0] Result, 
	 output reg Overflow
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
			PLUS: begin
				{Overflow, Result} = {A[31], A} + {B[31], B};
				Overflow = (Overflow != Result[31]);
			end
			MINUS: begin
				{Overflow, Result} = {A[31], A} - {B[31], B};
				Overflow = (Overflow != Result[31]);
			end
			OR: begin
				Result = A | B;
				Overflow = 1'bx;
			end
			AND: begin
				Result = A & B;
				Overflow = 1'bx;
			end
			NOR: begin
				Result = ~(A | B);
				Overflow = 1'bx;
			end
			XOR: begin
				Result = A ^ B;
				Overflow = 1'bx;
			end
			SLL: begin
				Result = B << A[4:0];
				Overflow = 1'bx;
			end
			SRL: begin
				Result = B >> A[4:0];
				Overflow = 1'bx;
			end
			SRA: begin
				Result = $signed(B) >>> A[4:0];
				Overflow = 1'bx;
			end
			SLT: begin
				Result = ($signed(A) < $signed(B)) ? 1 : 0;
				Overflow = 1'bx;
			end
			SLTU: begin
				Result = (A < B) ? 1 : 0;
				Overflow = 1'bx;
			end
			default: {Overflow, Result} = 33'bx;
		endcase
	end

endmodule
