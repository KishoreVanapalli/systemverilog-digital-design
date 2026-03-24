module mem_bus_inf (
    bus_if bus
);
    
    cpu cpu_init(
        .cpu_mod(bus.cpu)
    );

    memory memory_init(
        .memory_mod(bus.memory)
    );

endmodule