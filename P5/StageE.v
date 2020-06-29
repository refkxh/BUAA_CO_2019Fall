`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:39 11/16/2019 
// Design Name: 
// Module Name:    StageE 
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
module StageE(
    input [31:0] InstrE,
    input [31:0] ForwardE1,
    input [31:0] ForwardE2,
    input [31:0] Imm32E,
    input [4:0] A3E,
    input [31:0] WDE,
    output [31:0] ALUOutEM,
    output [31:0] RD2EM,
    output [4:0] A3EM,
    output [31:0] WDEM
    );

	wire [31:0] MALUSrcOut, ALUResult;
	wire [3:0] ALUOp;
	wire [1:0] GenE;
	
	ControllerE ControllerEInstance (
    .Op(InstrE[31:26]), 
    .Funct(InstrE[5:0]), 
    .ALUOp(ALUOp), 
    .ALUSrc(ALUSrc), 
    .GenE(GenE)
    );
	 
	 MUX2 MALUSrc (
    .In0(ForwardE2), 
    .In1(Imm32E), 
    .Sel(ALUSrc), 
    .Out(MALUSrcOut)
    );
	 
	 ALU ALUInstance (
    .A(ForwardE1), 
    .B(MALUSrcOut), 
    .ALUOp(ALUOp), 
    .Result(ALUResult)
    );
	 
	 MUX3 #5 MA3E (
    .In0(A3E), 
    .In1(InstrE[15:11]), 
    .In2(InstrE[20:16]), 
    .Sel(GenE), 
    .Out(A3EM)
    );
	 
	 MUX3 MWDE (
    .In0(WDE), 
    .In1(ALUResult), 
    .In2(ALUResult), 
    .Sel(GenE), 
    .Out(WDEM)
    );
	 
	 assign RD2EM = ForwardE2;
	 assign ALUOutEM = ALUResult;
	 
endmodule
