`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:12 11/16/2019 
// Design Name: 
// Module Name:    WReg 
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
module WReg(
    input Clk,
    input Reset,
	 input WRegFlush,
    input [4:0] A3M,
    input [31:0] WDM,
	 input [31:0] PCM,
    output reg [4:0] A3W,
    output reg [31:0] WDW,
	 output reg [31:0] PCW
    );

	always @ (posedge Clk) begin
		if (Reset || WRegFlush) begin
			A3W <= 0;
			WDW <= 0;
			PCW <= 0;
		end
		else begin
			A3W <= A3M;
			WDW <= WDM;
			PCW <= PCM;
		end
	end

endmodule
