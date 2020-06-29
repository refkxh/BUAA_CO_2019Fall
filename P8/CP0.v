`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:08 12/01/2019 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input Clk,
    input Reset,
	 input [4:0] Addr,
    input [31:0] DIn,
    input [31:2] PC,
    input [6:2] ExcCode,
    input [7:2] HWInt,
    input WE,
    input EXLSet,
    input EXLClr,
	 input BD,
    output IntReq,
    output [31:0] EPC,
    output [31:0] DOut
    );

	parameter SRAddr = 12, CAUSEAddr = 13, EPCAddr = 14, PrIDAddr = 15;
	
	reg BDReg, EXL, IE;
	reg [7:2] IP, IM;
	reg [6:2] ExcCodeReg;
	reg [31:0] EPCReg, PrID;
	
	always @ (posedge Clk) begin
		if (Reset) begin
			BDReg <= 0;
			EXL <= 0;
			IE <= 0;
			IP <= 0;
			IM <= 0;
			ExcCodeReg <= 0;
			EPCReg <= 0;
			PrID <= "KXH";
		end
		else if (EXLClr) EXL <= 0;
		else if (IntReq) begin
			BDReg <= BD;
			EPCReg <= BD ? {PC[31:2] - 30'b1, 2'b0} : {PC[31:2], 2'b0};
			ExcCodeReg <= ((|(HWInt[7:2] & IM[7:2])) && IE) ? 5'b0 : ExcCode;
			EXL <= 1;
		end
		else if (WE) begin
			if (Addr == SRAddr) begin
				IM <= DIn[15:10];
				EXL <= DIn[1];
				IE <= DIn[0];
			end
			else if (Addr == EPCAddr) EPCReg <= DIn;
		end
		if (!Reset) IP <= HWInt;
	end
	
	assign IntReq = (((|(HWInt[7:2] & IM[7:2])) && IE) || EXLSet) && !EXL;
	assign EPC = EPCReg;
	assign DOut = (Addr == SRAddr) ? {16'b0, IM, 8'b0, EXL, IE} :
					  (Addr == CAUSEAddr) ? {BDReg, 15'b0, IP, 3'b0, ExcCodeReg, 2'b0} :
					  (Addr == EPCAddr) ? EPCReg :
					  (Addr == PrIDAddr) ? PrID :
					  32'b0;

endmodule
