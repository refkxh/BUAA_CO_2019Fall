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
    input [31:0] WDE,
	 input [6:2] ExcCodeE,
    output [31:0] ALUOutEM,
    output [31:0] RD2EM,
    output [31:0] WDEM,
	 output E1Use,
	 output E2Use,
	 output [6:2] ExcCodeEM
    );

	wire [31:0] MALUSrcAOut, MALUSrcBOut, ALUResult;
	wire [3:0] ALUOp;
	
	Controller ControllerE (
    .Op(InstrE[31:26]), 
    .Funct(InstrE[5:0]), 
	 .RS(InstrE[25:21]), 
	 .RT(InstrE[20:16]), 
    .ALUOp(ALUOp), 
	 .ALUSrcA(ALUSrcA), 
    .ALUSrcB(ALUSrcB), 
    .GenE(GenE), 
	 .E1Use(E1Use),
	 .E2Use(E2Use), 
	 .Ov(Ov), 
	 .Ld(Ld), 
	 .St(St)
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
    .Result(ALUResult), 
	 .Overflow(Overflow)
    );
	 
	 MUX2 MWDE (
    .In0(WDE), 
    .In1(ALUResult), 
    .Sel(GenE), 
    .Out(WDEM)
    );
	 
	 assign RD2EM = ForwardE2;
	 assign ALUOutEM = ALUResult;
	 assign ExcCodeEM = (Ov && Overflow && (ExcCodeE == 0)) ? 5'd12 :
							  (Ld && Overflow && (ExcCodeE == 0)) ? 5'd4 :
							  (St && Overflow && (ExcCodeE == 0)) ? 5'd5 :
							  ExcCodeE;
	 
endmodule
