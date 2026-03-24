package packet_pkg;

    class packet;

        rand bit [31:0] data;
        rand int length;

        constraint len_c {
            length inside {[1:5]};
        }

        function void display(string tag);
            $display("[%s] DATA=%0h LEN=%0d", tag, data, length);
        endfunction

    endclass

endpackage