`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:48:35 05/10/2017 
// Design Name: 
// Module Name:    WB 
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
module WB(
    input clk,
    input rst_n,
	 
    input [31:0] douta,
    input [31:0] alu_out,
	 input MemtoReg,
	 input RegWrite,
	 input [4:0] RegMux,
	 
	 output [31:0] r3_din,
	 output [4:0] r3_addr,
	 output o_RegWrite
    );
	 
	 
assign r3_din=(MemtoReg==0)?alu_out:douta;	
assign r3_addr=RegMux;
assign o_RegWrite=RegWrite;
endmodule
