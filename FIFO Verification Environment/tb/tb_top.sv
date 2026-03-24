`timescale 1ns/1ps
import fifo_pkg::*;

module tb_top;

    logic clk;
    fifo_if fifo_if_inst(clk);

    env e;

    fifo dut (
        .clk(clk),
        .rst(fifo_if_inst.rst),
        .wr_en(fifo_if_inst.wr_en),
        .rd_en(fifo_if_inst.rd_en),
        .din(fifo_if_inst.din),
        .dout(fifo_if_inst.dout),
        .full(fifo_if_inst.full),
        .empty(fifo_if_inst.empty)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        fifo_if_inst.rst = 1;

        #20 fifo_if_inst.rst = 0;

        e = new(fifo_if_inst);
        e.run();

        // Generate transactions
        repeat (50) begin
            transaction tr = new();
            assert(tr.randomize());
            e.drv_mbx.put(tr);
        end

        #500 $finish;
    end

endmodule
