import fifo_pkg::*;

class driver;

    virtual fifo_if vif;
    mailbox #(transaction) mbx;

    function new(virtual fifo_if vif, mailbox #(transaction) mbx);
        this.vif = vif;
        this.mbx = mbx;
    endfunction

    task run();
        transaction tr;

        forever begin
            mbx.get(tr);

            @(posedge vif.clk);

            vif.wr_en <= tr.write;
            vif.rd_en <= tr.read;
            vif.din   <= tr.data;

            tr.display("DRIVER");

            @(posedge vif.clk);

            vif.wr_en <= 0;
            vif.rd_en <= 0;
        end
    endtask

endclass