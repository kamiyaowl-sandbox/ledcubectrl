`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:14 02/28/2016 
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
    input CLK_IN,
	 input RESET,
    output DOUT
    );
  wire clk_20MHz, clk_100MHz;
  clk_gen clk_gen1 (// Clock in ports
    .CLK_IN1(CLK_IN),      // IN
    // Clock out ports
    .CLK_100MHz(clk_100MHz),     // OUT
    .CLK_20MHz(clk_20MHz)
	);    // OUT

	wire [23:0] ram_data;
	wire [9:0]  ram_addr;

	ws2812b_driver ws2812b_driver1 (
		 .CLK(clk_20MHz), 
		 .RESET(RESET), 
		 .RAM_DATA(ram_data), 
		 .RAM_ADDR(ram_addr), 
		 .DOUT(DOUT)
	);


	frame_buffer frame_buffer1 (
	  .clka(clk_100MHz), // input clka
	  .ena(1'b0), // input ena
	  .wea(1'b0), // input [0 : 0] wea
	  .addra(10'b0), // input [9 : 0] addra
	  .dina(24'b0), // input [23 : 0] dina
	  .clkb(clk_20MHz), // input clkb
	  .enb(1'b1), // input enb
	  .addrb(ram_addr), // input [9 : 0] addrb
	  .doutb(ram_data) // output [23 : 0] doutb
	);

endmodule
