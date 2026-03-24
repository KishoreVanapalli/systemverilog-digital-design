import watchdog_pkg::*;

module tb_watchdog_timer;

    `include "coverage/watchdog_coverage.sv"

    logic clk;

    // Interface
    watchdog_if #(N) wif(clk);

    // DUT
    watchdog_timer dut (wif);

    // ✅ Bind assertions (correct scope + package param)
    bind watchdog_timer watchdog_assertions #(.N(watchdog_pkg::N)) wdg_assert_inst (
        .clk(clk),
        .rst(wif.rst),
        .kick(wif.kick),
        .timeout(wif.timeout),
        .counter(counter)
    );

    // Coverage
    watchdog_coverage cov;

    initial begin
        cov = new(clk, wif.rst, wif.kick, wif.timeout, dut.counter);
    end

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Reset
        wif.cb.rst <= 1;
        wif.cb.kick <= 0;
        #10;
        wif.cb.rst <= 0;

        // Case 1: Timeout
        repeat(10) @(posedge clk);

        // Case 2: Kick before timeout
        wif.cb.kick <= 1;
        @(posedge clk);
        wif.cb.kick <= 0;

        repeat(5) @(posedge clk);

        // Case 3: Edge case
        repeat(6) @(posedge clk);
        wif.cb.kick <= 1;
        @(posedge clk);
        wif.cb.kick <= 0;

        repeat(10) @(posedge clk);

        $finish;
    end

endmodule