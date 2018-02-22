`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:15:23 05/19/2017 
// Design Name: 
// Module Name:    transmit 
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
module transmit(
    input clk,
	 input rst_n,
	 input [4:0] EX_MEM_RD,	 //
	 input [4:0] MEM_WB_RD,		//�����������Ǽ�RD
	 input [4:0] ID_EX_RS,
	 input [4:0] ID_EX_RT,
	 input [4:0] MEM_WB_RT,
	 input MEM_WB_RegWrite,
	 input EX_MEM_RegWrite,
	 input ID_EX_MemWrite,
	 input EX_MEM_MemWrite,
	 input ID_EX_MemRead,
	 input ID_EX_isR,
	 input [4:0] EX_MEM_RT,
	 input MEM_WB_MemRead,
	 output reg [1:0] ForwardA,
	 output reg [1:0] ForwardB,
	 output reg [1:0] ForwardC
    );

//ת������Ҫ������ڣ���ID_EXд��֮��EXִ��֮ǰ���ͷ��������źŸ���EX
always@(*)
begin
if(~rst_n)
begin
	ForwardA=0;
	ForwardB=0;
	ForwardC=0;
end
	else
	begin
		if((MEM_WB_RegWrite==1) &&
		(MEM_WB_RD!=0) &&
		!((EX_MEM_RegWrite==1)&&(EX_MEM_RD!=0) &&(EX_MEM_RD==ID_EX_RS))&&
		(MEM_WB_RD==ID_EX_RS))
			ForwardA=2'b01;
		else if((EX_MEM_RegWrite==1)&&
					(EX_MEM_RD!=0)&&
					(EX_MEM_RD==ID_EX_RS))
					ForwardA=2'b10;
		else ForwardA=2'b00;
			
		if((MEM_WB_RegWrite==1) &&
		(MEM_WB_RD!=0) &&
		!((EX_MEM_RegWrite==1)&&(EX_MEM_RD!=0) &&(EX_MEM_RD==ID_EX_RT))&&
		(MEM_WB_RD==ID_EX_RT))
			ForwardB=2'b01;
		else if((EX_MEM_RegWrite==1)&&
				(ID_EX_isR==1)&&		//ȷ����ִ�е�ָ����R��ָ��
				(EX_MEM_RD!=0)&&
				(ID_EX_MemWrite!=1)&&
				(EX_MEM_RD==ID_EX_RT))
					ForwardB=2'b10;
		else ForwardB=2'b00;			
		
		if((MEM_WB_RegWrite==1)&&		//��һ��ָ����lw
			(MEM_WB_MemRead==1)&&
			(EX_MEM_MemWrite==1)&&
			(EX_MEM_RT==MEM_WB_RT))
			ForwardC=1;
			else if((MEM_WB_RegWrite==1)&&		//��һ��ָ����ALUָ��
				(MEM_WB_MemRead==0)&&
				(EX_MEM_MemWrite==1)&&
				(EX_MEM_RT==MEM_WB_RD))		//�����ǰһ��ת��Ҳ���ж�����
			ForwardC=2'd2;
			else
				ForwardC=0;		
	end
end

//�����и��ܵ������⣬rt��R��ָ������Դ����������Ҫת������I��ָ������Ŀ�Ĳ�����������Ҫת��
/*
always@(*)
begin
	if((MEM_WB_RegWrite==1)&&
		(MEM_WB_RD!=0)&&
		!((EX_MEM_RegWrite==1)&&(EX_MEM_RD!=0))&&
		(MEM_WB_RD==ID_EX_RT))
			ForwardB=2'b01;
	else if((EX_MEM_RegWrite==1)&&
//			(ID_EX_isR==1)&&		//ȷ����ִ�е�ָ����R��ָ��
			(EX_MEM_RD!=0)&&
			(EX_MEM_RD==ID_EX_RT))
				ForwardB=2'b10;
	else ForwardB=2'b00;
end

always@(*)	//������lw��sw������
begin
	if((MEM_WB_RegWrite==1)&&
		(EX_MEM_MemWrite==1)&&
		(EX_MEM_RT==MEM_WB_RT))
		ForwardC=1;
	else
		ForwardC=0;
end
*/
/*
always@(posedge clk)
begin
	if((ID_EX_MemRead==1)&&
		((ID_EX_RT==IF_ID_RS) || (ID_EX_RT==IF_ID_RT)))
		stall=1;
	else
		stall=0;
end
*/					

endmodule
