import packet_pkg::*;

class scoreboard;

    mailbox #(packet) mbx;
    bit [31:0] queue[$];

    function new(mailbox #(packet) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        packet pkt;

        forever begin
            mbx.get(pkt);

            queue.push_back(pkt.data);

            $display("SCOREBOARD STORED: %0h", pkt.data);
        end
    endtask

endclass