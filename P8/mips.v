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
    input clk_in,
    input sys_rstn,
	 input uart_rxd,
	 output uart_txd,
	 input [7:0] dip_switch0,
	 input [7:0] dip_switch1,
	 input [7:0] dip_switch2,
	 input [7:0] dip_switch3,
	 input [7:0] dip_switch4,
	 input [7:0] dip_switch5,
	 input [7:0] dip_switch6,
	 input [7:0] dip_switch7,
	 input [7:0] user_key,
	 output [31:0] led_light,
	 output [7:0] digital_tube2,
	 output digital_tube_sel2,
	 output [7:0] digital_tube1,
	 output [3:0] digital_tube_sel1,
	 output [7:0] digital_tube0,
	 output [3:0] digital_tube_sel0
    );

	wire [31:0] PrRD, PrWD, DEVWD, DEVRD0, DEVRD1, DEVRD2, DEVRD3, DEVRD4, DEVRD5;
	wire [31:2] DEVAddr, PrAddr;
	wire [3:0] PrBE;
	
	Clock ClockInstance (
    .clk_in(clk_in), 
    .Clk(Clk), 
    .DMClk(DMClk)
	 );
	
	CPU CPUInstance (
    .Clk(Clk), 
	 .DMClk(DMClk), 
    .Reset(!sys_rstn), 
    .HWInt({4'b0, INT, IRQ}), 
    .PrRD(PrRD), 
    .PrWE(PrWE), 
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
	 .PrBE(PrBE)
    );
	 
	 Bridge BridgeInstance (
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .DEVRD0(DEVRD0), 
    .DEVRD1(DEVRD1), 
    .DEVRD2(DEVRD2), 
    .DEVRD3(DEVRD3), 
    .DEVRD4(DEVRD4), 
    .DEVRD5(DEVRD5), 
    .PrWE(PrWE), 
    .PrRD(PrRD), 
    .DEVAddr(DEVAddr), 
    .DEVWD(DEVWD), 
    .DEVWE0(DEVWE0), 
    .DEVWE1(DEVWE1), 
    .DEVWE3(DEVWE3), 
    .DEVWE4(DEVWE4)
    );

	TC Timer (
    .clk(Clk), 
    .reset(!sys_rstn), 
    .Addr(DEVAddr), 
    .WE(DEVWE0), 
    .Din(DEVWD), 
    .Dout(DEVRD0), 
    .IRQ(IRQ)
    );
	
	MiniUART UART (
    .ADD_I(DEVAddr[6:2] - 5'b00100), 
    .DAT_I(DEVWD), 
    .DAT_O(DEVRD1), 
    .STB_I(1'b1), 
    .WE_I(DEVWE1), 
    .CLK_I(Clk), 
    .RST_I(!sys_rstn), 
    .RxD(uart_rxd), 
    .TxD(uart_txd), 
    .INT(INT)
    );
	 
	 DipSwitch DipSwitchInstance (
    .Addr(DEVAddr[4]), 
    .In0(dip_switch0), 
    .In1(dip_switch1), 
    .In2(dip_switch2), 
    .In3(dip_switch3), 
    .In4(dip_switch4), 
    .In5(dip_switch5), 
    .In6(dip_switch6), 
    .In7(dip_switch7), 
    .DOut(DEVRD2)
    );
	 
	 LED LEDInstance (
    .Clk(Clk), 
    .Reset(!sys_rstn), 
    .WE(DEVWE3), 
    .BE(PrBE), 
    .DIn(DEVWD), 
    .DOut(DEVRD3), 
    .LEDLight(led_light)
    );
	 
	 DigitalTube DigitalTubeInstance (
    .Clk(Clk), 
    .Reset(!sys_rstn), 
    .Addr(DEVAddr[2]), 
    .WE(DEVWE4), 
    .BE(PrBE), 
    .DIn(DEVWD), 
    .DOut(DEVRD4), 
    .digital_tube2(digital_tube2), 
    .digital_tube_sel2(digital_tube_sel2), 
    .digital_tube1(digital_tube1), 
    .digital_tube_sel1(digital_tube_sel1), 
    .digital_tube0(digital_tube0), 
    .digital_tube_sel0(digital_tube_sel0)
    );
	 
	 Key KeyInstance (
    .KIn(user_key), 
    .DOut(DEVRD5)
    );

endmodule
