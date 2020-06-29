`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:56:55 11/16/2019 
// Design Name: 
// Module Name:    EReg 
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
module EReg(
	 input Clk,
	 input Reset,
	 input ERegEn,
	 input ERegFlush,
    input [31:0] InstrD,
    input [31:0] RD1D,
	 input [31:0] RD2D,
	 input [31:0] Imm32D,
	 input [4:0] A3D,
	 input [31:0] WDD,
	 input [31:0] PCD,
    output reg [31:0] InstrE,
    output reg [31:0] RD1E,
	 output reg [31:0] RD2E,
	 output reg [31:0] Imm32E,
	 output reg [4:0] A3E,
	 output reg [31:0] WDE,
	 output reg [31:0] PCE
    );

	always @ (posedge Clk) begin
		if (Reset || ERegFlush) begin
			InstrE <= 0;
			RD1E <= 0;
			RD2E <= 0;
			Imm32E <= 0;
			A3E <= 0;
			WDE <= 0;
			PCE <= 0;
		end
		else if (ERegEn) begin
			InstrE <= InstrD;
			RD1E <= RD1D;
			RD2E <= RD2D;
			Imm32E <= Imm32D;
			A3E <= A3D;
			WDE <= WDD;
			PCE <= PCD;
		end
	end

endmodule
