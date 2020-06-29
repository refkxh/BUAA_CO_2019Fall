`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:28 09/15/2019 
// Design Name: 
// Module Name:    adder 
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
module adder(
    input [3:0] A,
    input [3:0] B,
    input Clk,
    input En,
    output [3:0] Sum,
    output Overflow
    );
	
	reg [3:0] Sum;
	reg Overflow;
	wire [4:0] tmp;
	assign tmp = A + B;
	
	initial begin
		Sum = 0;
		Overflow = 0;
	end
	
	always @(posedge Clk) begin
		if (En) {Overflow, Sum} <= tmp;
	end

endmodule
