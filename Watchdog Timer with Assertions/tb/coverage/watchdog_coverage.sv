class watchdog_coverage;

    logic clk;
    logic rst;
    logic kick;
    logic timeout;
    logic [3:0] counter;

    covergroup cg @(posedge clk);

        reset_cp: coverpoint rst;

        timeout_cp: coverpoint timeout {
            bins triggered = {1};
        }

        kick_cp: coverpoint kick;

        counter_cp: coverpoint counter {
            bins low  = {[0:2]};
            bins mid  = {[3:5]};
            bins high = {[6:7]};
        }

        cross_kick_counter: cross kick_cp, counter_cp;
        cross_timeout_counter: cross timeout_cp, counter_cp;

    endgroup

    function new(logic clk,
                 logic rst,
                 logic kick,
                 logic timeout,
                 logic [3:0] counter);

        this.clk = clk;
        this.rst = rst;
        this.kick = kick;
        this.timeout = timeout;
        this.counter = counter;

        cg = new();
    endfunction

endclass