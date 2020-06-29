`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:24 11/07/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
	 input interrupt,
	 output [31:0] addr
    );

	wire [31:0] PrRD, PrWD, DEVWD, DEVRD0, DEVRD1;
	wire [31:2] DEVAddr, PrAddr;
	
	CPU CPUInstance (
    .Clk(clk), 
    .Reset(reset), 
    .HWInt({3'b0, interrupt, IRQ1, IRQ0}), 
    .PrRD(PrRD), 
    .PrWE(PrWE), 
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
	 .addr(addr)
    );
	 
	 Bridge BridgeInstance (
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
	 .DEVRD0(DEVRD0), 
    .DEVRD1(DEVRD1), 
	 .PrWE(PrWE), 
	 .PrRD(PrRD), 
    .DEVAddr(DEVAddr), 
    .DEVWD(DEVWD), 
    .DEVWE0(DEVWE0), 
    .DEVWE1(DEVWE1)
    );

	TC Timer0 (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEVAddr), 
    .WE(DEVWE0), 
    .Din(DEVWD), 
    .Dout(DEVRD0), 
    .IRQ(IRQ0)
    );
	
	TC Timer1 (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEVAddr), 
    .WE(DEVWE1), 
    .Din(DEVWD), 
    .Dout(DEVRD1), 
    .IRQ(IRQ1)
    );

endmodule
