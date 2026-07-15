`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Project : Matrix Transpose on FPGA
// Module  : address_generator
//////////////////////////////////////////////////////////////////////////////////

module address_generator #(parameter N = 4)
(
    input wire clk,
    input wire rst,
    input wire enable,

    output reg [3:0] input_addr,
    output reg [3:0] output_addr,

    output reg done
);

reg [2:0] row;
reg [2:0] col;

//----------------------------------------------------
// Address Generation
//----------------------------------------------------
always @(posedge clk)
begin

    if(rst)
    begin

        row <= 0;
        col <= 0;

        input_addr <= 0;
        output_addr <= 0;

        done <= 0;

    end

    else if(enable)

    begin

        //-----------------------------
        // Address Calculation
        //-----------------------------
        input_addr  <= row*N + col;
        output_addr <= col*N + row;

        //-----------------------------
        // Matrix Traversal
        //-----------------------------
        if(col == N-1)
        begin

            col <= 0;

            if(row == N-1)
            begin

                row <= 0;
                done <= 1;

            end

            else

                row <= row + 1;

        end

        else

            col <= col + 1;

    end

end

endmodule
