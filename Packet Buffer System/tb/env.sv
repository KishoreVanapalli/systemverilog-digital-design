import packet_pkg::*;

class env;

    driver d;
    monitor m;
    scoreboard s;

    mailbox #(packet) drv_mbx;
    mailbox #(packet) mon_mbx;

    function new(virtual packet_if vif);
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