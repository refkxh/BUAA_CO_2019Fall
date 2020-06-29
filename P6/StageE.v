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
    input Clk,
    input Reset,
	 input [31:0] InstrE,
    input [31:0] ForwardE1,
    input [31:0] ForwardE2,
    input [31:0] Imm32E,
    input [31:0] WDE,
    output [31:0] ALUOutEM,
    output [31:0] RD2EM,
    output [31:0] WDEM,
	 output E1Use,
	 output E2Use,
	 output Start,
	 output Busy
    );

	wire [31:0] MALUSrcAOut, MALUSrcBOut, ALUResult, HI, LO;
	wire [3:0] ALUOp;
	wire [1:0] MDUOp, GenE;
	
	Controller ControllerE (
    .Op(InstrE[31:26]), 
    .Funct(InstrE[5:0]), 
	 .RT(InstrE[20:16]), 
    .ALUOp(ALUOp), 
	 .ALUSrcA(ALUSrcA), 
    .ALUSrcB(ALUSrcB), 
	 .Start(Start), 
	 .MDUOp(MDUOp), 
    .HIWrite(HIWrite), 
    .LOWrite(LOWrite), 
    .GenE(GenE), 
	 .E1Use(E1Use),
	 .E2Use(E2Use)
    );
	 
	 MUX2 MALUSrcA (
    .In0(ForwardE1), 
    .In1({27'b0, InstrE[10:6]}), 
    .Sel(ALUSrcA), 
    .Out(MALUSrcAOut)
    );
	 
	 MUX2 MALUSrcB (
    .In0(ForwardE2), 
    .In1(Imm32E), 
    .Sel(ALUSrcB), 
    .Out(MALUSrcBOut)
    );
	 
	 ALU ALUInstance (
    .A(MALUSrcAOut), 
    .B(MALUSrcBOut), 
    .ALUOp(ALUOp), 
    .Result(ALUResult)
    );
	 
	 MDU MDUInstance (
    .Clk(Clk), 
    .Reset(Reset), 
    .Start(Start), 
    .MDUOp(MDUOp), 
    .HIWrite(HIWrite), 
    .LOWrite(LOWrite), 
    .A(ForwardE1), 
    .B(ForwardE2), 
    .Busy(Busy), 
    .HI(HI), 
    .LO(LO)
    );
	 
	 MUX4 MWDE (
    .In0(WDE), 
    .In1(ALUResult), 
	 .In2(HI), 
	 .In3(LO), 
    .Sel(GenE), 
    .Out(WDEM)
    );
	 
	 assign RD2EM = ForwardE2;
	 assign ALUOutEM = ALUResult;
	 
endmodule
