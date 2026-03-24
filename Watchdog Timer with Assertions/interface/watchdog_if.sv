interface watchdog_if #(parameter int N = watchdog_pkg::N) (input logic clk);

    logic rst;
    logic kick;
    logic timeout;

    clocking cb @(posedge clk);
        output rst;
        output kick;
        input  timeout;
    endclocking

    modport DUT (
        input  clk,
        input  rst,
        input  kick,
        output timeout
    );

    modport TB (
        clocking cb,
        input clk
    );

endinterface