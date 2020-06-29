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

	reg [31:0] IMReg [0:1023];
	
	initial $readmemh("code.txt", IMReg);
	
	assign Instr = IMReg[Addr[11:2]];

endmodule
