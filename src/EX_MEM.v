`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:34 05/27/2017 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
    input clk,
	 input rst_n,
	 input i_MemtoReg,
	 input i_Branch,
	 input i_MemRead,
	 input i_MemWrite,
	 input i_RegWrite,
	 input [31:0] i_alu_out,
	 input i_bj,
	 input [4:0] i_RegMux,
	 input [31:0] i_PCBranch,
	 input [31:0] i_alu_b,
	 input [4:0] i_rd,
	 input [4:0] i_rt,
	 input isR,
	 input EX_MEM_sel,
	 input [2:0] jump,


	 output reg o_MemtoReg,
	 output reg o_Branch,
	 output reg o_MemRead,
	 output reg o_MemWrite,
	 output reg [31:0] o_PCBranch,
	 output reg o_RegWrite,
	 output reg [31:0] o_alu_out,
	 output reg o_bj,
	 output reg [4:0] o_RegMux,
	 output reg [31:0] o_alu_b,
	 output reg [4:0] o_rt,
	 output reg [4:0] o_rd,
	 output reg [4:0] o_dest,
	 output reg PCSrc
    );
	 
//reg行变量不能用assign赋值

reg block;

always@(posedge clk or negedge rst_n)
begin
	if(EX_MEM_sel==1 || rst_n==0)
	begin
		o_MemtoReg=0;
		o_Branch=0;
		o_MemRead=0;
		o_MemWrite=0;
		o_PCBranch=0;
		o_RegWrite=0;
		o_alu_out=0;
		o_bj=0;
		o_RegMux=0;
		o_rt=0;
		o_rd=0;
		o_alu_b=0;
		o_dest=0;
		PCSrc=0;
		block=0;
	end
	else
	begin
		o_MemtoReg=i_MemtoReg;
		o_Branch=i_Branch;
		o_MemRead=i_MemRead;
		o_MemWrite=i_MemWrite;
		o_PCBranch=i_PCBranch;
		o_RegWrite=i_RegWrite;
		o_alu_out=i_alu_out;
		o_bj=i_bj;
		o_RegMux=i_RegMux;
		o_rt=i_rt;
		o_rd=i_rd;
		o_alu_b=i_alu_b;
		if(isR==1)
			o_dest=i_rd;
		else
			o_dest=i_rt;
		PCSrc=(i_Branch && i_bj && (~block) || jump);
		if(i_Branch && i_bj && (~block)==1)
			block=1;
		else
			block=0;
	end
end

endmodule