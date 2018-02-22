`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:19 05/10/2017 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input clk,
    input rst_n,
	 input [31:0] PCBranch,
	 input PCWrite,
	 input PCSrc,
	 input brk,
	 input [31:0] brk_vec,
    output reg [31:0] PCplus4,
    output [31:0] instr
    );
	 
	
	reg [31:0] PC;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			PC=0;
			PCplus4=4;		
		end
		else if(brk==1)
			PC=brk_vec;
		else if(PCWrite==1)
		begin
			if(PCSrc==0)
				PC=PCplus4;
			else PC=PCBranch;
			PCplus4=PC+4;			//（错,必须给PC一个初值）因为阻塞性赋值，竟然先赋值PC后PCplus4会有效。。。。,
		end
	end
	
	wire [31:0] RealPC;
	
assign RealPC=PC>>2;
	
IM			u_IM(
.a				(RealPC		),
.spo			(instr	)
);	


endmodule
