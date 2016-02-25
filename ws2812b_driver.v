`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:44:17 02/24/2016 
// Design Name: 
// Module Name:    ws2812b_driver 
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
module ws2812b_driver(
    input CLK,//20MHz(@0.05us)
    input RESET,
    input EN,
	 
    input [23:0] RAM_DATA,
    output reg [9:0] RAM_ADDR,
    output reg DOUT
    );
	localparam  RAM_ADDRESS_MAX = 10'd512;
	reg address_counter_reset;
	reg address_increment;
	
	reg send_reset_code;
	reg [23:0] ram_data_ratch;
	reg [4:0] pwm_pixel_counter;
	reg [9:0] pwm_counter;

	/* Block RAM DataRatch*/
	always @ (negedge CLK) begin
		if(RESET == 1'b1 && address_counter_reset == 1'b1) begin
			if(address_increment == 1'b1) begin
				//Address Increment
				if(RAM_ADDR < RAM_ADDRESS_MAX) begin
					RAM_ADDR <= RAM_ADDR + 10'b1;
				end else begin
					RAM_ADDR <= 10'b0;
				end
			end else begin
				ram_data_ratch <= RAM_DATA;
			end
		end else begin
			//RESET
			RAM_ADDR <= 10'b0;
			ram_data_ratch <= 24'b0;
		end
	end
	
	/* PWM Create */
	always @ (negedge CLK) begin
		if(RESET == 1'b1) begin
			if(send_reset_code) begin
				//Reset Sequence + Data
				if(pwm_counter < 10'd1000) begin
					//RESET
					DOUT <= 1'b0;
				end else begin	
					send_reset_code = 1'b0;
				end
			end else begin
					/* RESET */
					DOUT <= 1'b0;
					send_reset_code <= 1'b1;
					address_counter_reset <= 1'b1;/////////////////////////////////////////////
			end
			
			if(RAM_ADDR == 10'b0) begin

				//TODO:Function
					case(pwm_pixel_counter) 
						5'd0  : DOUT <= RAM_DATA[23];
						5'd1  : DOUT <= RAM_DATA[22];
						5'd2  : DOUT <= RAM_DATA[21];
						5'd3  : DOUT <= RAM_DATA[20];
						5'd4  : DOUT <= RAM_DATA[19];
						5'd5  : DOUT <= RAM_DATA[18];
						5'd6  : DOUT <= RAM_DATA[17];
						5'd7  : DOUT <= RAM_DATA[16];
						5'd8  : DOUT <= RAM_DATA[15];
						5'd9  : DOUT <= RAM_DATA[14];
						5'd10 : DOUT <= RAM_DATA[13];
						5'd11 : DOUT <= RAM_DATA[12];
						5'd12 : DOUT <= RAM_DATA[11];
						5'd13 : DOUT <= RAM_DATA[10];
						5'd14 : DOUT <= RAM_DATA[ 9];
						5'd15 : DOUT <= RAM_DATA[ 8];
						5'd16 : DOUT <= RAM_DATA[ 7];
						5'd17 : DOUT <= RAM_DATA[ 6];
						5'd18 : DOUT <= RAM_DATA[ 5];
						5'd19 : DOUT <= RAM_DATA[ 4];
						5'd20 : DOUT <= RAM_DATA[ 3];
						5'd21 : DOUT <= RAM_DATA[ 2];
						5'd22 : DOUT <= RAM_DATA[ 1];
						5'd23 : DOUT <= RAM_DATA[ 0];
					endcase
				end
			end else begin
				//Data
			end
		end else begin
			//RESET
			DOUT <= 1'b0;
			address_counter_reset <= 1'b0;
			address_increment <= 1'b0;
	
			send_reset_code <= 1'b1;
		end
	end

endmodule
