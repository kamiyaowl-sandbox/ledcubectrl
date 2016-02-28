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
	 
    input [23:0] RAM_DATA,
    output reg [9:0] RAM_ADDR,
    output reg DOUT
    );
	localparam RAM_ADDRESS_MAX = 10'd512 - 10'd1;
	localparam RAM_DATA_WIDTH  = 5'd24 - 5'd1;//50us
	localparam COUNT_RESET = 10'd1000 - 10'd1;//50us
	localparam COUNT_TH_TL = 10'd25 - 10'd1;//1.25us
	localparam COUNT_T0H = 10'd8;//0.4us
	localparam COUNT_T0L = 10'd17;//0.85us
	localparam COUNT_T1H = 10'd16;//0.8us
	localparam COUNT_T1L = 10'd9;//0.45us
	
	reg       send_reset_code;
	reg [4:0] send_data_index;
	reg [9:0] pwm_counter;//50us = 1000count / 1.25us = 25count
	
	always @ (negedge CLK) begin
		if(RESET == 1'b0) begin
			//RESET
			RAM_ADDR <= 10'b0;
			DOUT 		<= 1'b0;
			
			send_reset_code  <= 1'b0;
			send_data_index  <= 5'b0;
			pwm_counter      <= 10'b0;
		end else begin
			if(send_reset_code == 1'b0) begin
				if(pwm_counter < COUNT_RESET) begin
					pwm_counter <= pwm_counter + 10'b1;
				end else begin
					pwm_counter 	  <= 10'b0;
					send_reset_code  <= 1'b1;
					send_data_index  <= 5'b0;
					pwm_counter      <= 10'b0;
					//BlockRAM Read
					RAM_ADDR <= 10'b0;
				end
			end else begin
					//PWM Decode
					if(send_data(send_data_index) == 1'b0) begin
						if(pwm_counter < COUNT_T0H) DOUT <= 1'b1;
						else 								 DOUT <= 1'b0;
					end else begin
						if(pwm_counter < COUNT_T1H) DOUT <= 1'b1;
						else 								 DOUT <= 1'b0;
					end
					
					if(pwm_counter < COUNT_TH_TL) begin
						//Counter Increment
						pwm_counter <= pwm_counter + 10'b1;
					end else if(send_data_index < RAM_DATA_WIDTH) begin
						//Data Decrement
						pwm_counter <= 10'b0;
						send_data_index <= send_data_index + 5'b1;
					end else if(RAM_ADDR < RAM_ADDRESS_MAX) begin
						//Pixel Increment
						pwm_counter <= 10'b0;
						send_data_index <= 5'b0;
						RAM_ADDR <= RAM_ADDR + 10'b1;
					end else begin
						//RESET
						RAM_ADDR <= 10'b0;
						DOUT 		<= 1'b0;
						send_reset_code  <= 1'b0;
					end
			end
		end
	end
	
	
	function send_data(
	 input [4:0] cnt
	);
	begin
		case(cnt) 
			5'd0  : send_data = RAM_DATA[23];
			5'd1  : send_data = RAM_DATA[22];
			5'd2  : send_data = RAM_DATA[21];
			5'd3  : send_data = RAM_DATA[20];
			5'd4  : send_data = RAM_DATA[19];
			5'd5  : send_data = RAM_DATA[18];
			5'd6  : send_data = RAM_DATA[17];
			5'd7  : send_data = RAM_DATA[16];
			5'd8  : send_data = RAM_DATA[15];
			5'd9  : send_data = RAM_DATA[14];
			5'd10 : send_data = RAM_DATA[13];
			5'd11 : send_data = RAM_DATA[12];
			5'd12 : send_data = RAM_DATA[11];
			5'd13 : send_data = RAM_DATA[10];
			5'd14 : send_data = RAM_DATA[ 9];
			5'd15 : send_data = RAM_DATA[ 8];
			5'd16 : send_data = RAM_DATA[ 7];
			5'd17 : send_data = RAM_DATA[ 6];
			5'd18 : send_data = RAM_DATA[ 5];
			5'd19 : send_data = RAM_DATA[ 4];
			5'd20 : send_data = RAM_DATA[ 3];
			5'd21 : send_data = RAM_DATA[ 2];
			5'd22 : send_data = RAM_DATA[ 1];
			5'd23 : send_data = RAM_DATA[ 0];
		endcase
	end
	endfunction
	
endmodule
