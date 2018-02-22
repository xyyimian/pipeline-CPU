`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:25 05/12/2017 
// Design Name: 
// Module Name:    top 
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
module top(
    input clk,
    input rst_n,
    output [31:0] cause,
	 output [31:0] EPC
    );
//发现一件事，端口的线网变量有默认声明，所以wire的声明不能放在模块的使用之后


	

//assign PCjump=(instr<<6)>>4+(PCplus4>>28)<<28;



//IF

wire [31:0] IF_PCplus4;
wire [31:0] IF_instr;

//IF_ID

wire [31:0] IF_ID_instr;
wire [31:0] IF_ID_PCplus4;

//ID
wire [31:0] ID_r1_dout;
wire [31:0] ID_r2_dout;
wire [31:0] ID_SignImm;
wire [31:0] ID_PCplus4;
wire [4:0] ID_rs;
wire [4:0] ID_rt;
wire [4:0] ID_rd;
wire [31:0] jBranch;

//ID_EX
wire [2:0] ID_EX_pattern;
wire ID_EX_MemtoReg;
wire ID_EX_Branch;
wire ID_EX_MemRead;
wire ID_EX_MemWrite;
wire ID_EX_RegDst;
wire [4:0] ID_EX_ALUOp;
wire ID_EX_ALUSrc;
wire ID_EX_RegWrite;
wire ID_EX_isR;
wire [31:0] ID_EX_PCplus4;
wire [31:0] ID_EX_r1_dout;
wire [31:0] ID_EX_r2_dout;
wire [31:0] ID_EX_SignImm;
wire [4:0] ID_EX_rs;
wire [4:0] ID_EX_rt;
wire [4:0] ID_EX_rd;
wire [31:0] ID_EX_jBranch;
wire [2:0] ID_EX_jump;
wire ID_EX_sign;

//EX
wire EX_bj;
wire [31:0] EX_alu_b;
wire [31:0] EX_alu_out;
wire [4:0] EX_RegMux;
wire [31:0] EX_PCBranch;
wire [4:0] EX_rt;
wire [4:0] EX_rd;
wire [2:0] EX_jump;

//EX_MEM
wire EX_MEM_MemtoReg;
wire EX_MEM_Branch;
wire EX_MEM_MemRead;
wire EX_MEM_MemWrite;
wire [31:0] EX_MEM_PCBranch;
wire EX_MEM_RegWrite;
wire [31:0] EX_MEM_alu_out;
wire EX_MEM_bj;
wire [4:0] EX_MEM_RegMux;
wire [31:0] EX_MEM_alu_b;
wire [4:0] EX_MEM_rt;
wire [4:0] EX_MEM_rd;
wire [4:0] EX_MEM_dest;
wire EX_MEM_PCSrc;
wire EX_MEM_isR;


//MEM
wire [31:0] MEM_douta;
wire [31:0] MEM_alu_out;
wire [4:0] MEM_RegMux;
wire [31:0] MEM_PCBranch;


//MEM_WB

wire MEM_WB_RegWrite;
wire MEM_WB_MemtoReg;
wire MEM_WB_MemRead;
wire [31:0] MEM_WB_douta;
wire [31:0] MEM_WB_alu_out;
wire [4:0] MEM_WB_RegMux;
wire [4:0] MEM_WB_rd;
wire [4:0] MEM_WB_rt;
wire [4:0] MEM_WB_dest;

//WB
wire [31:0] WB_r3_din;
wire [4:0] WB_r3_addr;
wire WB_RegWrite;

//CONTROL
wire Extop;
wire RegDst;
wire Branch;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire [4:0] ALUOp;
wire RegWrite;
wire ALUSrc;
wire PCSrc;
wire [2:0] pattern;
wire [2:0] jump;
wire isR;
wire sign;

//TRANSMIT

wire [1:0] ForwardA;
wire [1:0] ForwardB;
wire [1:0] ForwardC;



//BUBBLE
wire PCWrite;
wire IF_ID_Write;
wire ID_EX_sel;
wire IF_ID_FLUSH;
wire [4:0] IF_ID_rs;
wire [4:0] IF_ID_rt;

//fault
wire [31:0] of_except_addr;
wire [31:0] udfist_except_addr;
wire overflow;
wire udfist;
wire brk;
wire [31:0] brk_vec;

IF				u_IF(
.PCBranch		(EX_MEM_PCBranch	),
.PCSrc			(EX_MEM_PCSrc	),
.clk				(clk		),
.rst_n			(rst_n	),
.PCWrite			(PCWrite),
.PCplus4			(IF_PCplus4	),
.instr			(IF_instr	),
.brk				(brk			),
.brk_vec			(brk_vec		)
);





IF_ID				u_IF_ID(
.clk				(clk			),
.i_instr			(IF_instr	),
.i_PCplus4		(IF_PCplus4),
.IF_ID_Write	(IF_ID_Write	),
.IF_ID_FLUSH	(IF_ID_FLUSH	),

.o_instr			(IF_ID_instr),
.o_PCplus4		(IF_ID_PCplus4	),
.rs				(IF_ID_rs		),
.rt				(IF_ID_rt		)
);





ID					u_ID(
.clk				(clk			),
.rst_n			(rst_n		),
.r3_addr			(WB_r3_addr	),
.r3_wr			(WB_RegWrite),
.r3_din			(WB_r3_din	),
.i_PCplus4		(IF_ID_PCplus4	),
.instr			(IF_ID_instr	),
.Extop			(Extop		),
.r1_dout			(ID_r1_dout	),
.r2_dout			(ID_r2_dout	),
.SignImm			(ID_SignImm	),
.o_PCplus4		(ID_PCplus4	),
.rs				(ID_rs		),
.rt				(ID_rt		),
.rd				(ID_rd		),
.jBranch			(jBranch		)
);





ID_EX			u_ID_EX(
.clk				(clk			),
.ID_EX_sel		(ID_EX_sel	),
.pattern			(pattern		),
.MemtoReg		(MemtoReg	),
.Branch			(Branch		),
.MemRead			(MemRead		),
.MemWrite		(MemWrite	),
.RegDst			(RegDst		),
.ALUOp			(ALUOp		),
.ALUSrc			(ALUSrc		),
.RegWrite		(RegWrite	),
.sign				(sign			),
.ID_PCplus4		(ID_PCplus4	),
.r1_dout			(ID_r1_dout	),
.r2_dout			(ID_r2_dout	),
.SignImm			(ID_SignImm	),
.rs				(ID_rs		),
.rt				(ID_rt		),
.rd				(ID_rd		),
.isR				(isR			),
.jBranch			(jBranch		),
.jump				(jump			),

.o_jump			(ID_EX_jump	),
.o_pattern		(ID_EX_pattern	),
.o_MemtoReg		(ID_EX_MemtoReg),
.o_Branch		(ID_EX_Branch),
.o_MemRead		(ID_EX_MemRead),
.o_MemWrite		(ID_EX_MemWrite),
.o_RegDst		(ID_EX_RegDst	),
.o_ALUOp			(ID_EX_ALUOp	),
.o_ALUSrc		(ID_EX_ALUSrc	),
.o_RegWrite		(ID_EX_RegWrite),
.o_PCplus4		(ID_EX_PCplus4	),
.o_sign			(ID_EX_sign		),
.o_r1_dout		(ID_EX_r1_dout	),
.o_r2_dout		(ID_EX_r2_dout	),
.o_SignImm		(ID_EX_SignImm	),
.o_rs				(ID_EX_rs		),
.o_rt				(ID_EX_rt		),
.o_rd				(ID_EX_rd		),
.o_isR			(ID_EX_isR		),
.o_jBranch		(ID_EX_jBranch	)
);




EX				u_EX(
.rst_n			(rst_n			),
.PCplus4			(ID_EX_PCplus4		),
.r1_dout			(ID_EX_r1_dout		),
.r2_dout			(ID_EX_r2_dout		),
.SignImm			(ID_EX_SignImm		),
.rt				(ID_EX_rt		),
.rd				(ID_EX_rd		),
.rs				(ID_EX_rs		),
.ALUOp			(ID_EX_ALUOp	),
.i_douta_alu_out	(WB_r3_din	),
.pattern			(ID_EX_pattern	),
.i_alu_out		(EX_MEM_alu_out),
.ALUSrc			(ID_EX_ALUSrc	),
.RegDst			(ID_EX_RegDst	),
.ForwardA		(ForwardA		),
.ForwardB		(ForwardB		),
.jBranch			(ID_EX_jBranch	),
.jump				(ID_EX_jump		),
.sign				(ID_EX_sign		),

.bj				(EX_bj			),
.alu_b			(EX_alu_b		),
.alu_out			(EX_alu_out		),
.RegMux			(EX_RegMux		),
.PCBranch		(EX_PCBranch	),
.overflow		(overflow		),
.except_addr	(of_except_addr	)
);






EX_MEM			u_EX_MEM(
.clk				(clk			),
.rst_n			(rst_n		),
.i_MemtoReg		(ID_EX_MemtoReg	),
.i_Branch		(ID_EX_Branch		),
.i_MemRead		(ID_EX_MemRead		),
.i_MemWrite		(ID_EX_MemWrite	),
.i_RegWrite		(ID_EX_RegWrite	),
.i_alu_out		(EX_alu_out		),
.i_bj				(EX_bj			),
.i_RegMux		(EX_RegMux		),
.i_PCBranch		(EX_PCBranch	),
.i_alu_b			(EX_alu_b	),
.i_rt				(ID_EX_rt			),
.i_rd				(ID_EX_rd			),
.isR				(ID_EX_isR			),
.EX_MEM_sel		(EX_MEM_sel		),
.jump				(ID_EX_jump			),


.o_MemtoReg		(EX_MEM_MemtoReg	),
.o_Branch		(EX_MEM_Branch		),
.o_MemRead		(EX_MEM_MemRead	),
.o_MemWrite		(EX_MEM_MemWrite	),
.o_PCBranch		(EX_MEM_PCBranch	),
.o_RegWrite		(EX_MEM_RegWrite	),
.o_alu_out		(EX_MEM_alu_out	),
.o_bj				(EX_MEM_bj			),
.o_RegMux		(EX_MEM_RegMux),
.o_alu_b			(EX_MEM_alu_b	),
.o_rt				(EX_MEM_rt		),
.o_rd				(EX_MEM_rd		),
.o_dest			(EX_MEM_dest	),
.PCSrc	(EX_MEM_PCSrc	)
);






MEM			u_MEM(
.clk				(clk			),
.MemWrite		(EX_MEM_MemWrite	),
.MemRead			(EX_MEM_MemRead	),
.Branch			(EX_MEM_Branch		),
.bj				(EX_MEM_bj		),
.ForwardC		(ForwardC		),
.alu_out			(EX_MEM_alu_out),
.alu_b			(EX_MEM_alu_b),
.RegMux			(EX_MEM_RegMux	),
.i_douta			(MEM_WB_douta),
.MEM_WB_alu_out	(MEM_WB_alu_out),


.o_alu_out		(MEM_alu_out	),
.o_RegMux		(MEM_RegMux		),
.douta			(MEM_douta	)
);





MEM_WB			u_MEM_WB(
.clk				(clk			),
.RegWrite		(EX_MEM_RegWrite	),
.MemtoReg		(EX_MEM_MemtoReg	),
.MemRead			(EX_MEM_MemRead	),
.douta			(MEM_douta		),
.alu_out			(MEM_alu_out	),
.RegMux			(MEM_RegMux		),
.rt				(EX_MEM_rt		),
.dest				(EX_MEM_dest	),

.o_RegWrite		(MEM_WB_RegWrite	),
.o_MemtoReg		(MEM_WB_MemtoReg	),
.o_MemRead		(MEM_WB_MemRead	),
.o_douta			(MEM_WB_douta		),
.o_alu_out		(MEM_WB_alu_out	),
.o_RegMux		(MEM_WB_RegMux		),
.o_rt				(MEM_WB_rt			),
.o_dest			(MEM_WB_dest		)
);


WB				u_WB(
.clk				(clk			),
.rst_n			(rst_n		),
.douta			(MEM_WB_douta	),
.alu_out			(MEM_WB_alu_out),
.MemtoReg		(MEM_WB_MemtoReg),
.RegWrite		(MEM_WB_RegWrite),
.RegMux			(MEM_WB_RegMux	),

.r3_din			(WB_r3_din	),
.r3_addr			(WB_r3_addr	),
.o_RegWrite		(WB_RegWrite)
);





control				u_control(
.clk				(clk			),
.rst_n			(rst_n		),
.instr			(IF_ID_instr),
.PCplus4			(IF_ID_PCplus4	),

.Extop			(Extop		),
.RegDst			(RegDst		),
.Branch			(Branch		),
.MemRead			(MemRead		),
.MemtoReg		(MemtoReg	),
.MemWrite		(MemWrite	),
.ALUOp			(ALUOp		),
.RegWrite		(RegWrite	),
.ALUSrc			(ALUSrc		),
.pattern			(pattern		),
.jump				(jump			),
.sign				(sign			),
.isR				(isR			),
.udfist			(udfist		),
.except_addr	(udfist_except_addr)
);



transmit				u_transmit(
.clk						(clk			),
.rst_n					(rst_n			),
.ID_EX_RS				(ID_EX_rs	),
.ID_EX_RT				(ID_EX_rt	),
.ID_EX_MemRead			(ID_EX_MemRead	),
.EX_MEM_RD				(EX_MEM_dest	),
.EX_MEM_RT				(EX_MEM_rt	),
.EX_MEM_RegWrite		(EX_MEM_RegWrite),
.ID_EX_MemWrite		(ID_EX_MemWrite	),
.EX_MEM_MemWrite		(EX_MEM_MemWrite),
.MEM_WB_RD				(MEM_WB_dest	),
.MEM_WB_RT				(MEM_WB_rt		),
.MEM_WB_RegWrite		(MEM_WB_RegWrite	),
.ID_EX_isR				(ID_EX_isR		),
.MEM_WB_MemRead		(MEM_WB_MemRead	),

.ForwardA				(ForwardA	),
.ForwardB				(ForwardB	),
.ForwardC				(ForwardC	)
);



bubble				u_bubble(
.clk					(clk				),
.rst_n				(rst_n			),
.IF_ID_RS			(IF_ID_rs		),
.IF_ID_RT			(IF_ID_rt		),
.ID_EX_RT			(ID_EX_rt		),
.ID_EX_MemRead		(ID_EX_MemRead	),
.PCSrc				(EX_MEM_PCSrc	),
.brk					(brk				),

.PCWrite				(PCWrite			),
.IF_ID_Write		(IF_ID_Write	),
.ID_EX_sel			(ID_EX_sel		),
.EX_MEM_sel			(EX_MEM_sel		),
.IF_ID_FLUSH		(IF_ID_FLUSH	)
);

fault					u_fault(
.overflow			(overflow		),
.udfist				(udfist			),
.of_except_addr	(of_except_addr	),
.udfist_except_addr		(udfist_except_addr	),
.cause				(cause			),
.EPC					(EPC				),
.brk					(brk				),
.brk_vec				(brk_vec			)
);




endmodule
