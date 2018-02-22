`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:11:49 05/22/2017 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input clk,
	 input [31:0] i_instr,
	 input [31:0] i_PCplus4,
	 input IF_ID_FLUSH,
	 input IF_ID_Write,
	 output reg [31:0] o_instr,
	 output reg [31:0] o_PCplus4,
	 output reg [4:0] rs,
	 output reg [4:0] rt
    );
	 
 
always@(posedge clk)
begin
	if(IF_ID_FLUSH==1)
	begin
		o_PCplus4=0;
		o_instr=0;
		rs=0;
		rt=0;
	end	
	else if(IF_ID_Write==1)
	begin
		o_PCplus4=i_PCplus4;
		o_instr=i_instr;
		rs=i_instr[25:21];
		rt=i_instr[20:16];
	end
end

endmodule
