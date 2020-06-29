`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:07 09/19/2019 
// Design Name: 
// Module Name:    code 
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
module code(
    input Clk,
    input Reset,
    input Slt,
    input En,
    output [63:0] Output0,
    output [63:0] Output1
    );
	 
	reg [63:0] Output0, Output1;
	reg [3:0] cnt;
	
	initial begin
		Output0 <= 0;
		Output1 <= 0;
		cnt <= 0;
	end

	always @(posedge Clk) begin
		if (Reset) begin
			Output0 <= 0;
			Output1 <= 0;
			cnt <= 0;
		end
		else begin
			if (En) begin
				if (Slt) begin
					if (cnt == 3) begin
						Output1 <= Output1 + 1;
						cnt <= 0;
					end
					else cnt <= cnt + 1;
				end
				else begin
					Output0 <= Output0 + 1;
				end
			end
		end
	end
	
endmodule
