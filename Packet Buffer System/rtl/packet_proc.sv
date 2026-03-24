module packet_proc(packet_if intf);

    always_ff @(posedge intf.clk) begin
        if (intf.valid && intf.ready) begin
            $display("PROCESS: %0h at %0t", intf.data, $time);
        end
    end

endmodule