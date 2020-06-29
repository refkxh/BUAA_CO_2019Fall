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
	 input DRegFlush,
	 input BDF,
    input [31:0] InstrF,
    input [31:0] PC4F,
	 input [31:0] PCF,
	 input [6:2] ExcCodeF,
	 output reg BDD,
    output reg [31:0] InstrD,
    output reg [31:0] PC4D,
	 output reg [31:0] PCD,
	 output reg [6:2] ExcCodeD
    );

	always @ (posedge Clk) begin
		if (Reset || DRegFlush) begin
			BDD <= 0;
			InstrD <= 0;
			PC4D <= 0;
			PCD <= 0;
			ExcCodeD <= 0;
		end
		else if (DRegEn) begin
			BDD <= BDF;
			InstrD <= InstrF;
			PC4D <= PC4F;
			PCD <= PCF;
			ExcCodeD <= ExcCodeF;
		end
	end

endmodule
