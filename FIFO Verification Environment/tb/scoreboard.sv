import fifo_pkg::*;

class scoreboard;

    mailbox #(transaction) mbx;

    bit [7:0] queue[$];

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        transaction tr;

        forever begin
            mbx.get(tr);

            if (tr.write) begin
                queue.push_back(tr.data);
            end

            if (tr.read) begin
                if (queue.size() == 0) begin
                    $error("UNDERFLOW!");
                end else begin
                    bit [7:0] exp = queue.pop_front();

                    if (exp !== tr.data)
                        $error("MISMATCH: EXP=%0h ACT=%0h", exp, tr.data);
                    else
                        $display("MATCH OK: %0h", exp);
                end
            end
        end
    endtask

endclass
