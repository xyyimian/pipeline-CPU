`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:38:35 05/10/2017 
// Design Name: 
// Module Name:    MEM 
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
module MEM(
	 input clk,
	 input MemWrite,
	 input MemRead,
	 input Branch,
	 input bj,

	 
    input [31:0] alu_out,
    input [31:0] alu_b,
    input [4:0] RegMux,
	 input [1:0] ForwardC,
	 input [31:0] i_douta,
	 input [31:0] MEM_WB_alu_out,

    output [4:0] o_RegMux,
	 output [31:0] o_alu_out,
	 output [31:0] douta
    );
	 

reg [31:0] dina;
wire [31:0] douta_pre;
assign douta=(MemRead==1)?douta_pre:32'b0;


always@(*)
begin
	if(ForwardC==1)
		dina=i_douta;
	else if(ForwardC==2'd2)
		dina=MEM_WB_alu_out;
	else dina=alu_b;
end


assign o_RegMux=RegMux;
assign o_alu_out=alu_out;		

wire [31:0] Realaddr;
assign Realaddr=alu_out>>2;





DM			u_DM(
.clk			(clk			),
.a				(Realaddr		),
.d				(dina			),
.we			(MemWrite	),
.spo			(douta_pre	)
);


endmodule
