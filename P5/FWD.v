`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:46 11/16/2019 
// Design Name: 
// Module Name:    FWD 
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
module FWD(
    input [4:0] A1D,
	 input [4:0] A2D,
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [4:0] A1E,
	 input [4:0] A2E,
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [4:0] A3E,
    input [31:0] WDE,
    input [4:0] A2M,
    input [31:0] RD2M,
    input [4:0] A3M,
    input [31:0] WDM,
    input [4:0] A3W,
    input [31:0] WDW,
    output [31:0] ForwardD1,
    output [31:0] ForwardD2,
    output [31:0] ForwardE1,
    output [31:0] ForwardE2,
    output [31:0] ForwardM2
    );

	assign ForwardD1 = (A1D == A3E && A3E != 0) ? WDE :
							 (A1D == A3M && A3M != 0) ? WDM :
							 RD1D;
	assign ForwardD2 = (A2D == A3E && A3E != 0) ? WDE :
							 (A2D == A3M && A3M != 0) ? WDM :
							 RD2D;
	assign ForwardE1 = (A1E == A3M && A3M != 0) ? WDM :
							 (A1E == A3W && A3W != 0) ? WDW :
							 RD1E;
	assign ForwardE2 = (A2E == A3M && A3M != 0) ? WDM :
							 (A2E == A3W && A3W != 0) ? WDW :
							 RD2E;
	assign ForwardM2 = (A2M == A3W && A3W != 0) ? WDW :
							 RD2M;

endmodule
