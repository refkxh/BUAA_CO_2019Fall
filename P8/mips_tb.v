`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:31:29 11/16/2016
// Design Name:   mips
// Module Name:   D:/ISE/P4/mips_txt.v
// Project Name:  P4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_txt;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk), 
		.sys_rstn(~reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#200 reset = 0;
		// Wait 100 ns for global reset to finish
		// Add stimulus here

	end
   always #2 clk = ~clk;
endmodule

