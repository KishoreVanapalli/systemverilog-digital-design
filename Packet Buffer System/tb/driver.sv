import packet_pkg::*;

class driver;

    virtual packet_if vif;
    mailbox #(packet) mbx;

    function new(virtual packet_if vif, mailbox #(packet) mbx);
        this.vif = vif;
        this.mbx = mbx;
    endfunction

    task run();
        packet pkt;

        forever begin
            mbx.get(pkt);

            @(posedge vif.clk);

            vif.valid <= 1;
            vif.data  <= pkt.data;

            pkt.display("DRIVER");

            @(posedge vif.clk);
            vif.valid <= 0;
        end
    endtask

endclass