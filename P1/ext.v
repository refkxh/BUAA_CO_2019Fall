`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:59 10/17/2019 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output reg [31:0] ext
    );

	parameter SIGNEDEXT = 2'b00, UNSIGNEDEXT = 2'b01, LU = 2'b10, EXTSL2 = 2'b11;
	
	always @ * begin
		case (EOp) 
			SIGNEDEXT: begin
				ext[15:0] = imm;
				ext[31:16] = {16{imm[15]}};
			end
			UNSIGNEDEXT: begin
				ext[15:0] = imm;
				ext[31:16] = 0;
			end
			LU: begin
				ext[31:16] = imm;
				ext[15:0] = 0;
			end
			EXTSL2: begin
				ext[15:0] = imm;
				ext[31:16] = {16{imm[15]}};
				ext = ext << 2;
			end
		endcase
	end

endmodule
