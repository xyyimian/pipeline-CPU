`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:28:50 05/10/2017 
// Design Name: 
// Module Name:    control 
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
module control(
    input clk,
	 input rst_n,	 
	 input [31:0] instr,
	 input [31:0] PCplus4,
	 output reg Extop,
	 output reg RegDst,
	 output reg Branch,
	 output reg MemRead,
	 output reg MemtoReg,
	 output reg MemWrite,
	 output reg [4:0] ALUOp,
	 output reg RegWrite,
	 output reg ALUSrc,
//	 output reg PCSrc,
	 output reg [2:0] pattern,
	 output reg [2:0] jump,
	 output reg sign,
	 
	 output reg isR,
	 output reg udfist,
	 output reg [31:0] except_addr
    );
wire [5:0] Op;
assign Op=instr[31:26];
wire [5:0] Funct;
assign Funct=instr[5:0];
reg PCSrc;

	always@(*)
	begin
		if(~rst_n)
		begin
			PCSrc=0;
			RegDst=0;
			Branch=0;
			MemtoReg=0;
			MemWrite=0;
			ALUOp=0;
			ALUSrc=0;
			PCSrc=0;
			Extop=0;
			jump=0;
			pattern=0;
			MemRead=0;
			RegWrite=0;
			isR=0;
			sign =0;
		end
		else
		case(Op)
		6'b000000:begin
			if(Funct==6'b100000)	//add	
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=1;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=1;
			end
			else if(Funct==6'b100001)	//addu
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=1;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=0;
			end			
			else if(Funct==6'b100011)	//subu
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd2;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=0;
			end
			else if(Funct==6'b100010)	//sub
			begin
				MemWrite=0;
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				RegWrite=1;
				ALUOp=5'd2;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=1;
			end
			else if(Funct==6'b100100)	//and
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd3;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=0;
			end
			else if(Funct==6'b100101)	//or
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd4;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=0;
			end
			else if(Funct==6'b100111)	//nor
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd6;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=0;
			end
			else if(Funct==6'b100110)	//xor
			begin
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd5;
				RegWrite=1;
				ALUSrc=0;
				PCSrc=0;
				RegWrite=1;
				jump=0;
				isR=1;
				sign=0;
			end
			else if(Funct==6'b011000)
			begin
				MemWrite=0;
				MemRead=0;			
				RegDst=1;
				Branch=0;
				MemtoReg=0;
				RegWrite=1;
				ALUOp=5'd7;
				ALUSrc=0;
				PCSrc=0;
				jump=0;
				isR=1;
				sign=1;
			end
			else if(Funct==6'b001000)	//jr
				begin
				MemRead=0;				
				RegDst=0;
				Branch=1;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd1;
				RegWrite=0;
				ALUSrc=0;
				PCSrc=1;
				Extop=0;
				isR=0;
				jump=2;
				sign=0;
				end
			else
					jump=0;
		end
		6'b001000:	//addi
			begin
				MemRead=0;			
				RegDst=0;
				Branch=0;
				MemtoReg=0;
				RegWrite=1;
				ALUOp=5'd1;
				ALUSrc=1;
				PCSrc=0;
				Extop=1;
				jump=0;
				isR=0;
				MemWrite=0;
				sign=1;
			end
		6'b001001:	//addiu
			begin
				MemRead=0;			
				RegDst=0;
				Branch=0;
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd1;
				RegWrite=1;	
				ALUSrc=1;
				PCSrc=0;
				Extop=1;
				jump=0;
				isR=0;
				sign=0;
			end
		6'b001100:		//andi
			begin
				MemRead=0;			
				RegDst=0;
				Branch=0;	
				MemtoReg=0;
				MemWrite=0;
				ALUOp=5'd3;				
				RegWrite=1;
				ALUSrc=1;
				PCSrc=0;
				Extop=1;
				jump=0;
				isR=0;
				sign=0;
			end	
		6'b000111:	//bgtz
			begin
				MemRead=0;			
				Branch=1;
				MemWrite=0;
				ALUOp=5'd2;				
				RegWrite=0;
				ALUSrc=0;
				Extop=1;
				jump=0;
				pattern=1;		//为之后运算bj指定方案
				isR=0;
				sign=0;
			end
		6'b000101:	//bne
			begin
				MemRead=0;			
				Branch=1;
				MemWrite=0;
				ALUOp=5'd2;
				RegWrite=0;
				ALUSrc=0;
				Extop=1;
				jump=0;
				pattern=3'd2;
				isR=1;
				sign=0;
			end
		6'b000001:		//bgez
			begin
				MemRead=0;			
				Branch=1;
				MemWrite=0;
				ALUOp=5'd2;
				RegWrite=0;
				ALUSrc=0;
				Extop=1;
				jump=0;
				isR=0;
				if(instr[20:16]==5'b00001)
					pattern=3'd2;
				else if(instr[20:16]==5'b00000)
					pattern=3'd4;		//小于0，bltz
			end
		6'b000110:		//blez,<=0
			begin
				MemWrite=0;
				MemRead=0;			
				Branch=1;
				MemWrite=0;
				ALUOp=5'd2;
				RegWrite=0;
				ALUSrc=0;
				Extop=1;
				jump=0;
				pattern=3'd3;
				isR=0;
			end
		6'b000010:		//j
			begin
				MemRead=0;			
				jump=1;
				Branch=1;
				RegWrite=0;
				MemWrite=0;
				PCSrc=1;
				Extop=0;
				isR=0;
			end
		6'b000000:		//jr
			begin
				MemWrite=0;
				jump=1;
				ALUSrc=0;
				Branch=1;
				isR=0;
			end
		6'b100011:	//lw
			begin
				MemtoReg=1;
				RegDst=0;
				ALUOp=1;
				ALUSrc=1;
				MemWrite=0;
				MemRead=1;
				PCSrc=0;
				Extop=1;
				jump=0;
				RegWrite=1;
				isR=0;
			end
		6'b101011:		//sw
			begin
				RegWrite=0;	
				Branch=0;
				ALUOp=1;
				ALUSrc=1;
				PCSrc=0;
				MemWrite=1;
				MemRead=0;
				jump=0;
				Extop=1;
				isR=1;
			end
		default:
		begin
			udfist=1;
			except_addr=PCplus4-4;
		end
		endcase
	end
	
	
endmodule
