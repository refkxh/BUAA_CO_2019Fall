`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:41 11/16/2019 
// Design Name: 
// Module Name:    DReg 
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
module DReg(
	 input Clk,
	 input Reset,
	 input DRegEn,
    input [31:0] InstrF,
    input [31:0] PC4F,
	 input [31:0] PCF,
    output reg [31:0] InstrD,
    output reg [31:0] PC4D,
	 output reg [31:0] PCD
    );

	always @ (posedge Clk) begin
		if (Reset) begin
			InstrD <= 0;
			PC4D <= 0;
			PCD <= 0;
		end
		else if (DRegEn) begin
			InstrD <= InstrF;
			PC4D <= PC4F;
			PCD <= PCF;
		end
	end

endmodule
