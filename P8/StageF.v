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
	 input DMClk,
    input Reset,
	 input PCEn,
	 input IntReq,
	 input eret,
	 input [1:0] PCSrc,
	 input [31:0] NPCOut,
	 input [31:0] ForwardD1,
	 input [31:0] EPC,
    output [31:0] InstrFD,
    output [31:0] PC4FD,
	 output [31:0] PCFD, 
	 output [6:2] ExcCodeFD
    );

	wire [31:0] PCOut, MPCOut, AdderOut, Instr, Addr;
	
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
    .In(eret ? EPC : IntReq ? 32'h4180 : MPCOut), 
    .Out(PCOut)
    );
	 
	 Adder AdderInstance (
    .In(PCOut), 
    .Out(AdderOut)
    );
	 
	 IM IMInstance (
	 .clka(DMClk), 
    .addra(Addr[12:2]), 
    .douta(Instr)
	 );

	assign Addr = PCOut - 32'h3000;
	assign PC4FD = AdderOut;
	assign PCFD = PCOut;
	assign ExcCodeFD = ((PCOut[1:0] != 2'b0) || (PCOut < 32'h3000) || (PCOut > 32'h4ffc)) ? 5'd4 : 5'b0;
	assign InstrFD = (ExcCodeFD == 5'b0) ? Instr : 0;

endmodule
