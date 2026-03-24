package fifo_pkg;

    class transaction;

        rand bit write;
        rand bit read;
        rand bit [7:0] data;

        constraint valid_ops {
            !(write && read); // avoid simultaneous for now
        }

        function void display(string tag);
            $display("[%s] W=%0d R=%0d DATA=%0h",
                tag, write, read, data);
        endfunction

    endclass

endpackage