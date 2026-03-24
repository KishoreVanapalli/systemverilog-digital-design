interface packet_if(input logic clk);

    logic valid;
    logic ready;
    logic [31:0] data;

endinterface