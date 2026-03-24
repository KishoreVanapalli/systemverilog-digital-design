module tb_mem_system;
    import inif_packages::*; // Ensure constants like ADDR_WIDTH are available

    // 1. Clock and Reset Signals
    bit clk;
    bit rst;

    // 2. Generate Clock (10ns period = 100MHz)
    always #5 clk = ~clk;

    // 3. Instantiate the Interface
    bus_if bus_inst(clk, rst);

    // 4. Instantiate the Top-Level Design (DUT)
    // Connects the interface to the module port
    mem_bus_inf dut (
        .bus(bus_inst)
    );

    // 5. Stimulus Block
    initial begin
        // Initialize Reset
        rst = 0;
        #20 rst = 1; // Release reset after 2 cycles
        
        // Let the simulation run to observe CPU <-> Memory interaction
        // The CPU logic you provided will automatically start reading/writing
        #500;
        
        $display("Simulation complete at %0t", $time);
        $finish;
    end

    // 6. Monitor for Debugging
    // Automatically prints whenever signals change
    initial begin
        $monitor("Time: %0t | Addr: %h | WR: %b | Data_In: %h | RD: %b | Data_Out: %h | Ready: %b", 
                 $time, bus_inst.addr, bus_inst.write, bus_inst.write_data, 
                 bus_inst.read, bus_inst.read_data, bus_inst.ready);
    end

    // 7. (Optional) Waveform Dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mem_system);
    end

endmodule

