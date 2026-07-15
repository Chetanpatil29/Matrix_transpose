`timescale 1ns / 1ps

module transpose_controller(
    input wire clk,
    input wire rst,
    input wire start,
    input wire transpose_done,

    output reg load_en,
    output reg transpose_en,
    output reg store_en,
    output reg done
);

//-----------------------------------------------------
// State Encoding
//-----------------------------------------------------
parameter IDLE      = 3'b000;
parameter LOAD      = 3'b001;
parameter TRANSPOSE = 3'b010;
parameter STORE     = 3'b011;
parameter FINISH    = 3'b100;

//-----------------------------------------------------
// State Registers
//-----------------------------------------------------
reg [2:0] current_state;
reg [2:0] next_state;

//-----------------------------------------------------
// State Register
//-----------------------------------------------------
always @(posedge clk or posedge rst)
begin
    if(rst)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

//-----------------------------------------------------
// Next-State Logic
//-----------------------------------------------------
always @(*)
begin

    case(current_state)

        //---------------------------------------------
        IDLE
        //---------------------------------------------
        IDLE:
        begin
            if(start)
                next_state = LOAD;
            else
                next_state = IDLE;
        end

        //---------------------------------------------
        LOAD
        //---------------------------------------------
        LOAD:
        begin
            next_state = TRANSPOSE;
        end

        //---------------------------------------------
        TRANSPOSE
        //---------------------------------------------
        TRANSPOSE:
        begin
            if(transpose_done)
                next_state = STORE;
            else
                next_state = TRANSPOSE;
        end

        //---------------------------------------------
        STORE
        //---------------------------------------------
        STORE:
        begin
            next_state = FINISH;
        end

        //---------------------------------------------
        FINISH
        //---------------------------------------------
        FINISH:
        begin
            next_state = IDLE;
        end

        default:
            next_state = IDLE;

    endcase

end

//-----------------------------------------------------
// Output Logic
//-----------------------------------------------------
always @(*)
begin

    load_en = 0;
    transpose_en = 0;
    store_en = 0;
    done = 0;

    case(current_state)

        IDLE:
        begin
            // No operation
        end

        LOAD:
        begin
            load_en = 1;
        end

        TRANSPOSE:
        begin
            transpose_en = 1;
        end

        STORE:
        begin
            store_en = 1;
        end

        FINISH:
        begin
            done = 1;
        end

    endcase

end

endmodule
