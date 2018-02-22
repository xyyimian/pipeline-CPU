`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:30 05/22/2017 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
    input clk,
	 input ID_EX_sel,
	 
	 input [2:0] pattern,
	 input MemtoReg,
	 input Branch,
	 input MemRead,
	 input MemWrite,
	 input RegDst,
	 input [4:0] ALUOp,
	 input ALUSrc,
	 input RegWrite,
	 input [2:0] jump,
	 input sign,
	 
	 input [31:0] ID_PCplus4,
	 input [31:0] r1_dout,
	 input [31:0] r2_dout,
	 input [31:0] SignImm,
	 input [4:0] rs,
	 input [4:0] rt,
	 input [4:0] rd,
	 input isR,
	 input [31:0] jBranch,
	 

	 output reg [2:0] o_pattern,
	 output reg o_MemtoReg,
	 output reg o_Branch,
	 output reg o_MemRead,
	 output reg o_MemWrite,
	 output reg o_RegDst,
	 output reg [4:0] o_ALUOp,
	 output reg o_ALUSrc,
	 output reg o_RegWrite,
	 output reg [2:0] o_jump,
	 
	 output reg [31:0] o_PCplus4,
	 output reg [31:0] o_r1_dout,
	 output reg [31:0] o_r2_dout,
	 output reg [31:0] o_SignImm,
	 output reg [4:0] o_rs,
	 output reg [4:0] o_rt,
	 output reg [4:0] o_rd,
	 output reg o_isR,
	 output reg [31:0] o_jBranch,
	 output reg o_sign
    );
	 
always@(posedge clk)
begin
	if(ID_EX_sel==1)
	begin
		o_pattern=0;
		o_MemtoReg=0;
		o_Branch=0;
		o_MemRead=0;
		o_MemWrite=0;
		o_RegDst=0;
		o_ALUOp=0;	
		o_ALUSrc=0;
		o_RegWrite=0;
		o_rs=0;
		o_rt=0;
		o_rd=0;
		o_isR=0;
		o_jump=0;
		o_jBranch=0;
		o_sign=0;
	end
	else
	begin
		o_pattern=pattern;
		o_MemtoReg=MemtoReg;
		o_Branch=Branch;
		o_MemRead=MemRead;
		o_MemWrite=MemWrite;
		o_RegDst=RegDst;
		o_ALUOp=ALUOp;	
		o_ALUSrc=ALUSrc;
		o_RegWrite=RegWrite;
		o_rs=rs;
		o_rt=rt;
		o_rd=rd;
		o_isR=isR;
		o_jump=jump;
		o_jBranch=jBranch;
		o_sign=sign;
	end
	
	o_PCplus4=ID_PCplus4;
	o_r1_dout=r1_dout;
	o_r2_dout=r2_dout;
	o_SignImm=SignImm;
	
end



endmodule
