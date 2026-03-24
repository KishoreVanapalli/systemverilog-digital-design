interface fifo_if(input logic clk);

    logic rst;
    logic wr_en, rd_en;
    logic [7:0] din;
    logic [7:0] dout;
    logic full, empty;

endinterface