`timescale 1ns/1ps
import packet_pkg::*;

module tb_top;

    logic clk;
    packet_if intf(clk);

    env e;

    // FIFO wiring
    logic rst;
    logic [31:0] fifo_out;
    logic full, empty;

    fifo fifo_inst (
        .clk(clk),
        .rst(rst),
        .wr_en(intf.valid),
        .rd_en(!empty),
        .din(intf.data),
        .dout(fifo_out),
        .full(full),
        .empty(empty)
    );

    assign intf.ready = !full;

    packet_proc proc_inst(intf);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        #20 rst = 0;

        e = new(intf);
        e.run();

        repeat (50) begin
            packet pkt = new();
            assert(pkt.randomize());
            e.drv_mbx.put(pkt);
        end

        #500 $finish;
    end

endmodule