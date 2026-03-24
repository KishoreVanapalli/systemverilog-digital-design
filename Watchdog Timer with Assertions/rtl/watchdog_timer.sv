module watchdog_timer (
    watchdog_if.DUT wif
);
    import watchdog_pkg::*;

    counter_t counter;

    always_ff @(posedge wif.clk or posedge wif.rst) begin
        if (wif.rst) begin
            counter <= '0;
            wif.timeout <= 0;
        end 
        else if (wif.kick) begin
            counter <= '0;
            wif.timeout <= 0;
        end 
        else if (counter == watchdog_pkg::N - 1) begin
            wif.timeout <= 1;
        end 
        else begin
            counter <= counter + 1;
            wif.timeout <= 0;
        end
    end

endmodule