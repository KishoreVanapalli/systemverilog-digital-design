module uart (
    input logic clk,
    input logic rst
);

    bus_if uart_if (
        .clk(clk),
        .rst(rst)
    );      

    baud_rate_generater u_baud (
        .baud(uart_if.baud_rate_generater)
    );

    transmitter u_tx (
        .trans(uart_if.transmitter)
    );

    recevier u_rx (
        .recs(uart_if.recevier)
    );

endmodule

