module memory (
    bus_if.memory memory_mod
);
    import inif_packages::*;
    
    // Fixed RAM declaration: [Width] name [Depth]
    logic [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

    always_ff @(posedge memory_mod.clk or negedge memory_mod.rst) begin
        if (!memory_mod.rst) begin
            memory_mod.ready <= 0;
            memory_mod.read_data <= 0;
        end else begin
            // Default state
            memory_mod.ready <= 0;

            if (memory_mod.write) begin
                ram[memory_mod.addr] <= memory_mod.write_data;
                memory_mod.ready     <= 1; // Indicate write is done
            end 
            else if (memory_mod.read) begin
                memory_mod.read_data <= ram[memory_mod.addr];
                memory_mod.ready     <= 1; // Indicate data is valid
            end
        end
    end
endmodule
