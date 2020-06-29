`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:00 11/09/2019 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input Clk,
    input Reset,
    input En,
    input [31:0] In,
    output reg [31:0] Out
    );

	always @ (posedge Clk) begin
		if (Reset) Out <= 32'h3000;
		else if (En) Out <= In;
	end

endmodule
