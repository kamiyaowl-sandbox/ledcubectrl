`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:53:30 03/01/2016 
// Design Name: 
// Module Name:    spi_if 
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
module spi_if(
    input  SPI_CS,
    input  SPI_CLK,
    output SPI_MOSI,
    input  SPI_MISO,
	 
	 input  RESET,
    output reg BRAM_WE,
    output reg BRAM_EN,
    output reg [9:0]  BRAM_ADDR,
    inout [23:0] BRAM_DATA
    );
	localparam BRAM_ADDR_MAX = 10'd1024;
	reg [4:0] transfer_count;
	reg write_en;
	reg receive_addr;
	 
	always @ (negedge SPI_CLK) begin
		if(SPI_CS == 1'b0) begin
			if(receive_addr == 1'b0) begin
				case(transfer_count)
					5'd0  : write_en <= SPI_MOSI;
					5'd1  : ;
					5'd2  : ;
					5'd3  : ;
					5'd4  : ;
					5'd5  : ;
					5'd6  : BRAM_ADDR[9] <= SPI_MOSI;
					5'd7  : BRAM_ADDR[8] <= SPI_MOSI;
					5'd8  : BRAM_ADDR[7] <= SPI_MOSI;
					5'd9  : BRAM_ADDR[6] <= SPI_MOSI;
					5'd10 : BRAM_ADDR[5] <= SPI_MOSI;
					5'd11 : BRAM_ADDR[4] <= SPI_MOSI;
					5'd12 : BRAM_ADDR[3] <= SPI_MOSI;
					5'd13 : BRAM_ADDR[2] <= SPI_MOSI;
					5'd14 : BRAM_ADDR[1] <= SPI_MOSI;
					5'd15 : begin
							  BRAM_ADDR[0] <= SPI_MOSI; 
							  receive_addr <= 1'b1;
							  /* Read */
							  if(write_en == 1'b0) begin
									BRAM_WE <= 1'b0;
									BRAM_EN <= 1'b1;
							  end
						end
					default : ;
				endcase
				//count up
				if(transfer_count < 5'd15) transfer_count <= transfer_count + 5'b1;
				else transfer_count <= 5'b0;
			end else if(write_en == 1'b0) begin
				/* Read */
				case(transfer_count)
					5'd0  : SPI_MISO <= BRAM_DATA[23];
					5'd1  : SPI_MISO <= BRAM_DATA[22];
					5'd2  : SPI_MISO <= BRAM_DATA[21];
					5'd3  : SPI_MISO <= BRAM_DATA[20];
					5'd4  : SPI_MISO <= BRAM_DATA[19];
					5'd5  : SPI_MISO <= BRAM_DATA[18];
					5'd6  : SPI_MISO <= BRAM_DATA[17];
					5'd7  : SPI_MISO <= BRAM_DATA[16];
					5'd8  : SPI_MISO <= BRAM_DATA[15];
					5'd9  : SPI_MISO <= BRAM_DATA[14];
					5'd10 : SPI_MISO <= BRAM_DATA[13];
					5'd11 : SPI_MISO <= BRAM_DATA[12];
					5'd12 : SPI_MISO <= BRAM_DATA[11];
					5'd13 : SPI_MISO <= BRAM_DATA[10];
					5'd14 : SPI_MISO <= BRAM_DATA[ 9];
					5'd15 : SPI_MISO <= BRAM_DATA[ 8];
					5'd16 : SPI_MISO <= BRAM_DATA[ 7];
					5'd17 : SPI_MISO <= BRAM_DATA[ 6];
					5'd18 : SPI_MISO <= BRAM_DATA[ 5];
					5'd19 : SPI_MISO <= BRAM_DATA[ 4];
					5'd20 : SPI_MISO <= BRAM_DATA[ 3];
					5'd21 : SPI_MISO <= BRAM_DATA[ 2];
					5'd22 : SPI_MISO <= BRAM_DATA[ 1];
					5'd23 : begin 
							  SPI_MISO <= BRAM_DATA[ 0];
							  //auto increment addr
							  if(BRAM_ADDR < BRAM_ADDR_MAX) BRAM_ADDR <= BRAM_ADDR + 10'b1;
							  else BRAM_ADDR <= 10'b0;
						end
					default : ;
				endcase
				//count up
				if(transfer_count < 5'd23) transfer_count <= transfer_count + 5'b1;
				else transfer_count <= 5'b0;			
			end else begin
				/* Write */
				case(transfer_count)
					5'd0  : SPI_MISO <= BRAM_DATA[23];
					5'd1  : SPI_MISO <= BRAM_DATA[22];
					5'd2  : SPI_MISO <= BRAM_DATA[21];
					5'd3  : SPI_MISO <= BRAM_DATA[20];
					5'd4  : SPI_MISO <= BRAM_DATA[19];
					5'd5  : SPI_MISO <= BRAM_DATA[18];
					5'd6  : SPI_MISO <= BRAM_DATA[17];
					5'd7  : SPI_MISO <= BRAM_DATA[16];
					5'd8  : SPI_MISO <= BRAM_DATA[15];
					5'd9  : SPI_MISO <= BRAM_DATA[14];
					5'd10 : SPI_MISO <= BRAM_DATA[13];
					5'd11 : SPI_MISO <= BRAM_DATA[12];
					5'd12 : SPI_MISO <= BRAM_DATA[11];
					5'd13 : SPI_MISO <= BRAM_DATA[10];
					5'd14 : SPI_MISO <= BRAM_DATA[ 9];
					5'd15 : SPI_MISO <= BRAM_DATA[ 8];
					5'd16 : SPI_MISO <= BRAM_DATA[ 7];
					5'd17 : SPI_MISO <= BRAM_DATA[ 6];
					5'd18 : SPI_MISO <= BRAM_DATA[ 5];
					5'd19 : SPI_MISO <= BRAM_DATA[ 4];
					5'd20 : SPI_MISO <= BRAM_DATA[ 3];
					5'd21 : SPI_MISO <= BRAM_DATA[ 2];
					5'd22 : SPI_MISO <= BRAM_DATA[ 1];
					5'd23 : begin 
							  SPI_MISO <= BRAM_DATA[ 0];
							  //auto increment addr
							  if(BRAM_ADDR < BRAM_ADDR_MAX) BRAM_ADDR <= BRAM_ADDR + 10'b1;
							  else BRAM_ADDR <= 10'b0;
						end
					default : ;
				endcase
				//count up
				if(transfer_count < 5'd23) transfer_count <= transfer_count + 5'b1;
				else transfer_count <= 5'b0;	
			end
		end else begin
			//Disable
			transfer_count <= 5'b0;
			write_en <= 1'b0;
			receive_addr <= 1'b0;
			BRAM_WE <= 1'b0;
			BRAM_EN <= 1'b0;
			BRAM_ADDR <= 10'b0;
			BRAM_DATA <= 24'b0;
		end		
	end

endmodule
