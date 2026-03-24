module dual_port (
    bus_if bus 
);
    
    rf_mp rf_inst (.rf(bus.rf_mp));
    
endmodule