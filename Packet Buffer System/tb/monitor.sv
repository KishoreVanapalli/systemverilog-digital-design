import packet_pkg::*;

class monitor;

    virtual packet_if vif;
    mailbox #(packet) mbx;

    function new(virtual packet_if vif, mailbox #(packet) mbx);
        this.vif = vif;
        this.mbx = mbx;
    endfunction

    task run();
        packet pkt;

        forever begin
            @(posedge vif.clk);

            if (vif.valid && vif.ready) begin
                pkt = new();
                pkt.data = vif.data;

                mbx.put(pkt);

                pkt.display("MONITOR");
            end
        end
    endtask

endclass