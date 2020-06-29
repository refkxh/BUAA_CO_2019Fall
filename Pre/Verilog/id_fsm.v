`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:51:00 09/19/2019 
// Design Name: 
// Module Name:    id_fsm 
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
module id_fsm(
    input [7:0] char,
    input clk,
    output reg out = 0
    );

	reg [1:0] st;
	
	initial begin
		st = 0;
	end
	
	always @(posedge clk) begin
		case (st)
			0: begin
				if ((char >= 65 && char <= 90) || (char >= 97 && char <= 122)) st <= 1;
			end
			1: begin
				if (char >= 48 && char <= 57) begin
					st <= 2;
					out <= 1;
				end
				else if ((char >= 65 && char <= 90) || (char >= 97 && char <= 122)) st <= 1;
				else st <= 0;
			end
			2: begin
				if (char >= 48 && char <= 57) begin
					st <= 2;
					out <= 1;
				end
				else if ((char >= 65 && char <= 90) || (char >= 97 && char <= 122)) begin
					st <= 1;
					out <= 0;
				end
				else begin
					st <= 0;
					out <= 0;
				end
			end
		endcase
	end

endmodule
