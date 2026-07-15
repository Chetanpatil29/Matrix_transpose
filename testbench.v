`timescale 1ns/1ps

module matrix_transpose_tb;

reg clk;
reg rst;
reg start;

wire done;

//---------------------------------------------------------
// Instantiate DUT
//---------------------------------------------------------
matrix_transpose_top DUT
(
    .clk(clk),
    .rst(rst),
    .start(start),
    .done(done)
);

//---------------------------------------------------------
// Clock Generation
//---------------------------------------------------------
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

//---------------------------------------------------------
// Stimulus
//---------------------------------------------------------
initial
begin

    rst = 1;
    start = 0;

    #20;
    rst = 0;

    #10;
    start = 1;

    #10;
    start = 0;

    wait(done);

    #20;

    $display("\n====================================");
    $display(" MATRIX TRANSPOSE COMPLETED ");
    $display("====================================");

    $display("\nInput Matrix\n");

    $display("%d %d %d %d",
        DUT.input_mem[0],
        DUT.input_mem[1],
        DUT.input_mem[2],
        DUT.input_mem[3]);

    $display("%d %d %d %d",
        DUT.input_mem[4],
        DUT.input_mem[5],
        DUT.input_mem[6],
        DUT.input_mem[7]);

    $display("%d %d %d %d",
        DUT.input_mem[8],
        DUT.input_mem[9],
        DUT.input_mem[10],
        DUT.input_mem[11]);

    $display("%d %d %d %d",
        DUT.input_mem[12],
        DUT.input_mem[13],
        DUT.input_mem[14],
        DUT.input_mem[15]);



    $display("\nTransposed Matrix\n");

    $display("%d %d %d %d",
        DUT.output_mem[0],
        DUT.output_mem[1],
        DUT.output_mem[2],
        DUT.output_mem[3]);

    $display("%d %d %d %d",
        DUT.output_mem[4],
        DUT.output_mem[5],
        DUT.output_mem[6],
        DUT.output_mem[7]);

    $display("%d %d %d %d",
        DUT.output_mem[8],
        DUT.output_mem[9],
        DUT.output_mem[10],
        DUT.output_mem[11]);

    $display("%d %d %d %d",
        DUT.output_mem[12],
        DUT.output_mem[13],
        DUT.output_mem[14],
        DUT.output_mem[15]);

    #20;

    $finish;

end

//---------------------------------------------------------
// Monitor
//---------------------------------------------------------
initial
begin

$monitor("Time=%0t | State=%d | Done=%b",
          $time,
          DUT.state,
          done);

end

//---------------------------------------------------------
// Waveform Dump
//---------------------------------------------------------
initial
begin
    $dumpfile("matrix_transpose.vcd");
    $dumpvars(0,matrix_transpose_tb);
end

endmodule
