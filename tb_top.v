`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:25:50 02/28/2016
// Design Name:   top
// Module Name:   C:/Users/owl/repos/ledcubectrl/tb_top.v
// Project Name:  ledcubectrl
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

module tb_top;

	// Inputs
	reg CLK_IN, RESET;

	// Outputs
	wire DOUT;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CLK_IN(CLK_IN), 
		.RESET(RESET),
		.DOUT(DOUT)
	);
	always begin
		#25 CLK_IN = ~CLK_IN;
	end
	initial begin
		// Initialize Inputs
		CLK_IN = 0;
		RESET = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RESET = 1;

	end
      
endmodule

