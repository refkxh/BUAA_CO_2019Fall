`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:36:35 12/13/2019 
// Design Name: 
// Module Name:    BE 
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
module BE(
    input [1:0] OpWidth,
	 input [1:0] Addr,
    input [31:0] DIn,
    output reg [3:0] EN,
    output reg [31:0] DOut
    );

	parameter WORD = 2'b00, HALF = 2'b01, BYTE = 2'b10;
	
	always @ * begin
		case (OpWidth)
			WORD: begin
				DOut = DIn;
				EN = 4'b1111;
			end
			HALF: begin
				case (Addr[1])
					1: begin
						EN = 4'b1100;
						DOut = {DIn[15:0], 16'b0};
					end
					0: begin
						EN = 4'b0011;
						DOut = {16'b0, DIn[15:0]};
					end
				endcase
			end
			BYTE: begin
				case (Addr)
					3: begin
						EN = 4'b1000;
						DOut = {DIn[7:0], 24'b0};
					end
					2: begin
						EN = 4'b0100;
						DOut = {8'b0, DIn[7:0], 16'b0};
					end
					1: begin
						EN = 4'b0010;
						DOut = {16'b0, DIn[7:0], 8'b0};
					end
					0: begin
						EN = 4'b0001;
						DOut = {24'b0, DIn[7:0]};
					end
				endcase
			end
			default: begin
				EN = 4'b0;
				DOut = 32'bx;
			end
		endcase
	end

endmodule
