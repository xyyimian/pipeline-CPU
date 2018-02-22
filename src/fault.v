`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:18 06/05/2017 
// Design Name: 
// Module Name:    fault 
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
module fault(
    input overflow,
	 input udfist,
	 input [31:0] of_except_addr,
	 input [31:0] udfist_except_addr,
	 output reg [31:0] cause,
	 output reg [31:0] EPC,
	 output reg brk,
	 output reg [31:0] brk_vec
    );

	always@(*)
	begin
		if(udfist==1)
		begin
			cause=32'd10;
			EPC=udfist_except_addr;
			brk=1;
			brk_vec=32'h80000000;
		end
		else if(overflow==1)
		begin
			cause=32'd12;
			EPC=of_except_addr;
			brk=1;
			brk_vec=32'h80000018;
		end
		else
		begin
			cause=0;
			EPC=0;
			brk=0;
			brk_vec=0;
		end
	end
endmodule
