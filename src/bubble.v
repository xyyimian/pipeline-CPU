`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:49 05/22/2017 
// Design Name: 
// Module Name:    bubble 
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
module bubble(
	 input clk,
	 input rst_n,
	 input [4:0] IF_ID_RS,
	 input [4:0] IF_ID_RT,
	 input [4:0] ID_EX_RT,
	 input ID_EX_MemRead,
	 input PCSrc,
	 input brk,
	 
	 output reg PCWrite,
	 output reg IF_ID_Write,
	 output reg ID_EX_sel,
	 output reg IF_ID_FLUSH,
	 output reg EX_MEM_sel
    );

//产生bubble的几种情况：
//lw + 算数运算型/beq型（RS/rt部分）
//lw + sw/beq型 型（作baseR）
//延迟分支，需要添加1~2个bubble
//sel是将信号清空
//write是阻止信号被覆盖，原信号向后传播
//flush是清空信号




always@(*)
begin	//lw指令
if(~rst_n)
begin
	PCWrite=1;
	ID_EX_sel=0;
	EX_MEM_sel=0;
	IF_ID_Write=1;
	IF_ID_FLUSH=1;		//用这个来阻塞rst_n，防止第一条指令充满流水线
end
	else
	begin
		if((ID_EX_MemRead==1)&&
			(ID_EX_RT==IF_ID_RS ||ID_EX_RT==IF_ID_RT))
		begin
			PCWrite=0;
			ID_EX_sel=1;
			IF_ID_Write=0;
			IF_ID_FLUSH=0;
		end
		
		else if(PCSrc==1 || brk==1)
		begin
			IF_ID_FLUSH=1;
			EX_MEM_sel=1;
			ID_EX_sel=1;
			IF_ID_Write=0;
		end
		else
		begin
			PCWrite=1;
			ID_EX_sel=0;
			EX_MEM_sel=0;
			IF_ID_Write=1;
			IF_ID_FLUSH=0;
		end
	end
end
endmodule
