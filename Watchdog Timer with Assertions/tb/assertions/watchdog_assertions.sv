module watchdog_assertions #(parameter int N = 8)(
    input logic clk,
    input logic rst,
    input logic kick,
    input logic timeout,
    input logic [$clog2(N):0] counter
);

    // Counter never exceeds limit
    property p_counter_limit;
        @(posedge clk) disable iff (rst)
        counter < N;
    endproperty
    assert property (p_counter_limit);

    // Reset clears
    property p_reset_clear;
        @(posedge clk)
        rst |-> (counter == 0 && timeout == 0);
    endproperty
    assert property (p_reset_clear);

    // Timeout only at limit
    property p_timeout_at_limit;
        @(posedge clk) disable iff (rst)
        timeout |-> (counter == N-1);
    endproperty
    assert property (p_timeout_at_limit);

    // Kick prevents timeout
    property p_no_timeout_if_kick;
        @(posedge clk) disable iff (rst)
        kick |-> ##[1:$] !timeout;
    endproperty
    assert property (p_no_timeout_if_kick);

endmodule