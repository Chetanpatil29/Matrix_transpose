`timescale 1ns / 1ps

module matrix_transpose_top(
    input clk,
    input rst,
    input start,
    output reg done
);

parameter N = 4;

reg [7:0] input_mem [0:15];
reg [7:0] output_mem [0:15];

reg [2:0] state;

reg [2:0] row;
reg [2:0] col;

parameter IDLE      = 3'b000,
          LOAD      = 3'b001,
          TRANSPOSE = 3'b010,
          STORE     = 3'b011,
          FINISH    = 3'b100;

integer i;

always @(posedge clk)
begin

    if(rst)
    begin

        state <= IDLE;

        row <= 0;
        col <= 0;

        done <= 0;

        for(i=0;i<16;i=i+1)
        begin
            input_mem[i] <= 0;
            output_mem[i] <= 0;
        end

    end

    else

    begin

        case(state)

        //---------------------------------------------------
        IDLE:
        //---------------------------------------------------
        begin

            done <= 0;

            if(start)
                state <= LOAD;

        end

        //---------------------------------------------------
        LOAD
        //---------------------------------------------------
        begin

            input_mem[0]  <= 8'd1;
            input_mem[1]  <= 8'd2;
            input_mem[2]  <= 8'd3;
            input_mem[3]  <= 8'd4;

            input_mem[4]  <= 8'd5;
            input_mem[5]  <= 8'd6;
            input_mem[6]  <= 8'd7;
            input_mem[7]  <= 8'd8;

            input_mem[8]  <= 8'd9;
            input_mem[9]  <= 8'd10;
            input_mem[10] <= 8'd11;
            input_mem[11] <= 8'd12;

            input_mem[12] <= 8'd13;
            input_mem[13] <= 8'd14;
            input_mem[14] <= 8'd15;
            input_mem[15] <= 8'd16;

            row <= 0;
            col <= 0;

            state <= TRANSPOSE;

        end

        //---------------------------------------------------
        TRANSPOSE
        //---------------------------------------------------
        begin

            output_mem[col*N + row]
                    <= input_mem[row*N + col];

            if(col == N-1)
            begin

                col <= 0;

                if(row == N-1)

                    state <= STORE;

                else

                    row <= row + 1;

            end

            else

                col <= col + 1;

        end

        //---------------------------------------------------
        STORE
        //---------------------------------------------------
        begin

            state <= FINISH;

        end

        //---------------------------------------------------
        FINISH
        //---------------------------------------------------
        begin

            done <= 1;

            state <= IDLE;

        end

        endcase

    end

end

endmodule
