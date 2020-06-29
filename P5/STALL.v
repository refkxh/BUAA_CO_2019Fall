`timescale 1ns / 1ps
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:18 11/16/2019 
// Design Name: 
// Module Name:    STALL 
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
module STALL(
    input [31:0] InstrD,
    input [31:0] InstrE,
    input [31:0] InstrM,
    output PCEn,
    output DRegEn,
    output ERegFlush
    );

	wire adduD, subuD, oriD, lwD, swD, beqD, luiD, jrD;
	wire cal_rD, cal_iD, loadD, storeD, branchD;
	wire adduE, subuE, oriE, lwE, luiE;
	wire cal_rE, cal_iE, loadE;
	wire lwM;
	wire loadM;
	wire stall;
	
	assign adduD = (InstrD[31:26] == `R) && (InstrD[5:0] == `ADDU),
			 subuD = (InstrD[31:26] == `R) && (InstrD[5:0] == `SUBU),
			 oriD = (InstrD[31:26] == `ORI),
			 lwD = (InstrD[31:26] == `LW),
			 swD = (InstrD[31:26] == `SW),
			 beqD = (InstrD[31:26] == `BEQ),
			 luiD = (InstrD[31:26] == `LUI),
			 jrD = (InstrD[31:26] == `R) && (InstrD[5:0] == `JR);
	
	assign cal_rD = adduD || subuD,
			 cal_iD = oriD || luiD,
			 loadD = lwD,
			 storeD = swD,
			 branchD = beqD;
	
	assign adduE = (InstrE[31:26] == `R) && (InstrE[5:0] == `ADDU),
			 subuE = (InstrE[31:26] == `R) && (InstrE[5:0] == `SUBU),
			 oriE = (InstrE[31:26] == `ORI),
			 lwE = (InstrE[31:26] == `LW),
			 luiE = (InstrE[31:26] == `LUI);
	
	assign cal_rE = adduE || subuE,
			 cal_iE = oriE || luiE,
			 loadE = lwE;
	
	assign lwM = (InstrM[31:26] == `LW);
	
	assign loadM = lwM;
	
	assign stall = (cal_rD && loadE && (InstrD[25:21] == InstrE[20:16] || InstrD[20:16] == InstrE[20:16])) ||
						((cal_iD || loadD || storeD) && loadE && (InstrD[25:21] == InstrE[20:16])) ||
						(branchD && cal_rE && (InstrD[25:21] == InstrE[15:11] || InstrD[20:16] == InstrE[15:11])) ||
						(branchD && (cal_iE || loadE) && (InstrD[25:21] == InstrE[20:16] || InstrD[20:16] == InstrE[20:16])) ||
						(branchD && loadM && (InstrD[25:21] == InstrM[20:16] || InstrD[20:16] == InstrM[20:16])) ||
						(jrD && cal_rE && (InstrD[25:21] == InstrE[15:11])) ||
						(jrD && (cal_iE || loadE) && (InstrD[25:21] == InstrE[20:16])) ||
						(jrD && loadM && (InstrD[25:21] == InstrM[20:16]));
	
	assign PCEn = ~stall;
	assign DRegEn = ~stall;
	assign ERegFlush = stall;

endmodule
