module cpu (
    bus_if.cpu cpu_mod // Uses the 'cpu' modport
);
    int data1;
    logic [31:0] data2; // Assuming 32-bit data

    always_ff @(posedge cpu_mod.clk or negedge cpu_mod.rst) begin
        if(!cpu_mod.rst) begin
            cpu_mod.write_data <= 0;
            cpu_mod.write      <= 0;
            cpu_mod.read       <= 0;
            cpu_mod.addr       <= 0;
        end else begin
            if (cpu_mod.ready) begin
                cpu_mod.read <= 1;
                data1        <= cpu_mod.read_data;
            end else begin
                cpu_mod.write_data <= data2;
                cpu_mod.write      <= 1;
            end
        end
    end
    
    always_comb begin
        data2 = ~data1; // Removed 'assign' keyword
    end
endmodule


