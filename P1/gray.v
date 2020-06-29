`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:33 10/17/2019 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output reg [2:0] Output,
    output reg Overflow
    );
	
	parameter G0 = 3'b000, G1 = 3'b001, G2 = 3'b011, G3 = 3'b010, G4 = 3'b110, G5 = 3'b111, G6 = 3'b101, G7 = 3'b100;
	
	initial begin
		Output <= 0;
		Overflow <= 0;
	end
	
	always @ (posedge Clk) begin
		if (Reset == 1) begin
			Output <= 0;
			Overflow <= 0;
		end
		else if (En == 1) begin
			case (Output)
				G0: Output <= G1;
				G1: Output <= G2;
				G2: Output <= G3;
				G3: Output <= G4;
				G4: Output <= G5;
				G5: Output <= G6;
				G6: Output <= G7;
				G7: begin
					Output <= G0;
					Overflow <= 1;
				end
			endcase
		end
	end

endmodule
