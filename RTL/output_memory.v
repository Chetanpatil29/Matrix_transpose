`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project : Matrix Transpose on FPGA
// Module  : output_memory
//////////////////////////////////////////////////////////////////////////////////

module output_memory #(parameter DATA_WIDTH = 8,
                       parameter DEPTH = 16)
(
    input wire clk,
    input wire rst,
    input wire write_en,
    input wire [3:0] address,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

integer i;

//--------------------------------------------------
// Write & Reset
//--------------------------------------------------
always @(posedge clk)
begin

    if(rst)
    begin

        for(i=0;i<DEPTH;i=i+1)
            memory[i] <= 8'd0;

    end

    else if(write_en)

        memory[address] <= data_in;

end

//--------------------------------------------------
// Read
//--------------------------------------------------
always @(*)
begin

    data_out = memory[address];

end

endmodule
