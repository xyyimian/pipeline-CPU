`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:51 05/10/2017 
// Design Name: 
// Module Name:    EX 
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
module EX(
    input rst_n,
	 input [31:0] PCplus4,
    input [31:0] r1_dout,
    input [31:0] r2_dout,
    input [31:0] SignImm,
    input [4:0] rt,
    input [4:0] rd,
	 input [4:0] rs,
	 input [31:0] i_douta_alu_out,
	 input [2:0] pattern,
	 input ALUSrc,
	 input RegDst,
	 input [31:0] i_alu_out,
	 input [1:0] ForwardA,
	 input [1:0] ForwardB,
	 input [4:0] ALUOp,
	 input [2:0] jump,
	 input [31:0] jBranch,
	 input sign,
	 

	 output reg bj,
	 output reg [31:0] alu_b,
    output [31:0] alu_out,
    output [4:0] RegMux,
	 output reg [31:0] PCBranch,
	 output reg [31:0] except_addr,
	 output reg overflow
    );



wire SF;
wire ZF;
reg [31:0] alu_a;



always@(*)
begin
	case(ForwardA)
	2'b00:alu_a=r1_dout;
	2'b01:alu_a=i_douta_alu_out;
	2'b10:alu_a=i_alu_out;
	default:
		;
	endcase
end

always@(*)
begin
	case(ForwardB)
		2'b00:alu_b=alu_bpre;
		2'b01:alu_b=i_douta_alu_out;
		2'b10:alu_b=i_alu_out;
		default:
			;
	endcase
end


	
always@(*)
begin
if(~rst_n)
	bj=0;
else if(pattern==3'd2)
	bj=~ZF;
else if(pattern==1)
	bj=SF&(~ZF);
end


always@(*)
begin
	if(jump==1)
		PCBranch=jBranch;
	else if(jump==3'd2)		//此处要考虑转发
		PCBranch=alu_a;
	else
		PCBranch=SignImm*4+PCplus4;
end

wire [31:0] alu_bpre;

assign alu_bpre=(ALUSrc==0)?r2_dout:SignImm;
assign RegMux=(RegDst==0)?rt:rd;




wire OF;

always@(*)
begin
	if((ALUOp==1 || ALUOp==5'd2)&&sign==1 && OF==1)
	begin
		overflow=1;
		except_addr=PCplus4-4;
	end
	else
	begin
		overflow=0;
		except_addr=0;
	end
end
				
			
		




alu			u_alu(
.rst_n			(rst_n		),
.alu_a			(alu_a		),
.alu_b			(alu_b		),
.alu_op			(ALUOp		),
.alu_out			(alu_out		),
.SF				(SF			),
.ZF				(ZF			),
.OF				(OF			)
);



endmodule
