`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:04 05/10/2017 
// Design Name: 
// Module Name:    ID 
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
module ID(
    input clk,
    input rst_n,
    input [4:0] r3_addr,
    input r3_wr,
    input [31:0] r3_din,
	 
	 input [31:0] i_PCplus4,
    input [31:0] instr,
	 
	 input Extop,
	 
    output [31:0] r1_dout,
    output [31:0] r2_dout,
    output reg [31:0] SignImm,
    output [31:0] o_PCplus4,

	 output [4:0] rs,
	 output [4:0] rt,
	 output [4:0] rd,
	 output [31:0] jBranch

    );

wire [4:0] r1_addr;
wire [4:0] r2_addr;

assign r1_addr=instr[25:21];
assign r2_addr=instr[20:16];
 
assign o_PCplus4=i_PCplus4;
assign rs=instr[25:21];
assign rt=instr[20:16];
assign rd=instr[15:11];



always@(*)
begin
//	if(jump==1)		//对j指令需要单独译码，否则输出的SignImm就错了
//		SignImm=(instr<<6)>>6;
//	else 
	if(Extop==0)
		SignImm=((instr<<16)>>14);
	else
		SignImm=((instr<<16)>>16)+32'hffff0000*instr[15];
end
	 
assign jBranch=(instr<<6)>>4;
	 
	 
	 
register_group			u_register_group(
.clk					(clk			),
.rst_n				(rst_n		),
.r1_addr				(r1_addr		),
.r2_addr				(r2_addr		),
.r3_addr				(r3_addr		),
.r3_din				(r3_din		),
.r3_wr				(r3_wr		),		//可以用实参的某一位例化！！
.r1_dout				(r1_dout		),
.r2_dout				(r2_dout		)
);


endmodule
