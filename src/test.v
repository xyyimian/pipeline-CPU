`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:41:05 06/05/2017
// Design Name:   top
// Module Name:   E:/cod_program/pipline/test.v
// Project Name:  pipline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst_n;

	// Outputs
	wire [31:0] cause;
	wire [31:0] EPC;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.cause(cause), 
		.EPC(EPC)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;
		#100;
		rst_n=1;
		// Wait 100 ns for global reset to finish

        
		// Add stimulus here

	end
	
	
	initial begin
	clk=0;
	forever #1 clk=~clk;
	
end
      
endmodule

