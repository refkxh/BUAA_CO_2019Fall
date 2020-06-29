`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:24 11/09/2019 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input Clk,
    input Reset,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input RegWrite,
	 input [31:0] WPC,
    output [31:0] RD1,
    output [31:0] RD2
    );

	reg [31:0] GRFReg [0:31];
	integer i;
	
	always @ (posedge Clk) begin
		if (Reset) begin
			for (i = 0; i < 32; i = i + 1) begin
				GRFReg[i] <= 0;
			end
		end
		else if (RegWrite && (A3 != 0)) begin
			GRFReg[A3] <= WD;
			$display("%d@%h: $%d <= %h", $time, WPC, A3, WD);
		end
	end
	
	assign RD1 = (A1 == A3 && A1 != 0 && RegWrite) ? WD : GRFReg[A1];
	assign RD2 = (A2 == A3 && A2 != 0 && RegWrite) ? WD : GRFReg[A2];

endmodule
