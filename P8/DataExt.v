`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:32:17 12/13/2019 
// Design Name: 
// Module Name:    DataExt 
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
module DataExt(
    input [31:0] DIn,
	 input [1:0] Addr,
    input [1:0] OpWidth,
    input LoadSigned,
    output reg [31:0] DOut
    );

	parameter WORD = 2'b00, HALF = 2'b01, BYTE = 2'b10;
	
	always @ * begin
		case (OpWidth)
			WORD: DOut = DIn;
			HALF: begin
				case (Addr[1])
					1: DOut[15:0] = DIn[31:16];
					0: DOut[15:0] = DIn[15:0];
				endcase
				case (LoadSigned)
					1: DOut[31:16] = {16{DOut[15]}};
					0: DOut[31:16] = 0;
				endcase
			end
			BYTE: begin
				case (Addr)
					3: DOut[7:0] = DIn[31:24];
					2: DOut[7:0] = DIn[23:16];
					1: DOut[7:0] = DIn[15:8];
					0: DOut[7:0] = DIn[7:0];
				endcase
				case (LoadSigned)
					1: DOut[31:8] = {24{DOut[7]}};
					0: DOut[31:8] = 0;
				endcase
			end
			default: DOut = 32'bx;
		endcase
	end

endmodule
