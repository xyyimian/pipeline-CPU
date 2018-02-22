`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:53 05/28/2017 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
    input clk,
	 input RegWrite,
	 input MemtoReg,
	 input MemRead,
	 input [31:0] douta,
	 input [31:0] alu_out,
	 input [4:0] RegMux,
	 input [4:0] rt,
	 input [4:0] dest,
	 
	 output reg o_RegWrite,
	 output reg o_MemtoReg,
	 output reg o_MemRead,
	 output reg [31:0] o_douta,
	 output reg [31:0] o_alu_out,
	 output reg [4:0] o_RegMux,
	 output reg [4:0] o_rt,
	 output reg [4:0] o_dest
    );
	 
always@(posedge clk)
begin
	o_RegWrite=RegWrite;
	o_MemtoReg=MemtoReg;
	o_MemRead=MemRead;
	o_douta=douta;
	o_alu_out=alu_out;
	o_RegMux=RegMux;
	o_rt=rt;
	o_dest=dest;
end

endmodule
