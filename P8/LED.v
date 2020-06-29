`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:13 12/19/2019 
// Design Name: 
// Module Name:    LED 
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
module LED(
    input Clk,
    input Reset,
    input WE,
    input [3:0] BE,
    input [31:0] DIn,
    output [31:0] DOut,
	 output [31:0] LEDLight
    );

	reg [31:0] Light;
	
	assign LEDLight = ~Light, DOut = Light;
	
	always @ (posedge Clk) begin
		if (Reset) Light <= 0;
		else if (WE) begin
			if (BE[3]) Light[31:24] <= DIn[31:24];
			if (BE[2]) Light[23:16] <= DIn[23:16];
			if (BE[1]) Light[15:8] <= DIn[15:8];
			if (BE[0]) Light[7:0] <= DIn[7:0];
		end
	end

endmodule
