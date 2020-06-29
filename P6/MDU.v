`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:05 11/23/2019 
// Design Name: 
// Module Name:    MDU 
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
module MDU(
    input Clk,
    input Reset,
    input Start,
    input [1:0] MDUOp,
    input HIWrite,
    input LOWrite,
    input [31:0] A,
    input [31:0] B,
    output Busy,
    output reg [31:0] HI,
    output reg [31:0] LO
    );

	parameter MULU = 2'b00, MUL = 2'b01, DIVU = 2'b10, DIV = 2'b11;
	
	reg [31:0] HITmp, LOTmp;
	reg [3:0] cnt;

	always @ (posedge Clk) begin
		if (Reset) begin
			HI <= 0;
			LO <= 0;
			HITmp <= 0;
			LOTmp <= 0;
			cnt <= 0;
		end
		else if (Start) begin
			case (MDUOp)
				MULU: begin
					{HITmp, LOTmp} <= A * B;
					cnt = 5;
				end
				MUL: begin
					{HITmp, LOTmp} <= $signed(A) * $signed(B);
					cnt = 5;
				end
				DIVU: begin
					LOTmp <= A / B;
					HITmp <= A % B;
					cnt = 10;
				end
				DIV: begin
					LOTmp <= $signed(A) / $signed(B);
					HITmp <= $signed(A) % $signed(B);
					cnt = 10;
				end
			endcase
		end
		else if (HIWrite) HI <= A;
		else if (LOWrite) LO <= A;
		if (Reset == 0 && Start == 0 && cnt != 0) cnt <= cnt - 1; 
	end
	
	assign Busy = (cnt != 0);
	
	always @ (negedge Busy) begin
		HI <= HITmp;
		LO <= LOTmp;
	end

endmodule
