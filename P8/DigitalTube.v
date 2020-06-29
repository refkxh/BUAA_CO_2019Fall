`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:47:47 12/19/2019 
// Design Name: 
// Module Name:    DigitalTube 
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
module DigitalTube(
    input Clk,
    input Reset,
	 input Addr,
    input WE,
    input [3:0] BE,
    input [31:0] DIn,
    output [31:0] DOut,
	 output [7:0] digital_tube2,
	 output digital_tube_sel2,
	 output [7:0] digital_tube1,
	 output reg [3:0] digital_tube_sel1,
	 output [7:0] digital_tube0,
	 output reg [3:0] digital_tube_sel0
    );

	reg [1:0] i;
	reg [3:0] tube1, tube0;
	reg [31:0] tube, sign, cnt;
	
	assign DOut = Addr ? sign : tube;
	
	assign digital_tube_sel2 = 1'b1;
	assign digital_tube2 = (sign[3:0] == 4'd0) ? 8'b10000001 :
								  (sign[3:0] == 4'd1) ? 8'b11001111 :
								  (sign[3:0] == 4'd2) ? 8'b10010010 :
								  (sign[3:0] == 4'd3) ? 8'b10000110 :
								  (sign[3:0] == 4'd4) ? 8'b11001100 :
								  (sign[3:0] == 4'd5) ? 8'b10100100 :
								  (sign[3:0] == 4'd6) ? 8'b10100000 :
								  (sign[3:0] == 4'd7) ? 8'b10001111 :
								  (sign[3:0] == 4'd8) ? 8'b10000000 :
								  (sign[3:0] == 4'd9) ? 8'b10000100 :
								  (sign[3:0] == 4'd10) ? 8'b10001000 :
								  (sign[3:0] == 4'd11) ? 8'b11100000 :
								  (sign[3:0] == 4'd12) ? 8'b10110001 :
								  (sign[3:0] == 4'd13) ? 8'b11000010 :
								  (sign[3:0] == 4'd14) ? 8'b10110000 :
								  (sign[3:0] == 4'd15) ? 8'b10111000 :
								  8'b11111111;
	assign digital_tube1 = (tube1 == 4'd0) ? 8'b10000001 :
								  (tube1 == 4'd1) ? 8'b11001111 :
								  (tube1 == 4'd2) ? 8'b10010010 :
								  (tube1 == 4'd3) ? 8'b10000110 :
								  (tube1 == 4'd4) ? 8'b11001100 :
								  (tube1 == 4'd5) ? 8'b10100100 :
								  (tube1 == 4'd6) ? 8'b10100000 :
								  (tube1 == 4'd7) ? 8'b10001111 :
								  (tube1 == 4'd8) ? 8'b10000000 :
								  (tube1 == 4'd9) ? 8'b10000100 :
								  (tube1 == 4'd10) ? 8'b10001000 :
								  (tube1 == 4'd11) ? 8'b11100000 :
								  (tube1 == 4'd12) ? 8'b10110001 :
								  (tube1 == 4'd13) ? 8'b11000010 :
								  (tube1 == 4'd14) ? 8'b10110000 :
								  (tube1 == 4'd15) ? 8'b10111000 :
								  8'b11111111;
	assign digital_tube0 = (tube0 == 4'd0) ? 8'b10000001 :
								  (tube0 == 4'd1) ? 8'b11001111 :
								  (tube0 == 4'd2) ? 8'b10010010 :
								  (tube0 == 4'd3) ? 8'b10000110 :
								  (tube0 == 4'd4) ? 8'b11001100 :
								  (tube0 == 4'd5) ? 8'b10100100 :
								  (tube0 == 4'd6) ? 8'b10100000 :
								  (tube0 == 4'd7) ? 8'b10001111 :
								  (tube0 == 4'd8) ? 8'b10000000 :
								  (tube0 == 4'd9) ? 8'b10000100 :
								  (tube0 == 4'd10) ? 8'b10001000 :
								  (tube0 == 4'd11) ? 8'b11100000 :
								  (tube0 == 4'd12) ? 8'b10110001 :
								  (tube0 == 4'd13) ? 8'b11000010 :
								  (tube0 == 4'd14) ? 8'b10110000 :
								  (tube0 == 4'd15) ? 8'b10111000 :
								  8'b11111111;
	
	
	always @ (posedge Clk) begin
		if (Reset) begin
			tube <= 0;
			sign <= 0;
			cnt <= 0;
			i <= 0;
			tube1 <= 0;
			tube0 <= 0;
			digital_tube_sel1 <= 0;
			digital_tube_sel0 <= 0;
		end
		else begin
			cnt <= cnt + 1;
			if (cnt == 500000) begin
				cnt <= 0;
				digital_tube_sel1[i - 2'b1] <= 1'b0;
				case (i)
					2'b00: tube1 <= tube[19:16];
					2'b01: tube1 <= tube[23:20];
					2'b10: tube1 <= tube[27:24];
					2'b11: tube1 <= tube[31:28];
				endcase
				digital_tube_sel1[i] <= 1'b1;
				digital_tube_sel0[i - 2'b1] <= 1'b0;
				case (i)
					2'b00: tube0 <= tube[3:0];
					2'b01: tube0 <= tube[7:4];
					2'b10: tube0 <= tube[11:8];
					2'b11: tube0 <= tube[15:12];
				endcase
				digital_tube_sel0[i] <= 1'b1;
				i <= i + 1'b1;
			end
			if (WE) begin
				case (Addr)
					1'b1: begin
						if (BE[3]) sign[31:24] <= DIn[31:24];
						if (BE[2]) sign[23:16] <= DIn[23:16];
						if (BE[1]) sign[15:8] <= DIn[15:8];
						if (BE[0]) sign[7:0] <= DIn[7:0];
					end
					1'b0: begin
						if (BE[3]) tube[31:24] <= DIn[31:24];
						if (BE[2]) tube[23:16] <= DIn[23:16];
						if (BE[1]) tube[15:8] <= DIn[15:8];
						if (BE[0]) tube[7:0] <= DIn[7:0];
					end
				endcase
			end
		end
	end

endmodule
