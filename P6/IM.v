`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:04:35 11/09/2019 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] Addr,
    output [31:0] Instr
    );

	reg [31:0] IMReg [0:4095];
	wire [31:0] RealAddr;
	
	initial $readmemh("code.txt", IMReg);
	
	assign RealAddr =  Addr - 32'h3000;
	assign Instr = IMReg[RealAddr[13:2]];

endmodule
