`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:57:17 12/19/2019 
// Design Name: 
// Module Name:    DipSwitch 
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
module DipSwitch(
	 input Addr,
    input [7:0] In0,
    input [7:0] In1,
    input [7:0] In2,
    input [7:0] In3,
	 input [7:0] In4,
    input [7:0] In5,
    input [7:0] In6,
    input [7:0] In7,
    output [31:0] DOut
    );

	assign DOut = Addr ? ~{In7, In6, In5, In4} : ~{In3, In2, In1, In0};

endmodule
