import fifo_pkg::*;

class env;

    driver d;
    monitor m;
    scoreboard s;

    mailbox #(transaction) drv_mbx;
    mailbox #(transaction) mon_mbx;

    function new(virtual fifo_if vif);
        drv_mbx = new();
        mon_mbx = new();

        d = new(vif, drv_mbx);
        m = new(vif, mon_mbx);
        s = new(mon_mbx);
    endfunction

    task run();
        fork
            d.run();
            m.run();
            s.run();
        join_none
    endtask

endclass