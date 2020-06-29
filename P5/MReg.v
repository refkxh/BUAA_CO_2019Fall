`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:08:59 11/16/2019 
// Design Name: 
// Module Name:    MReg 
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
module MReg(
    input Clk,
	 input Reset,
	 input [31:0] InstrE,
    input [31:0] ALUOutE,
    input [31:0] RD2E,
    input [4:0] A3E,
    input [31:0] WDE,
	 input [31:0] PCE,
    output reg [31:0] InstrM,
    output reg [31:0] ALUOutM,
    output reg [31:0] RD2M,
    output reg [4:0] A3M,
    output reg [31:0] WDM,
	 output reg [31:0] PCM
    );

	always @ (posedge Clk) begin
		if (Reset) begin
			InstrM <= 0;
			ALUOutM <= 0;
			RD2M <= 0;
			A3M <= 0;
			WDM <= 0;
			PCM <= 0;
		end
		else begin
			InstrM <= InstrE;
			ALUOutM <= ALUOutE;
			RD2M <= RD2E;
			A3M <= A3E;
			WDM <= WDE;
			PCM <= PCE;
		end
	end

endmodule
