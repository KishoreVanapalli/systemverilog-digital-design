module packet_gen(packet_if intf);

    always_ff @(posedge intf.clk) begin
        intf.valid <= $urandom_range(0,1);
        intf.data  <= $urandom;
    end

endmodule