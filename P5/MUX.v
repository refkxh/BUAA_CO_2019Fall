`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:53 11/09/2019 
// Design Name: 
// Module Name:    MUX 
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
module MUX2(In0, In1, Sel, Out);

	parameter DATAWIDTH = 32;
	
	input [DATAWIDTH - 1:0] In0;
   input [DATAWIDTH - 1:0] In1;
   input Sel;
   output reg [DATAWIDTH - 1:0] Out;

	always @ * begin
		case (Sel)
			0: Out = In0;
			1: Out = In1;
		endcase
	end

endmodule

module MUX3(In0, In1, In2, Sel, Out);

	parameter DATAWIDTH = 32;
	
	input [DATAWIDTH - 1:0] In0;
   input [DATAWIDTH - 1:0] In1;
	input [DATAWIDTH - 1:0] In2;
   input [1:0] Sel;
   output reg [DATAWIDTH - 1:0] Out;

	always @ * begin
		case (Sel)
			0: Out = In0;
			1: Out = In1;
			2: Out = In2;
			3: Out = 32'bx;
		endcase
	end

endmodule

module MUX4(In0, In1, In2, In3, Sel, Out);

	parameter DATAWIDTH = 32;
	
	input [DATAWIDTH - 1:0] In0;
   input [DATAWIDTH - 1:0] In1;
	input [DATAWIDTH - 1:0] In2;
	input [DATAWIDTH - 1:0] In3;
   input [1:0] Sel;
   output reg [DATAWIDTH - 1:0] Out;

	always @ * begin
		case (Sel)
			0: Out = In0;
			1: Out = In1;
			2: Out = In2;
			3: Out = In3;
		endcase
	end

endmodule