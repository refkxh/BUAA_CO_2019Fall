`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:42 10/17/2019 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out
    );

	parameter INIT = 2'b00, VALID = 2'b01, INVALID = 2'b10, FAIL = 2'b11;
	reg [1:0] st;

	initial begin
		out <= 0;
		st <= 0;
	end
	
	always @ (posedge clk or posedge clr) begin
		if (clr == 1) begin
			out <= 0;
			st <= 0;
		end
		else begin
			case (st)
				INIT: begin
					if (in >= "0" && in <= "9") begin
						st <= VALID;
						out <= 1;
					end
					else st <= FAIL;
				end
				VALID: begin
					if (in == "+" || in == "*") st <= INVALID;
					else st <= FAIL;
					out <= 0;
				end
				INVALID: begin
					if (in >= "0" && in <= "9") begin
						st <= VALID;
						out <= 1;
					end
					else st <= FAIL;
				end
			endcase
		end
	end

endmodule
