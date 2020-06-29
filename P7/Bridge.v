`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:36 11/30/2019 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:2] PrAddr,
    input [31:0] PrWD,
	 input [31:0] DEVRD0,
    input [31:0] DEVRD1,
	 input PrWE,
	 output [31:0] PrRD,
    output [31:2] DEVAddr,
    output [31:0] DEVWD,
    output DEVWE0,
    output DEVWE1
    );

	assign DEVWE1 = PrWE && PrAddr[4], DEVWE0 = PrWE && !PrAddr[4], DEVAddr = PrAddr, PrRD = PrAddr[4] ? DEVRD1 : DEVRD0, DEVWD = PrWD;
	
endmodule
