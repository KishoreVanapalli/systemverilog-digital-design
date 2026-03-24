interface bus_if (input logic clk,rst);
    logic enb;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic tx;
    logic tx_en;
    logic rx_en;

    modport baud_rate_generater (
        input clk,rst,
        output tx_en,rx_en
    );

    modport transmitter (
        input clk,rst,enb,data_in,tx_en,
        output tx
    );

    modport recevier (
        input clk,rst,enb,tx,rx_en,
        output data_out
    );

endinterface
