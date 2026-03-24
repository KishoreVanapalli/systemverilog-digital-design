module rf_mp (
    bus_if.rf_mp rf
);
    
    logic [31:0] ram [15:0];

    always_ff @(posedge rf.clk or negedge rf.rst)
    begin
        if(!rf.rst) begin
            foreach (ram[i]) begin
                ram[i] <= 32'h0;
            end
        end else begin
            if(rf.w_port.en)begin
                ram[rf.w_port.addr] <= rf.w_port.data;
            end
        end
    end

    always_comb begin
        rf.read_data1 = ram[rf.read_addr1];
        rf.read_data2 = ram[rf.read_addr2];
    end

endmodule