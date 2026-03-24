package watchdog_pkg;

    parameter int N = 8;
    parameter int COUNTER_WIDTH = $clog2(N) + 1;

    typedef logic [COUNTER_WIDTH-1:0] counter_t;

endpackage