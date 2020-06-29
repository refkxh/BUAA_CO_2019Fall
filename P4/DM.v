`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:30:57 11/09/2019 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input Clk,
    input Reset,
    input [31:0] Addr,
    input [31:0] WD,
    input MemWrite,
    input [1:0] OpWidth,
    input LoadSigned,
    input [31:0] WPC,
    output reg [31:0] RD
    );

	parameter WORD = 2'b00, HALF = 2'b01, BYTE = 2'b10;
	
	reg [31:0] DMReg [0:1023];
	integer i;
	
	always @ (posedge Clk) begin
		if (Reset) begin
			for (i = 0; i < 1024; i = i + 1) begin
				DMReg[i] <= 0;
			end
		end
		else if (MemWrite) begin
			case (OpWidth)
				WORD: begin
					DMReg[Addr[11:2]] <= WD;
					$display("@%h: *%h <= %h", WPC, Addr, WD);
				end
				HALF: begin
					case (Addr[1])
						1: DMReg[Addr[11:2]][31:16] <= WD[15:0];
						0: DMReg[Addr[11:2]][15:0] <= WD[15:0];
					endcase
				end
				BYTE: begin
					case (Addr[1:0])
						3: DMReg[Addr[11:2]][31:24] <= WD[7:0];
						2: DMReg[Addr[11:2]][23:16] <= WD[7:0];
						1: DMReg[Addr[11:2]][15:8] <= WD[7:0];
						0: DMReg[Addr[11:2]][7:0] <= WD[7:0];
					endcase
				end
			endcase
		end
	end
	
	always @ * begin
		case (OpWidth)
			WORD: RD = DMReg[Addr[11:2]];
			HALF: begin
				case (Addr[1])
					1: RD[15:0] = DMReg[Addr[11:2]][31:16];
					0: RD[15:0] = DMReg[Addr[11:2]][15:0];
				endcase
				case (LoadSigned)
					1: RD[31:16] = {16{RD[15]}};
					0: RD[31:16] = 0;
				endcase
			end
			BYTE: begin
				case (Addr[1:0])
					3: RD[7:0] = DMReg[Addr[11:2]][31:24];
					2: RD[7:0] = DMReg[Addr[11:2]][23:16];
					1: RD[7:0] = DMReg[Addr[11:2]][15:8];
					0: RD[7:0] = DMReg[Addr[11:2]][7:0];
				endcase
				case (LoadSigned)
					1: RD[31:8] = {24{RD[7]}};
					0: RD[31:8] = 0;
				endcase
			end
			default: RD = 32'bx;
		endcase
	end

endmodule
