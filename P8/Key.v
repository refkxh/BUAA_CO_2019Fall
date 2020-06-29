`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:21 12/19/2019 
// Design Name: 
// Module Name:    Key 
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
module Key(
    input [7:0] KIn,
    output [31:0] DOut
    );

	assign DOut = {24'b0, ~KIn};

endmodule
