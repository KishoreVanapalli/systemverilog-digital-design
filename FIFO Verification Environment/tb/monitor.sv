import fifo_pkg::*;

class monitor;

    virtual fifo_if vif;
    mailbox #(transaction) mbx;

    function new(virtual fifo_if vif, mailbox #(transaction) mbx);
        this.vif = vif;
        this.mbx = mbx;
    endfunction

    task run();
        transaction tr;

        forever begin
            @(posedge vif.clk);

            tr = new();
            tr.write = vif.wr_en;
            tr.read  = vif.rd_en;
            tr.data  = vif.dout;

            mbx.put(tr);

            tr.display("MONITOR");
        end
    endtask

endclass