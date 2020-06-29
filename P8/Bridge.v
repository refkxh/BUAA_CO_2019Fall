`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:36 11/30/2019 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:2] PrAddr,
    input [31:0] PrWD,
	 input [31:0] DEVRD0,
    input [31:0] DEVRD1,
	 input [31:0] DEVRD2,
	 input [31:0] DEVRD3,
	 input [31:0] DEVRD4,
	 input [31:0] DEVRD5,
	 input PrWE,
	 output [31:0] PrRD,
    output [31:2] DEVAddr,
    output [31:0] DEVWD,
    output DEVWE0,
    output DEVWE1,
	 output DEVWE3,
	 output DEVWE4
    );

	wire HitDEV0, HitDEV1, HitDEV2, HitDEV3, HitDEV4, HitDEV5;
	
	assign HitDEV0 = (PrAddr[6:2] <= 5'b00010),
			 HitDEV1 = (PrAddr[6:2] >= 5'b00100) && (PrAddr[6:2] <= 5'b01010),
			 HitDEV2 = (PrAddr[6:2] == 5'b01011) || (PrAddr[6:2] == 5'b01100),
			 HitDEV3 = (PrAddr[6:2] == 5'b01101),
			 HitDEV4 = (PrAddr[6:2] == 5'b01110) || (PrAddr[6:2] == 5'b01111),
			 HitDEV5 = (PrAddr[6:2] == 5'b10000);
			 
	assign DEVWE4 = PrWE && HitDEV4, DEVWE3 = PrWE && HitDEV3, 
			 DEVWE1 = PrWE && HitDEV1, DEVWE0 = PrWE && HitDEV0, 
			 PrRD = HitDEV5 ? DEVRD5 :
					  HitDEV4 ? DEVRD4 :
					  HitDEV3 ? DEVRD3 :
					  HitDEV2 ? DEVRD2 :
					  HitDEV1 ? DEVRD1 :
					  DEVRD0,
			 DEVAddr = PrAddr,  DEVWD = PrWD;
	
endmodule
