`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:26 11/20/2019 
// Design Name: 
// Module Name:    HZD 
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
module HZD(
    input Clk,
	 input Reset,
	 input [4:0] A1D,
	 input [4:0] A2D,
    input [31:0] RD1D,
    input [31:0] RD2D,
	 input D1Use,
	 input D2Use,
    input [4:0] A1E,
	 input [4:0] A2E,
    input [31:0] RD1E,
    input [31:0] RD2E,
	 input E1Use,
	 input E2Use,
    input [4:0] A3E,
    input [31:0] WDE,
    input [4:0] A2M,
    input [31:0] RD2M,
	 input M2Use,
    input [4:0] A3M,
    input [31:0] WDM,
    input [4:0] A3W,
    input [31:0] WDW,
	 input Start,
	 input Busy,
	 input MD,
    output [31:0] ForwardD1,
    output [31:0] ForwardD2,
    output [31:0] ForwardE1,
    output [31:0] ForwardE2,
    output [31:0] ForwardM2,
	 output PCEn,
    output DRegEn,
	 output ERegEn,
    output ERegFlush,
	 output MRegFlush
    );

	wire StallD, StallE;
	reg [4:0] A3T;
   reg [31:0] WDT;
	
	always @ (posedge Clk) begin
		if (Reset) begin
			A3T <= 0;
			WDT <= 0;
		end
		else begin
			A3T <= A3W;
			WDT <= WDW;
		end
	end
	
	assign StallD = ((D1Use && A1D == A3E && A3E != 0 && WDE === 32'bz) ||
						 (D1Use && A1D == A3M && A3M != 0 && WDM === 32'bz && !(A1D == A3E && A3E != 0 && WDE !== 32'bz)) ||
						 (D2Use && A2D == A3E && A3E != 0 && WDE === 32'bz) ||
						 (D2Use && A2D == A3M && A3M != 0 && WDM === 32'bz && !(A2D == A3E && A3E != 0 && WDE !== 32'bz)) ||
						 ((Start || Busy) && MD)) && !StallE;
	assign StallE = (E1Use && A1E == A3M && A3M != 0 && WDM === 32'bz) ||
						 (E2Use && A2E == A3M && A3M != 0 && WDM === 32'bz);
	
	assign PCEn = ~(StallD || StallE);
	assign DRegEn = ~(StallD || StallE);
	assign ERegEn = ~StallE;
	assign ERegFlush = StallD;
	assign MRegFlush = StallE;
	
	assign ForwardD1 = (A1D == A3E && A3E != 0) ? WDE :
							 (A1D == A3M && A3M != 0) ? WDM :
							 RD1D;
	assign ForwardD2 = (A2D == A3E && A3E != 0) ? WDE :
							 (A2D == A3M && A3M != 0) ? WDM :
							 RD2D;
	assign ForwardE1 = (A1E == A3M && A3M != 0) ? WDM :
							 (A1E == A3W && A3W != 0) ? WDW :
							 (A1E == A3T && A3T != 0) ? WDT :
							 RD1E;
	assign ForwardE2 = (A2E == A3M && A3M != 0) ? WDM :
							 (A2E == A3W && A3W != 0) ? WDW :
							 (A2E == A3T && A3T != 0) ? WDT :
							 RD2E;
	assign ForwardM2 = (A2M == A3W && A3W != 0) ? WDW :
							 RD2M;

endmodule
