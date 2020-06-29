`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:19 11/16/2019 
// Design Name: 
// Module Name:    StageF 
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
module StageF(
    input Clk,
    input Reset,
	 input PCEn,
	 input [1:0] PCSrc,
	 input [31:0] NPCOut,
	 input [31:0] ForwardD1,
    output [31:0] InstrFD,
    output [31:0] PC4FD,
	 output [31:0] PCFD
    );

	wire [31:0] PCOut, MPCOut, AdderOut;
	
	MUX3 MPC (
    .In0(AdderOut), 
    .In1(NPCOut), 
    .In2(ForwardD1), 
    .Sel(PCSrc), 
    .Out(MPCOut)
    );
	
	PC PCInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .En(PCEn), 
    .In(MPCOut), 
    .Out(PCOut)
    );
	 
	 Adder AdderInstance (
    .In(PCOut), 
    .Out(AdderOut)
    );
	 
	 IM IMInstance (
    .Addr(PCOut), 
    .Instr(InstrFD)
    );

	assign PC4FD = AdderOut;
	assign PCFD = PCOut;

endmodule
