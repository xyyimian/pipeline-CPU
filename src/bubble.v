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

//����bubble�ļ��������
//lw + ����������/beq�ͣ�RS/rt���֣�
//lw + sw/beq�� �ͣ���baseR��
//�ӳٷ�֧����Ҫ���1~2��bubble
//sel�ǽ��ź����
//write����ֹ�źű����ǣ�ԭ�ź���󴫲�
//flush������ź�




always@(*)
begin	//lwָ��
if(~rst_n)
begin
	PCWrite=1;
	ID_EX_sel=0;
	EX_MEM_sel=0;
	IF_ID_Write=1;
	IF_ID_FLUSH=1;		//�����������rst_n����ֹ��һ��ָ�������ˮ��
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
